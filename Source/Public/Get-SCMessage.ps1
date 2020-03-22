function Get-SCMessage {
    [CmdletBinding()]
    [OutputType([O365ServiceCommunications_Message])]
    param (
        [string]
        $Workload,

        [DateTimeOffset]
        $Start,

        [DateTimeOffset]
        $End,

        [string]
        $MessageType,

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
        Body = @{}
    }

    $Filters = @(
        if ($PSBoundParameters.ContainsKey("Workload")) {
            "Workload eq '$Workload'"
        }

        if ($PSBoundParameters.ContainsKey("Start")) {
            $Splat["Body"]['$filter'] = "StartTime eq '$Start'"
        }

        if ($PSBoundParameters.ContainsKey("End")) {
            $Splat["Body"]['$filter'] = "EndTime eq '$End'"
        }

        if ($PSBoundParameters.ContainsKey("MessageType")) {
            $Splat["Body"]['$filter'] = "MessageType eq Microsoft.Office365ServiceComms.ExposedContracts.MessageType'$MessageType'"
        }

        if ($PSBoundParameters.ContainsKey("Id")) {
            $Splat["Body"]['$filter'] = "Id eq '$Id'"
        }
    )
    
    if ($Filters) {
        $Splat["Body"]["$filter"] = $Filters -join " and "
    }
    
    [O365ServiceCommunications_Message[]](Invoke-RestMethod @Splat).Value
}
