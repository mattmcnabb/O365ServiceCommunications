---
external help file: O365ServiceCommunications-help.xml
online version: https://msdn.microsoft.com/en-us/library/office/dn776043.aspx
schema: 2.0.0
---

# Get-SCServiceInfo

## SYNOPSIS
Returns information about the services available to the Office 365 Service Communications API.

## SYNTAX

```
Get-SCServiceInfo [-SCSession] <Object>
```

## DESCRIPTION
Returns information about the services available to the Office 365 Service Communications API.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
$O365Admin = Get-Credential
```

$Session = New-SCSession -Credential $O365Admin
Get-SCServiceInfo -SCSession $Session
Initiate a session to the Service Communications API and then return service information for your tenant.

## PARAMETERS

### -SCSession
Specifies the Service Communications session to retrieve events for.
These sessions are created using the 
New-SCSession function.

```yaml
Type: Object
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### O365ServiceCommunications.ServiceInfo

## NOTES

## RELATED LINKS

[https://msdn.microsoft.com/en-us/library/office/dn776043.aspx](https://msdn.microsoft.com/en-us/library/office/dn776043.aspx)

