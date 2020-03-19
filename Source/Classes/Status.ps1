class O365ServiceCommunications_FeatureStatus {
    [string] $FeatureDisplayName
    [string] $FeatureName
    [string] $FeatureServiceStatus
    [string] $FeatureServiceStatusDisplayName
}

class O365ServiceCommunications_Status {
    [O365ServiceCommunications_FeatureStatus[]] $FeatureStatus
    [string] $Id
    [string[]] $IncidentIds
    [string] $Status
    [string] $StatusDisplayName
    [Nullable[DateTimeOffset]] $StatusTime
    [string] $Workload
    [string] $WorkloadDisplayName
}
