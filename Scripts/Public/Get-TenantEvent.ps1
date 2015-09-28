function Get-TenantEvent
{
    [CmdletBinding()]
    param
    (
		[Parameter(Mandatory)]
        [PSTypeName('O365ServiceCommunications.Session')]
        $SCSession,

        [Parameter(Mandatory=$false)]
        [ValidateSet('Incident','Maintenance','Message')]
        [string[]]
        $EventTypes = 'Incident',

		[Parameter(Mandatory)]
        $Domains,

        [Parameter()]
        [int]
        $PastDays
    )

	# table of possibe event types
    $EventCodes = @{
        'Incident'    = 0
        'Maintenance' = 1
        'Message'     = 2
    }

	# this is the body of the JSON request that will be passed to the API
    $Body = @{
        lastCookie          = $SCSession.Cookie
        locale              = $SCSession.Locale
        preferredEventTypes = @()
		tenantDomains       = @()
        pastDays            = $PastDays
    }

    $Splat = @{
        ContentType = 'application/json'
        Method      = 'Post'
        Uri         = 'https://api.admin.microsoftonline.com/shdtenantcommunications.svc/GetEventsForTenantDomains'
        Body        = $null
    }

	# request the events one event type at a time
	# this makes it possible to add the event type property to the output
	foreach ($Domain in $Domains)
	{
		$Body.tenantDomains = @($Domain)
		foreach ($EventType in $EventTypes)
		{
			$Body.preferredEventTypes = @($EventCodes.$EventType)
			$Splat.Body = $Body | ConvertTo-Json

			Invoke-RestMethod @Splat | Select-Object -ExpandProperty Events |
			New-CustomObject -Typename $EventTypeName -ExtraProperties @{EventType = $EventType; TenantDomain = $Domain}
		}
	}
}