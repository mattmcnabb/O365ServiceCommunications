function Get-SCStatus {
    [CmdletBinding(DefaultParameterSetName = "CurrentStatus")]
    [OutputType([O365ServiceCommunications_Status])]
    param (
        [Parameter(ParameterSetName = "CurrentStatus")]
        [Parameter(ParameterSetName = "HistoricalStatus")]
        [string]
        $Workload,

        [Parameter(Mandatory, ParameterSetName = "HistoricalStatus")]
        [System.DateTimeOffset]
        $From
    )
    
    try {
        Test-SCConnection
    }
    catch {
        Connect-O365ServiceCommunications
    }

    $Splat = @{
        Headers = $Script:SCConnection.AuthHeader
        Uri     = "$($Script:SCConnection.ApiBase)/$($PSCmdlet.ParameterSetName)"
        Body    = @{}
    }

    if ($PSCmdlet.ParameterSetName -eq "HistoricalStatus") {
        $Splat["Body"]['$filter'] = "StatusTime eq '$From'"
    }

    if ($PSBoundParameters.ContainsKey("Workload")) {
        $Splat["Body"]['$filter'] = "Workload eq '$Workload'"
    }
    
    [O365ServiceCommunications_Status[]](Invoke-RestMethod @Splat).Value
}
