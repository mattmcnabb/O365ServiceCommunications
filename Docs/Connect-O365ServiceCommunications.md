---
external help file: O365ServiceCommunications-help.xml
Module Name: O365ServiceCommunications
online version:
schema: 2.0.0
---

# Connect-O365ServiceCommunications

## SYNOPSIS
Initiates a connection to the Office 365 Service Communications API.

## SYNTAX

```
Connect-O365ServiceCommunications [-ClientID] <Guid> [-ClientSecret] <String> [-TenantID] <Guid>
 [<CommonParameters>]
```

## DESCRIPTION
Initiates a connection to the Office 365 Service Communications API. This connection is required before you can run any other commands in this module. In order to establish a connection you must first register an application in Azure Active Directory with the appropriate permissions. See the 'Related Links' section for a walkthrough of how to register this application.

## EXAMPLES

### Example 1
```powershell
PS C:\> $ClientID = "10da3cc3-4a37-4e1e-9c75-8f894bfe8c34"
PS C:\> $ClientSecret = "n6RB_(A4[5SMQk2@7Z20LQAKrE/IlCyD"
PS C:\> $TenantID = "41f8c530-0c2a-466c-98cf-dbadbfca090c"
PS C:\> Connect-O365ServiceCommunications -ClientID $ClientID -ClientSecret $ClientSecret -TenantID $TenantID
```

This example demonstrates connecting to the Office 365 Service Communications API using your tenant ID, along with the client ID and secret created for your registered application.

## PARAMETERS

### -ClientID
The client ID of the Azure Active Directory registered application. See the 'Related Links' section for a walkthrough of how to register this application.

```yaml
Type: Guid
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ClientSecret
The client secret of the Azure Active Directory registered application. See the 'Related Links' section for a walkthrough of how to register this application.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TenantID
Your Office 365 tenant ID. This can also be found in the properties of your registered application.

```yaml
Type: Guid
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### None

## NOTES

## RELATED LINKS
[https://docs.microsoft.com/en-us/office/office-365-management-api/get-started-with-office-365-management-apis](https://docs.microsoft.com/en-us/office/office-365-management-api/get-started-with-office-365-management-apis)
