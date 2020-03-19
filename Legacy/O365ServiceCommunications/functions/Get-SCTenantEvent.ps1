function Get-SCTenantEvent
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

    #$ServiceUrl being loaded from /helpers/Config.ps1
    $Splat = @{
        ContentType = 'application/json'
        Method      = 'Post'
        Uri         = "$ServiceUrl/GetEventsForTenantDomains"
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
            
			Invoke-RestMethod @splat | Select-Object -ExpandProperty EventsByTenantDomain | Select-Object -ExpandProperty Value |
            New-CustomObject -Typename $TenantEventTypeName -ExtraProperties @{EventType = $EventType; TenantDomain = $Domain}
		}
	}
}