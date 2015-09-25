function Get-Event
{
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
        $PastDays
    )

    $EventCodes = @{
        'Incident'    = 0
        'Maintenance' = 1
        'Message'     = 2
    }

    $Body = [ordered]@{
        lastCookie = $SCSession.Cookie
        locale     = $SCSession.Locale
        preferredEventTypes = $null
        pastDays   = $PastDays
    }

    $Splat = @{
        ContentType = 'application/json'
        Method      = 'Post'
        Uri         = 'https://api.admin.microsoftonline.com/shdtenantcommunications.svc/GetEvents'
        Body        = @()
    }

    foreach ($EventType in $EventTypes)
    {
        $Body.preferredEventTypes = @([int]$EventCodes.$EventType)
        $Splat.Body = $Body | ConvertTo-Json

        foreach ($Object in (Invoke-RestMethod @Splat | Select-Object -ExpandProperty Events))
        {
            [PSCustomObject]@{
                PSTypeName                  = $EventTypeName
                EventType                   = $EventType
                AffectedServiceHealthStatus = $Object.AffectedServiceHealthStatus
                AffectedTenantCount         = $Object.AffectedTenantCount
                EndTime                     = $Object.EndTime
                Id                          = $Object.Id
                LastUpdatedTime             = $Object.LastUpdatedTime
                Messages                    = $Object.Messages
                StartTime                   = $Object.StartTime
                Status                      = $Object.Status
                Title                       = $Object.Title
            }
        }
    }
}