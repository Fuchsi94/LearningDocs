# Kubernetes Cluster Architecture

![alt text](../Screenshot%202024-08-08%20at%2018.40.19.png)

## Control Plane Components

1. **etcd**

   - **Description**: A consistent and highly-available key-value store used as Kubernetes' backing store for all cluster data.
   - **Role**: Stores configuration data that can be accessed by each of the nodes in the cluster.

2. **kube-apiserver**

   - **Description**: The API server is a component of the Kubernetes control plane that exposes the Kubernetes API.
   - **Role**: It serves as the frontend for the Kubernetes control plane. It is the only component that communicates directly with the etcd datastore.

3. **kube-scheduler**

   - **Description**: The scheduler is responsible for assigning nodes to the newly created pods.
   - **Role**: It watches for newly created pods with no assigned node and selects a node for them to run on based on resource availability.

4. **kube-controller-manager**

   - **Description**: This component runs controllers, which are background threads that handle routine tasks.
   - **Role**: Controllers include node controller, replication controller, endpoints controller, and others, each handling specific tasks to ensure the cluster's desired state.

5. **cloud-controller-manager**
   - **Description**: Allows the Kubernetes cluster to interact with the cloud provider's API to manage cloud services.
   - **Role**: It manages cloud-specific control logic, such as managing load balancers, handling node lifecycle events, and managing storage volumes.

## Node Components

1. **kubelet**

   - **Description**: An agent that runs on each node in the cluster.
   - **Role**: Ensures that containers are running in a pod. The kubelet takes a set of PodSpecs and ensures that the described containers are running and healthy.

2. **kube-proxy**

   - **Description**: A network proxy that runs on each node in your cluster.
   - **Role**: It maintains network rules on nodes and enables communication to your pods from network sessions inside or outside of your cluster.

3. **Container Runtime**
   - **Description**: The software responsible for running containers.
   - **Role**: Kubernetes supports several container runtimes: Docker, containerd, CRI-O, etc. It is the component that executes and manages containers.

## Additional Components

1. **Pods**

   - **Description**: The smallest and simplest Kubernetes object. A pod represents a set of running containers on your cluster.
   - **Role**: Pods can contain one or more containers, and they share the network namespace, meaning they can communicate with each other directly.

2. **Namespaces**

   - **Description**: A way to divide cluster resources between multiple users.
   - **Role**: Useful for environments with many users spread across different teams or projects, providing a scope for names.

3. **ReplicaSets**

   - **Description**: Ensures that a specified number of pod replicas are running at any given time.
   - **Role**: It is responsible for maintaining the stable set of pod replicas and can be used directly or by Deployments.

4. **Deployments**

   - **Description**: Provides declarative updates to applications.
   - **Role**: Manages ReplicaSets and provides rollback capabilities, enabling updates to the state of Pods and ReplicaSets.

5. **Services**

   - **Description**: An abstract way to expose an application running on a set of Pods as a network service.
   - **Role**: Services allow your applications to receive traffic, with different types like ClusterIP, NodePort, and LoadBalancer.

6. **ConfigMaps**

   - **Description**: Provides a way to inject configuration data into Pods.
   - **Role**: Decouple configuration artifacts from image content to keep containerized applications portable.

7. **Secrets**

   - **Description**: Similar to ConfigMaps but specifically intended to hold sensitive information.
   - **Role**: Manages sensitive data such as passwords, OAuth tokens, and ssh keys.

8. **Ingress**

   - **Description**: A collection of rules that allow inbound connections to reach the cluster services.
   - **Role**: Configures access to cluster services from outside the Kubernetes cluster, typically HTTP/S.

9. **Volumes**

   - **Description**: A directory accessible to containers in a pod.
   - **Role**: Kubernetes supports several types of volumes like emptyDir, hostPath, and persistent volumes, each with different characteristics.

10. **Persistent Volumes (PV) and Persistent Volume Claims (PVC)**
    - **Description**: PVs are storage resources in the cluster, and PVCs are requests for storage by a user.
    - **Role**: They provide a way to dynamically or statically provision storage to pods in a cluster.

## Conclusion

Kubernetes architecture is designed to ensure that applications are efficiently deployed, scaled, and managed. Each component plays a critical role in maintaining the cluster's functionality, resilience, and scalability.
