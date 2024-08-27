# Azure Identity, Authentication, and Authorization

Azure Entra ID, formerly known as Azure Active Directory (Azure AD), is a cloud-based identity and access management service provided by Microsoft. It is designed to help organizations manage and secure their digital identities and resources. Key features and functions of Azure Entra ID include:

- Identity Management: Manages user identities and ensures secure authentication and authorization.
- Access Management: Controls access to applications and resources within the organization.
- Single Sign-On (SSO): Allows users to access multiple applications with one set of credentials.
- Multi-Factor Authentication (MFA): Enhances security by requiring two or more verification methods.
- Conditional Access: Provides policies to enforce specific requirements for accessing resources.
- Self-Service Password Reset: Enables users to reset their passwords without IT assistance.
- B2B Collaboration: Allows secure collaboration with external partners by granting them access to internal resources.
- B2C Identity Management: Manages customer identities for applications.
- Application Management: Integrates with a wide range of applications for streamlined access and management.
- Azure Entra ID is a critical component for securing and managing access to Microsoft services and other integrated applications, making it an essential tool for enterprises leveraging Microsoft cloud solutions.

## Azure Active Directory

- Microsoft Entra is a product family that includes Azure AD/Microsoft Entra Id
- Active Directory (AD) is not the same as Azure AD/ Microsoft Entra ID
- Every Azure account will have an Azure AD/Entra ID service
- A tenant is a dedicated instance of Azure AD/Entra ID. It represents your organization in Azure
- A user can only be a member of up to 500 tenants
- A subscription is a billin entity. All resources can only belong to a single subscription.
- Azure AD/Entra ID is the identity, authorization, and management service buildt in to Azure.

## Zero Trust Concepts

All users assumed untrustworthy unless proven otherwise

- Trusted by identity
- Regardless of location (trusted/untrusted networks)
- Least priviledge access - just enough permissions to perform the job
- Simplified, centralized mamagement

Zero Trust = No presumed trust, but idemtities can be validated. No trusted locations.

## Multi-Factor Authenticatin

- Multi-factor authentication provides layered security for user identity.
- It requires at least two components of:
  - Something you know
  - Someting you have
  - Something you are
- MFA is a recommended security feature by Microsoft for all Microsoft identities.

## Conditional Access

- Conditional Access is a feature that provides an **additional layer of security** to your environments and identities.
- Conditional Access rules are essentially **if/then statements** that permit or deny access depending on whether the rules are met.
- Multi-factor authentication os pften **impelmented with Conditional Access** as further security.
- Microsoft recommends the use of MFA and Conditional Access

## Passwordless Authentication

Increase convenience while staying secure
Remove password from login and replace with:

- Something you have (phone/key fob)
- Something you know/are (on device)
  - Fingerprint/Face unlock

## External Guest Access

- External guest access enables **security outside of your organizational boundaries**.
- Provides **visibility of external guest activity** within your organizational IT borders.
- Business-to-business (B2B) access provides a federated **level of trust for tenants**.

## Azure Active Directory Domain Services

- Azure Active Directory Domain Services (Azure AD DS) **provide legacy AD** features inside of Azure.
- Azure AD DS is a **managed service** inside of Azure. There is no maintenance if infrastructure required for the user.
- Integrates with Entra ID/Azure AD.
- Helpful when **migrating or integrating legacy applications** that do not support modern protocols.

## Managing Access to Resources with Role-Based Access Control (RBAC)

- Control access (to resources and services) based on role (assigned to the user, device, application, or service).
- Least priviledgeL only the permission necessary
- Role segregation: separate duties and responsibilities; avoid combining roles that grant conflicting permissions or excessive access
- Review, audit, and document: check, double check, and write it down
