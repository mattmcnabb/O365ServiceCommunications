---
external help file: O365ServiceCommunications-help.xml
online version: https://msdn.microsoft.com/en-us/library/office/dn776043.aspx
schema: 2.0.0
---

# Get-SCEvent

## SYNOPSIS
Returns events from the Service Communications API.

## SYNTAX

```
Get-SCEvent [[-EventTypes] <String[]>] [[-SCSession] <Object>] [[-PastDays] <Int32>]
```

## DESCRIPTION
Returns events from the Service Communications API.
These events can be Incidents, Maintenance messages, or just 
informational messages.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
$O365Admin = Get-Credential
```

$Session = New-SCSession -Credential $O365Admin
Get-SCEvent -EventTypes Incident,Maintenance,Message -PastDays 10 -SCSession $Session
Initiate a session to the Service Communications API and then return all events for the past 10 days.

### -------------------------- EXAMPLE 2 --------------------------
```
Get-SCEvent -EventTypes Incident -SCSession $Session
```

Retrieve only Incident events.

## PARAMETERS

### -EventTypes
Specifies the types of events that you would like to gather information for.
Valid values are:
Incident
Maintenance
Message

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: Incident
Accept pipeline input: False
Accept wildcard characters: False
```

### -SCSession
Specifies the Service Communications session to retrieve events for.
These sessions are created using the 
New-SCSession function.

```yaml
Type: Object
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PastDays
Specifies the past number of days to return events for.
Default value is 7 days.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
Default value: 7
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### O365ServiceCommunications.Event

## NOTES

## RELATED LINKS

[https://msdn.microsoft.com/en-us/library/office/dn776043.aspx](https://msdn.microsoft.com/en-us/library/office/dn776043.aspx)

