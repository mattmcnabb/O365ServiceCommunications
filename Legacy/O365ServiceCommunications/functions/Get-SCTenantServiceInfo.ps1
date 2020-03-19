function Get-SCTenantServiceInfo
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

    #Documentation says: lastCookie, locale, companydomains. This is wrong.
    #Working JSON Body: lastCookie, locale, tenantDomains
    $Body = @{
        lastCookie = $SCSession.Cookie
        locale     = $SCSession.Locale
		tenantDomains = @($Domains)
    }

    $Splat = @{
        ContentType = 'application/json'
        Method      = 'Post'
        Uri         = "$ServiceUrl/GetServiceInformationForTenantDomains"
		Body        = $Body | ConvertTo-Json
    }

	Invoke-RestMethod @Splat | Foreach-Object {
		$_ | New-CustomObject -TypeName $TenantServiceInfoTypeName
	}
}