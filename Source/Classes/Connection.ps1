class O365ServiceCommunications_Connection {
    hidden [string] $ClientID
    hidden [string] $ClientSecret
    [string] $TenantID
    hidden [hashtable] $AuthHeader
    [string] $ApiBase
    [DateTimeOffset] $Expires
}
