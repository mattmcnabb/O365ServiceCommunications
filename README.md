# O365ServiceCommunications
A Powershell module for retrieving data from the Office 365 Service Communications API. This could be used for reporting the health status of your tenant over time, or for alerting when new incidents are posted.

###Getting Started
You'll need to be a global administrator for an Office 365 Tenant, or a delegated partner for an Office 365 tenant.

![](images/GettingStarted.png)

###Functions

#####New-SCSession
Use this function to authenticate to the Service Communications API and create a persistent session. This endpoint returns a cookie that is valid for 48 hours.

#####Get-SCEvent
Collect events from your Office 365 tenant. Event types are Incident, Maintenance, and Message.

#####Get-SCServiceInfo
Returns information about what services are available in your tenant.

#####Get-SCTenantEvent
Similar to Get-SCEvent, but for partner administrators.

#####Get-SCTenantServiceInfo
Similar to Get-SCServiceInfo, but for partner administrators.

###Please contribute!
I need help with the Get-TenantEvent and Get-TenantServiceInfo functions. I am unable to test in this scenario because I don't administer a partner Office 365 tenant domain. If anyone has this type of administrative relationship and would like to test the module please let me know. Also, please feel free to submit a pull request for any tweaks to these functions.

###API Overview
https://msdn.microsoft.com/en-us/library/office/dn776043.aspx

###API Code Samples
https://www.microsoft.com/en-us/download/details.aspx?id=44012

###Version History
0.3 - Expanded tests; Added default value to -PastDays parameter of Get-SCEvent
0.2 - Completed New-SCSession, Get-SCEvent, and Get-SCServiceInfo; Added some custom formatting and basic module tests
0.1 - Initial working version