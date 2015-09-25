function New-Session
{
    <#
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
        userName=$Credential.username
        password=$Credential.GetNetworkCredential().password
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