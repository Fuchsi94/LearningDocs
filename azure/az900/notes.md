# Microsoft Azure Fundamentals (AZ-900)

## Storage and Data Management

- **Azure Blob Storage**: Object storage solution optimized for massive amounts of unstructured data.
- **Azure Files**: Serverless cloud file sharing system, accessible via SMB, NFS, or Azure Files REST API.
- **Azure File Sync**: Centralizes file shares in Azure Files.
- **Azure Data Box**: Physical migration service for transferring data via a Microsoft-provided physical device.
- **Azure Storage Explorer**: GUI-based app for managing files and blobs in Azure Storage Account.
- **Table Storage**: Non-relational structured data storage providing a key/attribute store with a schemaless design.
- **Queue Storage**: Storage for a large number of messages.
- **Geo-Redundant Storage (GRS)**: Replicates data in two regions in a locally redundant storage (LRS) manner.
- **Geo-Zone-Redundant Storage (GZRS)**: Replicates data across three availability zones in the primary region and in a second region.
- **Locally Redundant Storage (LRS)**: Replicates data three times within a single data center in the primary region.
- **Zone-Redundant Storage (ZRS)**: Replicates Azure Storage data across three Azure availability zones in the primary region.

## Identity and Security

- **Azure Active Directory (Azure AD)**: Cloud-based identity management with features like single sign-on (SSO), multi-factor authentication (MFA), and conditional access.
- **Azure Active Directory Domain Services**: Provides managed domain services.
- **Azure Advanced Threat Protection (ATP)**: Detects and investigates security incidents across networks.
- **Azure Security Center**: Monitors security configuration and health of workloads.
- **Azure Sentinel**: SIEM tool for responding to threats.
- **Azure Key Vault**: Manages secrets.
- **Azure Information Protection (AIP)**: Controls security properties of data, like classification.
- **Microsoft Defender for Cloud**: Provides cloud security posture management and threat protection.
- **Compliance Manager**: Tool to assess compliance requirements.

## Compute and Networking

- **Azure Virtual Machines (VMs)**: Virtual machines running on Azure.
- **Azure Virtual Network (vNet)**: Enables private network in Azure, allowing virtual machines to securely communicate.
- **Azure VPN Gateway**: Sends encrypted traffic between Azure virtual network and on-premises location.
- **Azure Bastion**: Provides remote access to virtual machines via a browser and Azure portal.
- **Azure Load Balancer**: Distributes incoming network traffic evenly.
- **Azure ExpressRoute**: Connects on-premises networks to Microsoft cloud via a connectivity provider.
- **Azure Container Instances**: Runs applications in containers without managing virtual machines.
- **Azure Kubernetes Service (AKS)**: Deploys and scales containers.
- **Availability Set**: Ensures maximum availability by logically grouping virtual machines.
- **Availability Zone**: Provides fault isolation within an Azure region.
- **Virtual Machine Scale Set**: Group of identical, load-balanced virtual machines.
- **Internal Load Balancer**: Balances traffic inside a virtual network.
- **Public Load Balancer**: Provides outbound connections for virtual machines inside a virtual network.

## Application Services and Development

- **Azure App Service**: HTTP-based service for hosting web applications, REST APIs, and mobile backends.
- **Azure Functions**: Event-driven, serverless compute service.
- **Azure DevOps**: Set of collaborative development tools built for the cloud.
- **Azure Pipelines**: Tool for continuous building, testing, and deploying.
- **Azure Repos**: Git repositories for source control.
- **Azure Resource Manager (ARM) Template**: Defines the infrastructure and configuration for a project.
- **Azure DevTest Labs**: Provides development and test environments with reusable templates and artifacts.
- **Azure Application Insights**: Monitors running applications, detects performance anomalies, and provides analytics tools.

## Monitoring and Management

- **Azure Monitor**: Collects, analyzes, and responds to telemetry from cloud and on-premises environments. Supports autoscaling.
- **Azure Log Analytics**: Tool for writing log queries on data gathered by Azure Monitor.
- **Azure Advisor**: Recommends optimizations for high availability, security, performance, operational excellence, and cost.
- **Azure Migrate**: Helps migrate from an on-premises environment to the cloud.
- **Azure Service Health**: Alerts for Azure service incidents and planned maintenance.
- **Azure Cost Management Tool**: Checks Azure resource costs, creates alerts based on resource spend, and automates management of resources.
- **Total Cost of Ownership (TCO) Calculator**: Calculates cost savings of operating a solution in Azure compared to on-premises.

## Specialized Services

- **Azure Arc**: Provides a consistent multi-cloud and on-premises management platform.
- **Azure Batch**: Large-scale job scheduling and compute management.
- **Azure Blueprints**: Defines a repeatable set of Azure resources adhering to organizational standards.
- **Azure CycleCloud**: Manages high-performance computing (HPC) environments.
- **Azure Sphere**: Internet of Things (IoT) device platform.
- **Azure VMware Solution**: Runs VMware workloads in Azure with seamless integration.
- **Azure Virtual Desktop**: Cloud-hosted version of Windows.

## General Concepts

- **Infrastructure as a Service (IaaS)**: Cloud provider maintains hardware, network connectivity, and physical security.
- **Platform as a Service (PaaS)**: Cloud provider maintains infrastructure and middleware, allowing focus on application development.
- **Software as a Service (SaaS)**: Cloud provider delivers fully functional applications over the internet.
- **Elasticity**: Automatic increase or decrease of resources based on demand.
- **Scalability**: Ability to increase or decrease resources.
- **Vertical Scaling**: Increasing or decreasing resources (e.g., CPU, RAM) of a single instance.
- **Horizontal Scaling**: Adding more instances (e.g., additional VMs or containers).
- **Resiliency**: Ability of a system to recover from failures and continue to function.

## Networking and Connectivity

- **Network Security Group**: Filters network traffic between Azure resources in an Azure virtual network.
- **Service Endpoint**: Exposes and connects Azure services to a virtual network.
- **Local Network Gateway**: Represents the on-premises location for routing purposes.
- **Peering**: Linking virtual networks together.
- **Application Security Group**: Configures application’s network security as a group of virtual machines.
- **Gateway Subnet**: IP address range of a virtual network where resources and services operate.

## Miscellaneous

- **Fabric Controller**: Special software running in a server connected to the orchestrator.
- **Orchestrator**: Manages everything in Azure, responding to user requests and forwarding them to the fabric controller.
- **Cloud Solution Provider (CSP)**: Microsoft Partner organization offering Azure services.
- **Microsoft Managed Desktop**: Subscription-based desktop-as-a-service (DaaS) cloud platform.
- **Microsoft Service Trust Portal**: Portal with various resources about Microsoft security, privacy, and compliance practices.
- **Sovereign Region**: Region isolated from the main instance of Azure.
- **Management Group**: Grouping of multiple subscriptions.
- **Subscription**: Isolated area where Azure resources are created and managed.
