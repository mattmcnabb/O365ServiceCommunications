# O365ServiceCommunications
A Powershell module for retrieving data from the Office 365 Service Communications API

API overview here
https://msdn.microsoft.com/en-us/library/office/dn776043.aspx

Code Samples here
https://www.microsoft.com/en-us/download/details.aspx?id=44012

###What's currently working
New-SCSession
Get-Event
Get-ServiceInfo

###To-Dos
####There are currently 4 areas that need the most work

#####Partner administration functions
These are Get-TenantEvent and Get-TenantServiceInfo
I am unable to test in this scenario because I don't administer a partner Office 365 tenant domain. If anyone has this type of administrative relationship and would like to test the module please let me know. Also, please feel free to submit a pull request for any tweaks to these functions.

#####Pester Tests
I am currently looking at strategies for testing these functions so please feel free to add content in this area.

#####Error Handling
Some error handling may be needed to return helpful exceptions based on web request errors returned. These return codes are detailed in the API Overview

#####Formatting
I have started with the basic table formatting of the Event type. This will need to be fleshed out to include all format types for each custom object type (16 possible formats in all).

#####Comment-Based Help
Or June B. will be angry ;)
