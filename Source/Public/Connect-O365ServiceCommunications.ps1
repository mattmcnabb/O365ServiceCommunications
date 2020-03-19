function Connect-O365ServiceCommunications
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory)]
        [guid]
        $ClientID,

        [Parameter(Mandatory)]
        [string]
        $ClientSecret,

        [Parameter(Mandatory)]
        [guid]
        $TenantID
    )
    
    $Url = "https://login.microsoftonline.com/$TenantID/oauth2/token?api-version=1.0"

    $Body = @{
        grant_type = "client_credentials"
        resource = "https://manage.office.com"
        client_id = $ClientID
        client_secret = $ClientSecret
    }
    
    $Response = Invoke-RestMethod -Method Post -Uri $Url -Body $Body
    $Script:SCConnection = [O365ServiceCommunications_Connection]@{
        AuthHeader = @{ 'Authorization' = "$($Response.token_type) $($Response.access_token)" }
        ApiBase    = "https://manage.office.com/api/v1.0/$TenantID/ServiceComms"
        Expires    = [datetimeoffset]::new([datetime]"1970-01-01", [timespan]::new(0)).AddSeconds($Response.expires_on)
    }
}
