# O365ServiceCommunications
A Powershell module for retrieving data from the Office 365 Service Communications API. This could be used for reporting the health status of your tenant over time, or for alerting when new incidents are posted.

###Getting Started
You'll need to be a global administrator for an Office 365 Tenant, or a delegated partner for an Office 365 tenant. You can create a session by running:
```Powershell
$Cred = Get-Credential
$Session = New-SCSession -Credential $Cred
```
To collect events from the API, use the Get-SCEvent function:
```Powershell
Get-SCEvent -SCSession $Session -EventTypes Incident,Maintenance,Message -PastDays 10
```

###API overview here
https://msdn.microsoft.com/en-us/library/office/dn776043.aspx

###API Code Samples here
https://www.microsoft.com/en-us/download/details.aspx?id=44012

###Functions completed
- [x] New-SCSession
- [x] Get-Event
- [x] Get-ServiceInfo
- [ ] Get-TenantEvent
- [ ] Get-TenantServiceInfo

###To-Dos
####There are currently 3 areas that need the most work

#####Partner administration functions
These are Get-TenantEvent and Get-TenantServiceInfo
I am unable to test in this scenario because I don't administer a partner Office 365 tenant domain. If anyone has this type of administrative relationship and would like to test the module please let me know. Also, please feel free to submit a pull request for any tweaks to these functions.

#####Pester Tests
I am currently looking at strategies for testing these functions so please feel free to add content in this area.

#####Error Handling
Some error handling may be needed to return helpful exceptions based on web request errors returned. These return codes are detailed in the API Overview
