function New-Session
{
    <#
		.SYNOPSIS
		Connects to the Office 365 Service Communications API using your administrator account credentials.
		.DESCRIPTION
		Connects to the Office 365 Service Communications API using your administrator account credentials. This 
		generates a cookie that authenticates your account to the API. This cookie has a lifetime of 48 hours.
		.PARAMETER Credential
		Specifies a user name and password of an Office 365 tenant admin. Accepts an object of type PSCredential or a 
		username of type String. If a username is specified, you'll be prompted to enter the password.
		.PARAMETER Locale
		Specifies the locale for output. If locale is ommitted or the value you pass does not match acceptable options 
		will default to US English (en-US).
		.EXAMPLE
		$O365Admin = Get-Credential
		$Session = New-SCSession -Credential $O365Admin
		Create a credential object and use that credential to connect to the Service Communications API.
		.EXAMPLE
		$Session = New-SCSession -Credential 'O365Admin@domain.onmicrosoft.com'
		Connect to the Service Communications API using a string username. When you run this command you'll be 
		prompted for a password.
		.EXAMPLE
		$Session = New-SCSession -Credential 'O365Admin@domain.onmicrosoft.com' -locale es-ES
		Connect to the Service Communications API and specify Spanish (Spain) and the language.
		.OUTPUTS
		O365ServiceCommunications.Session
        .LINK
        https://msdn.microsoft.com/en-us/library/office/dn776043.aspx
    #>

    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$true)]
        [System.Management.Automation.CredentialAttribute()]
        $Credential,

        [String]
        $Locale = 'en-US'
    )


    $BodyCred = @{
        userName = $Credential.UserName
        password = $Credential.GetNetworkCredential().password
		locale   = $Locale
    } | ConvertTo-Json

    $Splat = @{
        ContentType     = 'application/json'
        Method          = 'Post'
        Uri             = 'https://api.admin.microsoftonline.com/shdtenantcommunications.svc/Register'
        Body            = $BodyCred
    }

    [PSCustomObject]@{
        UserName   = $Credential.UserName
        Cookie     = Invoke-RestMethod @Splat | Select-Object -ExpandProperty RegistrationCookie
        Locale     = $Locale
        PSTypeName = $SessionTypeName
    }
}