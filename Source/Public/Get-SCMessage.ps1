function Get-SCMessage {
    [CmdletBinding(DefaultParameterSetName = "Filter")]
    [OutputType([O365ServiceCommunications_Message])]
    param (
        [Parameter(ParameterSetName = "Filter")]
        [string]
        $Workload,

        [Parameter(ParameterSetName = "Filter")]
        [DateTimeOffset]
        $Start,

        [Parameter(ParameterSetName = "Filter")]
        [DateTimeOffset]
        $End,

        [Parameter(ParameterSetName = "Filter")]
        [string]
        $MessageType,

        [Parameter(Mandatory, ParameterSetName = "Id")]
        [string]
        $Id
    )
    
    try {
        if (!(Test-SCConnection)) {
            Connect-O365ServiceCommunications $Script:SCConnection.ClientID $Script:SCConnection.ClientSecret $Script:SCConnection.TenantID
        }
    }
    catch {
        throw "No viable connection was found. Please run 'Connect-O365ServiceCommunications before running any other commands.'"

    }

    $Splat = @{
        Headers = $Script:SCConnection.AuthHeader
        Uri     = "$($Script:SCConnection.ApiBase)/Messages"
        Body    = @{}
    }

    switch ($PSCmdlet.ParameterSetName)
    {
        "Id" {
            $Splat["Body"]['$filter'] = "Id eq '$Id'"
        }

        "Filter" {
            $Filters = @(
                if ($PSBoundParameters.ContainsKey("Workload")) {
                    "Workload eq '$Workload'"
                }

                if ($PSBoundParameters.ContainsKey("Start")) {
                    "StartTime ge $($Start.UTCDateTime.ToString("o"))"
                }

                if ($PSBoundParameters.ContainsKey("End")) {
                    "EndTime le $($End.UTCDateTime.ToString("o"))"
                }

                if ($PSBoundParameters.ContainsKey("MessageType")) {
                    "MessageType eq Microsoft.Office365ServiceComms.ExposedContracts.MessageType'$MessageType'"
                }
            )

            if ($Filters) {
                $Splat["Body"]['$filter'] = $Filters -join " and "
            }
        }
    }

    (Invoke-RestMethod @Splat).Value | ForEach-Object {
        switch ($_) {
            { $_.MessageType -eq "Incident" } {
                [O365ServiceCommunications_IncidentMessage]$_
            }

            { $_.MessageType -eq "MessageCenter" } {
                [O365ServiceCommunications_MessageCenterMessage]$_
            }
        }
    }
}
