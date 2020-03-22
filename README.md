# <img src="Images/logo.png" width="48"> O365ServiceCommunications V2 (Preview)

A Powershell module for retrieving data from the Office 365 Service Communications API. This could be used for reporting the health status of your tenant over time, or for alerting when new incidents are posted.

### Getting Started
You'll need to start by registering an application with the appropriate permissions in the Azure Active Directory associated with your Office 365 tenant. Instructions for that can be found [here](https://docs.microsoft.com/en-us/office/office-365-management-api/get-started-with-office-365-management-apis#register-your-application-in-azure-ad).

To install this module from the PowerShell Gallery, run `Install-Module O365ServiceCommunications`.

### Module Version
The original version of the Service Communications API has now been deprecated, and V2 is now the officially supported API. These APIs share little in common, so updating this module to support the new API is a breaking change. For that reason, the major version of this module follows the API version - 1.*.* refers to the module supporting the original API and 2.*.* is the version that supports the V2 API. Versions of the module prior to 2.0.0 will eventually be unlisted from the PowerShell Gallery since the original API is no longer available.

> Note: V2 of this module is currently in preview. It is working but needs testing and better documentation. Please consider helping me out by installing and testing it, and reporting any issues you might have. While this module is in preview, you'll need to run `Install-Module O365ServiceCommunications -AllowPrerelease` to install the preview version.

### Commands

##### Connect-O365ServiceCommunications
Use this function to authenticate to the Service Communications API and retrieve an access token. This will create a pseudo-persistent connection to the API that will be used for subsequent calls. Removing or re-importing the module will break this connection.

##### Get-SCService
Returns information about what services are available in your tenant.

##### Get-SCStatus
Returns current or historical status for services in your tenant.

##### Get-SCMessage
Returns messages from the Service Communications API.

### Why use it?
With this PowerShell module you could:
- Present an HTML report of Office 365 Service Health
- Generate an email alert when new incidents are posted to your tenant
- Post alerts to the team chat service of your choice
- And many more! :laughing:

### Contributing

| Azure Pipelines | PowerShell Gallery | Github |
|:----------------|:-------------------|:-------|
| ![Build Status](https://img.shields.io/azure-devops/build/mmcnabb/d7fe97c8-90be-4784-9559-624189a556de/8/master.svg) | ![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/O365ServiceCommunications.svg) | ![Github Releases](https://img.shields.io/github/downloads/mattmcnabb/O365ServiceCommunications/total.svg) |

Any contributions to the project are welcome and could come in the form of issues, fixes, new features, tests, or even help documentation. Just submit an issue or PR and I'll review ASAP.

> Note: I'd really appreciate some additional testers, both for administrators of an Office 365 tenant and partners who provide support for several client tenants. Please try the preview module out and submit issues for any problems you encounter. Thanks!

### Related Links
[API Reference](https://docs.microsoft.com/en-us/office/office-365-management-api/office-365-service-communications-api-reference)

[V1 Blog Post](https://mattmcnabb.github.io/Office-365-Health-Monitoring-With-PowerShell)
