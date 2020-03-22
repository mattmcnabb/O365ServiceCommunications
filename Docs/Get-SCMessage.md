---
external help file: O365ServiceCommunications-help.xml
Module Name: O365ServiceCommunications
online version:
schema: 2.0.0
---

# Get-SCMessage

## SYNOPSIS
Retrieves service messages from the Office 365 Service Communications API.

## SYNTAX

### Filter (Default)
```
Get-SCMessage [-Workload <String>] [-Start <DateTimeOffset>] [-End <DateTimeOffset>] [-MessageType <String>]
 [<CommonParameters>]
```

### Id
```
Get-SCMessage -Id <String> [<CommonParameters>]
```

## DESCRIPTION
Retrieves service messages from the Office 365 Service Communications API. These are typically messages relating to new features, maintenance, and service health incidents.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-SCMessage
```
This example retrieves all active messages for your tenant.

### Example 2
```powershell
PS C:\> Get-SCMessage -Id EX50699
```

This example will retrieve a particular message by its Id.

### Example 3
```powershell
PS C:\> Get-SCMessage -Workload Sharepoint
```

This example retrieves all messages for a particular Workload - Sharepoint in this case.

### Example 4
```powershell
PS C:\> Get-SCMessage -Start 2/1/2020 -End 4/1/2020
```

This example retrieves any messages within a given date range.


## PARAMETERS

### -End
The -End parameter specifies the end of a given date/time range for which to retrieve messages.

```yaml
Type: DateTimeOffset
Parameter Sets: Filter
Aliases:

Required: False
Position: Named
Default value: Now
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
Specifies the Id of a particular message to retrieve. -Id cannot be used with any other parameters, and it's value is case-sensitive.

```yaml
Type: String
Parameter Sets: Id
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MessageType
Specifies the type of messages to filter for. These are typically MessageCenter or Incident, but other types may be possible. Please be aware that this parameter's value is case-sensitive.

```yaml
Type: String
Parameter Sets: Filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Start
The -Start parameter specifies the starting date/time for which to retrieve messages.

```yaml
Type: DateTimeOffset
Parameter Sets: Filter
Aliases:

Required: False
Position: Named
Default value: 7 days ago
Accept pipeline input: False
Accept wildcard characters: False
```

### -Workload
Specifies the service for which to return messages. The names of available services can be retrieved using the Get-Service command. Please be aware that this parameter's value is case-sensitive.

```yaml
Type: String
Parameter Sets: Filter
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

### O365ServiceCommunications_Message

## NOTES

## RELATED LINKS
[https://docs.microsoft.com/en-us/office/office-365-management-api/office-365-service-communications-api-reference#get-messages](https://docs.microsoft.com/en-us/office/office-365-management-api/office-365-service-communications-api-reference#get-messages)
