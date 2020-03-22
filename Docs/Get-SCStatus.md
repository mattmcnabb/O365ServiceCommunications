---
external help file: O365ServiceCommunications-help.xml
Module Name: O365ServiceCommunications
online version:
schema: 2.0.0
---

# Get-SCStatus

## SYNOPSIS
Retrieves information regarding the current or historical status of Office 365 services.

## SYNTAX

### CurrentStatus (Default)
```
Get-SCStatus [-Workload <String>] [<CommonParameters>]
```

### HistoricalStatus
```
Get-SCStatus [-Workload <String>] -From <DateTimeOffset> [<CommonParameters>]
```

## DESCRIPTION
Retrieves information regarding the current or historical status of Office 365 services. This information can be filtered by a given workload.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-SCStatus
```

This example retrieves the current status of all Office 365 workloads.

### Example 2
```powershell
PS C:\> Get-SCStatus -Workload Exchange
```

This example retrieves the current status for a particular Office 365 workload.

### Example 3
```powershell
PS C:\> Get-SCStatus -Workload Exchange -From 1/1/2020
```

This example retrieves the historical status for a particular Office 365 workload.

## PARAMETERS

### -From
Specifies the earliest date for which to retrieve historical status information.

```yaml
Type: DateTimeOffset
Parameter Sets: HistoricalStatus
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Workload
The Office 365 service for which you'd like to retrieve information.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### O365ServiceCommunications_Status

## NOTES

## RELATED LINKS
[https://docs.microsoft.com/en-us/office/office-365-management-api/office-365-service-communications-api-reference#get-current-status](https://docs.microsoft.com/en-us/office/office-365-management-api/office-365-service-communications-api-reference#get-current-status)
[https://docs.microsoft.com/en-us/office/office-365-management-api/office-365-service-communications-api-reference#get-historical-status](https://docs.microsoft.com/en-us/office/office-365-management-api/office-365-service-communications-api-reference#get-historical-status)
