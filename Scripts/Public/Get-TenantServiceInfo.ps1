function Get-TenantServiceInfo
{
    [CmdletBinding()]
    param
    (
		[Parameter(Mandatory)]
        [PSTypeName('O365ServiceCommunications.Session')]
        $SCSession,

		[Parameter(Mandatory)]
		[System.String[]]
		$Domains
    )

    $Body = @{
        lastCookie = $SCSession.Cookie
        locale     = $SCSession.Locale
		companyDomains = @($Domains)
    }

    $Splat = @{
        ContentType = 'application/json'
        Method      = 'Post'
        Uri         = 'https://api.admin.microsoftonline.com/shdtenantcommunications.svc/GetServiceInformationForTenantDomains'
		Body        = $Body | ConvertTo-Json
    }

	Invoke-RestMethod @Splat | foreach {
		$_ | New-CustomObject -TypeName $TenantServiceInfoTypeName
	}
}