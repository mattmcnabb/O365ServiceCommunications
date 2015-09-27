function Get-ServiceInfo
{
    [CmdletBinding()]
    param
    (
		[Parameter(Mandatory)]
        [PSTypeName('O365ServiceCommunications.Session')]
        $SCSession
    )

    $Body = @{
        lastCookie = $SCSession.Cookie
        locale     = $SCSession.Locale
    }

    $Splat = @{
        ContentType = 'application/json'
        Method      = 'Post'
        Uri         = 'https://api.admin.microsoftonline.com/shdtenantcommunications.svc/GetServiceInformation'
		Body        = $Body | ConvertTo-Json
    }

	Invoke-RestMethod @Splat | foreach {
		$_ | New-CustomObject -TypeName $ServiceInfoTypeName
	}
}