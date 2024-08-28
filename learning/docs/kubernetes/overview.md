# Kubernetes Overview

Kubernetes, often abbreviated as K8s, is an open-source platform designed to automate deploying, scaling, and operating containerized applications. Originally developed by Google, it is now maintained by the Cloud Native Computing Foundation (CNCF). Kubernetes provides a framework to run distributed systems resiliently, managing the lifecycle of containers across a cluster of machines.

## How Kubernetes Works

Kubernetes orchestrates containers across multiple hosts, providing a unified interface for managing them. It abstracts the underlying infrastructure, allowing developers and operators to focus on application logic and policies rather than the specifics of the environment. Here's a simplified breakdown of how it works:

## Kubernetes Components

### Container & Pods

- Container: A lightweight, portable, and self-sufficient software package that includes the application code and all its dependencies.
- Pod: The smallest deployable unit in Kubernetes, which can consist of one or more containers. Containers in the same Pod share the same network namespace and can communicate with each other easily.

### Nodes & Clusters

- Node: A worker machine in Kubernetes, which can be either a physical or virtual machine. Each Node runs at least one container runtime (like Docker) and the necessary Kubernetes components.
- Cluster: A set of Nodes that Kubernetes manages. The cluster is the environment where your applications run.

### Control Plane Components:

- API Server: The core of Kubernetes' control plane, it exposes the Kubernetes API and is the entry point for all administrative tasks.
- Scheduler: Watches for new Pods with no assigned Node and assigns them to a Node based on resource requirements and policies.
- Controller Manager: A daemon that runs various controllers to handle routine tasks like scaling, rolling updates, and health checks.
- etcd: A key-value store that Kubernetes uses to store all cluster data. It acts as the brain of Kubernetes, keeping track of the state of the cluster.

### Node Components:

- kubelet: An agent that runs on each Node. It ensures that containers are running in a Pod and communicates with the Kubernetes API server.
- Kube-Proxy: A network proxy that runs on each Node, managing networking rules for Pods and providing service discovery and load balancing.
- Container Runtime: The software responsible for running the containers. While Docker is a common runtime, Kubernetes supports other runtimes such as containerd and CRI-O.
  Reasons to Use Kubernetes

### Reasons to Use Kubernetes

- Scalability: Automatically scale your applications up and down based on demand.
- Portability: Run applications in a consistent environment across different environments like on-premises, public, or private cloud.
- Resilience: Kubernetes automatically replaces or reschedules containers when they fail, maintaining the desired state of your applications.
- Automated Rollouts and Rollbacks: Safely roll out changes to your application or configuration and roll back in case of failure.
- Efficient Resource Utilization: Kubernetes packs containers efficiently onto your Nodes, optimizing resource use.
- Self-Healing: Automatically restarts containers that fail, replaces and reschedules them, kills containers that don't respond to your user-defined health check, and doesn't advertise them to clients until they're ready to serve.

## Kubernetes Architecture Overview

Kubernetes follows a master-worker architecture:

### Master Node (Control Plane):

- Manages the cluster and coordinates activities like scheduling, scaling, and updates.
- Key components include the API Server, Scheduler, Controller Manager, and etcd.

### Worker Nodes:

- Run applications in Pods, manage container runtime, and facilitate networking.
- Key components include the Kubelet, Kube-Proxy, and the Container Runtime.

### Kubernetes Objects:

- Pods: The basic deployable unit in Kubernetes, which can run one or more containers.
- Services: Abstracts the networking in Kubernetes, providing a stable IP address and DNS name for a set of Pods.
- Deployments: Provides declarative updates to Pods and ReplicaSets (which ensure a specified number of pod replicas are running at any given time).
- ConfigMaps/Secrets: Manage configuration data separately from container images.

### Networking:

Kubernetes abstracts away the complexities of networking. Pods can communicate with each other across Nodes, and Services provide a unified interface for accessing Pods.
Conclusion
