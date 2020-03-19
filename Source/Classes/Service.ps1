class O365ServiceCommunications_ServiceFeature {
    [string] $DisplayName
    [string] $Name
}

class O365ServiceCommunications_Service {
    [string] $Id
    [string] $DisplayName
    [O365ServiceCommunications_ServiceFeature[]] $Features
}
