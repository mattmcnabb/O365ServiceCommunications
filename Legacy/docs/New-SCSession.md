---
external help file: O365ServiceCommunications-help.xml
online version: https://msdn.microsoft.com/en-us/library/office/dn776043.aspx
schema: 2.0.0
---

# New-SCSession

## SYNOPSIS
Connects to the Office 365 Service Communications API using your administrator account credentials.

## SYNTAX

```
New-SCSession [-Credential] <Object> [[-Locale] <String>]
```

## DESCRIPTION
Connects to the Office 365 Service Communications API using your administrator account credentials.
This 
generates a cookie that authenticates your account to the API.
This cookie has a lifetime of 48 hours.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
$O365Admin = Get-Credential
```

$Session = New-SCSession -Credential $O365Admin
Create a credential object and use that credential to connect to the Service Communications API.

### -------------------------- EXAMPLE 2 --------------------------
```
$Session = New-SCSession -Credential 'O365Admin@domain.onmicrosoft.com'
```

Connect to the Service Communications API using a string username.
When you run this command you'll be 
prompted for a password.

### -------------------------- EXAMPLE 3 --------------------------
```
$Session = New-SCSession -Credential 'O365Admin@domain.onmicrosoft.com' -locale es-ES
```

Connect to the Service Communications API and specify Spanish (Spain) and the language.

## PARAMETERS

### -Credential
Specifies a user name and password of an Office 365 tenant admin.
Accepts an object of type PSCredential or a 
username of type String.
If a username is specified, you'll be prompted to enter the password.

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

### -Locale
Specifies the locale for output.
If locale is ommitted or the value you pass does not match acceptable options 
will default to US English (en-US).

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: En-US
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### O365ServiceCommunications.Session

## NOTES

## RELATED LINKS

[https://msdn.microsoft.com/en-us/library/office/dn776043.aspx](https://msdn.microsoft.com/en-us/library/office/dn776043.aspx)

