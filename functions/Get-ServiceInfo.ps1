function Get-ServiceInfo
{
	<#
		.SYNOPSIS
		Returns information about the services available to the Office 365 Service Communications API.
		.DESCRIPTION
		Returns information about the services available to the Office 365 Service Communications API.
		.PARAMETER SCSession
		Specifies the Service Communications session to retrieve events for. These sessions are created using the 
		New-SCSession function.
		.EXAMPLE
		$O365Admin = Get-Credential
		$Session = New-SCSession -Credential $O365Admin
		Get-SCServiceInfo -SCSession $Session
		Initiate a session to the Service Communications API and then return service information for your tenant.
		.OUTPUTS
		O365ServiceCommunications.ServiceInfo
        .LINK
        https://msdn.microsoft.com/en-us/library/office/dn776043.aspx
    #>
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