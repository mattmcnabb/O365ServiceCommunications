class O365ServiceCommunications_MessageAdditionalDetails {
    [string] $Name
    [string] $Value
}

class O365ServiceCommunications_MessageText {
    [string] $MessageText
    [Nullable[DateTimeOffset]] $PublishedTime
}

class O365ServiceCommunications_Message {
    [string[]] $ActionType
    [O365ServiceCommunications_MessageAdditionalDetails[]] $AdditionalDetails
    [long] $AffectedTenantCount
    [long] $AffectedUserCount
    [string[]] $AffectedWorkloadDisplayNames
    [string[]] $AffectedWorkloadNames
    [string] $Classification
    [Nullable[DateTimeOffset]] $EndTime
    [string] $Feature
    [string] $FeatureDisplayName
    [string] $Id
    [string] $ImpactDescription
    [Nullable[DateTimeOffset]] $LastUpdatedTime
    [O365ServiceCommunications_MessageText[]] $Messages
    [string] $MessageType
    [string] $PostIncidentDocumentUrl
    [string] $Severity
    [datetime] $StartTime
    [string] $Status
    [Object[]] $TenantParams
    [string] $Title
    [string] $UserFunctionalImpact
    [string] $Workload
    [string] $WorkloadDisplayName
}

class O365ServiceCommunications_IncidentMessage : O365ServiceCommunications_Message {

}

class O365ServiceCommunications_MessageCenterMessage : O365ServiceCommunications_Message {
    hidden [string] ${@odata.type}
    [Nullable[DateTimeOffset]] $ActionRequiredByDate
    [long] $AnnouncementId
    [string] $AppliesTo
    [string] $BlogLink
    [string] $Category
    [string] $ExternalLink
    [string] $FeatureName
    [string] $FlightName
    [string] $HelpLink
    [bool] $IsDismissed
    [bool] $IsMajorChange
    [bool] $IsRead
    [string[]] $MessageTagNames
    [string] $Milestone
    [Nullable[DateTimeOffset]] $MilestoneDate
    [string] $PreviewDuration
}
