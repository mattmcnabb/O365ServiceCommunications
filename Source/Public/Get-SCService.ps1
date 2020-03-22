function Get-SCService {
    [CmdletBinding()]
    [OutputType([O365ServiceCommunications_Service])]
    param (

    )
    
    try {
        if (!(Test-SCConnection)) {
            Connect-O365ServiceCommunications $Script:SCConnection.ClientID $Script:SCConnection.ClientSecret $Script:SCConnection.TenantID
        }
    }
    catch {
        throw "No viable connection was found. Please run 'Connect-O365ServiceCommunications before running any other commands.'"

    }

    $Uri = "$($Script:SCConnection.ApiBase)/Services"
    [O365ServiceCommunications_Service[]](Invoke-RestMethod -Uri $Uri -Headers $Script:SCConnection.AuthHeader).Value
}
