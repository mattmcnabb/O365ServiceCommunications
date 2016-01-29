function Get-SCEvent
{
	<#
		.SYNOPSIS
		Returns events from the Service Communications API.
		.DESCRIPTION
		Returns events from the Service Communications API. These events can be Incidents, Maintenance messages, or just 
		informational messages.
		.PARAMETER EventTypes
		Specifies the types of events that you would like to gather information for. Valid values are:
		Incident
		Maintenance
		Message
		.PARAMETER SCSession
		Specifies the Service Communications session to retrieve events for. These sessions are created using the 
		New-SCSession function.
		.PARAMETER PastDays
		Specifies the past number of days to return events for. Default value is 7 days.
		.EXAMPLE
		$O365Admin = Get-Credential
		$Session = New-SCSession -Credential $O365Admin
		Get-SCEvent -EventTypes Incident,Maintenance,Message -PastDays 10 -SCSession $Session
		Initiate a session to the Service Communications API and then return all events for the past 10 days.
		.EXAMPLE
		Get-SCEvent -EventTypes Incident -SCSession $Session
		Retrieve only Incident events.
		.OUTPUTS
		O365ServiceCommunications.Event
        .LINK
        https://msdn.microsoft.com/en-us/library/office/dn776043.aspx
    #>

    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false)]
        [ValidateSet('Incident','Maintenance','Message')]
        [string[]]
        $EventTypes = 'Incident',

        [Parameter(Mandatory=$false)]
        [PSTypeName('O365ServiceCommunications.Session')]
        $SCSession,

        [Parameter(Mandatory=$false)]
        [int]
        $PastDays = 7
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
        pastDays            = $PastDays
    }

    $Splat = @{
        ContentType = 'application/json'
        Method      = 'Post'
        Uri         = 'https://api.admin.microsoftonline.com/shdtenantcommunications.svc/GetEvents'
        Body        = $null
    }

	# request the events one event type at a time
	# this makes it possible to add the event type property to the output
    foreach ($EventType in $EventTypes)
    {
        $Body.preferredEventTypes = @($EventCodes.$EventType)
        $Splat.Body = $Body | ConvertTo-Json

		Invoke-RestMethod @Splat | Select-Object -ExpandProperty Events |
		New-CustomObject -Typename $EventTypeName -ExtraProperties @{EventType = $EventType}
    }
}