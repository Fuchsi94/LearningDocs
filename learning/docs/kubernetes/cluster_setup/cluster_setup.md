# Setting Up a Self-Managed Kubernetes Cluster on GCP with GCE

This guide provides step-by-step instructions for setting up a Kubernetes cluster on Google Cloud Platform (GCP) using Google Compute Engine (GCE). The cluster consists of one master node and two worker nodes. This setup is ideal for learning Kubernetes, testing, and small-scale deployments.

## 1. Setup GCP Infrastructure

Setting up the infrastructure on GCP is the foundation of your Kubernetes cluster. This involves creating virtual machines (VMs) that will serve as the nodes in your cluster. Terraform, an Infrastructure as Code (IaC) tool, is used to automate the creation and management of these resources, ensuring consistency, repeatability, and ease of modification.

### Step 1: Initialize Terraform

Initialize Terraform to download necessary plugins and prepare your working directory:

```bash
terraform init
terraform plan
terraform apply -auto-approve
terraform output > terraform-outputs.txt
This command sequence initializes Terraform, generates an execution plan, applies the plan to create resources, and then saves the outputs (such as VM IP addresses) to a file for later use.
```

## 2. Install Kubernetes Components

### Step 1: SSH into Each VM

SSH into each VM created by Terraform to install necessary components. Use the VM names from `terraform-outputs.txt`:

```bash
gcloud compute ssh --zone "europe-west6-a" "k8s-master" --project "codify-playground-yannick"
gcloud compute ssh --zone "europe-west6-a" "k8s-worker-1" --project "codify-playground-yannick"
gcloud compute ssh --zone "europe-west6-a" "k8s-worker-2" --project "codify-playground-yannick"
```

### Step 2: Install `containerd`

We will install `containerd`, which is the preferred container runtime for Kubernetes.

Ensure that necessary kernel modules are loaded:

```bash
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter
```

Configure sysctl parameters to meet Kubernetes networking requirements:

```bash
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward = 1
EOF


# Apply the sysctl parameters without rebooting:
sudo sysctl --system
```

These steps enable IP forwarding and ensure that bridged network traffic is properly processed by iptables.

Download the containerd binaries and extract them to `/usr/local`:

```bash
wget https://github.com/containerd/containerd/releases/download/v1.7.11/containerd-1.7.11-linux-amd64.tar.gz
sudo tar Cxzvf /usr/local containerd-1.7.11-linux-amd64.tar.gz
```

Generate the default configuration for `containerd`:

```bash
sudo mkdir /etc/containerd
containerd config default > config.toml
sudo cp config.toml /etc/containerd
```

Download the systemd service file for `containerd`, enable the service, and start it:

```bash
wget https://raw.githubusercontent.com/containerd/containerd/main/containerd.service
sudo cp containerd.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now containerd
```

Verify that containerd is running:

```bash
sudo systemctl status containerd
```

### Step 3: Install kubeadm, kubelet, and kubectl

Install the necessary Kubernetes components on all VMs (master and worker nodes):

```bash
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
sudo systemctl enable --now kubelet
```

### Step 4: Install runc

While containerd is the Container Runtime Interface (CRI), runc is the actual runtime used by containerd. Install it as follows:

```bash
wget https://github.com/opencontainers/runc/releases/download/v1.1.10/runc.amd64
sudo install -m 755 runc.amd64 /usr/local/sbin/runc
```

### Step 5: Install CNI Plugin for containerd

containerd requires a CNI plugin to manage network interfaces. Install the CNI plugins:

```bash
wget https://github.com/containernetworking/plugins/releases/download/v1.4.0/cni-plugins-linux-amd64-v1.4.0.tgz
sudo mkdir -p /opt/cni/bin
sudo tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.4.0.tgz
```

### Step 6: Configure containerd with Systemd Cgroup Driver

To ensure compatibility with Kubernetes, configure the systemd cgroup driver in the /etc/containerd/config.toml file. Set SystemdCgroup to true:

```bash
sudo vim /etc/containerd/config.toml
```

Locate the following section and update it:

```toml
[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]
  ...
    [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]
SystemdCgroup = true
```

After updating, restart containerd:

```bash
sudo systemctl restart containerd
sudo systemctl status containerd
```

### Step 7: Disable Swap

Kubernetes requires swap to be disabled:

```bash
sudo swapoff -a
```

## 3. Initialize the Kubernetes Control Plane

### Step 1: Initialize the Control Plane

Initialize the Kubernetes control plane on the k8s-master node:

```bash
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
```

This command sets up the control plane components (API server, scheduler, and controller manager) and configures the network with the specified CIDR range for pods.

### Step 2: Configure kubectl for the Master Node

Set up kubectl to manage the cluster from the master node:

```bash
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

### Step 3: Enable Shell Completion for kubectl

For a better command-line experience, enable shell completion for kubectl:

```bash
echo 'source <(kubectl completion bash)' >>~/.bashrc
source <(kubectl completion bash)
```

## 4. Join Worker Nodes to the Cluster

Step 1: Retrieve the Join Command
After initializing the control plane, retrieve the kubeadm join command to add worker nodes to the cluster:

bash
Copy code
kubeadm token create --print-join-command
Step 2: Join Worker Nodes
SSH into each worker node (k8s-worker-1 and k8s-worker-2) and run the kubeadm join command:

bash
Copy code
sudo kubeadm join <MASTER_IP>:6443 --token <TOKEN> --discovery-token-ca-cert-hash sha256:<HASH>
Replace <MASTER_IP>, <TOKEN>, and <HASH> with the actual values from the kubeadm join command.

## 5. Deploy a Pod Network

Step 1: Install a Pod Network Add-On
To enable communication between pods across different nodes, install a pod network add-on.

Option 1: Flannel
bash
Copy code
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
Wait a few moments for the network to be deployed across all nodes.

Option 2: Calico
Install the Tigera Operator:

bash
Copy code
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.27.0/manifests/tigera-operator.yaml
Download the default YAML spec for Calico:

bash
Copy code
wget https://raw.githubusercontent.com/projectcalico/calico/v3.27.0/manifests/custom-resources.yaml
Edit the spec to reflect the correct pod network CIDR:

bash
Copy code
vim custom-resources.yaml
Apply the configuration:

bash
Copy code
kubectl apply -f custom-resources.yaml

## 6. Verify the Cluster

Step 1: Check Node Status
Run the following command on the k8s-master to verify that all nodes have successfully joined the cluster and are in a Ready state:

bash
Copy code
kubectl get nodes
You should see all nodes (k8s-master, k8s-worker-1, k8s-worker-2) listed as Ready.

## 7. Deploy a Test Application

To test that your Kubernetes cluster is functioning properly, you can deploy a simple application:

bash
Copy code
kubectl create deployment nginx --image=nginx
Verify that the deployment is running:

bash
Copy code
kubectl get pods
Expose the deployment as a service:

bash
Copy code
kubectl expose deployment nginx --port=80 --type=NodePort
Check the service:

bash
Copy code
kubectl get svc
Access the application using the external IP of any worker node and the NodePort assigned to the service.
