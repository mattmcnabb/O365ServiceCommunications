function Get-SCService {
    [CmdletBinding()]
    [OutputType([O365ServiceCommunications_Service])]
    param (

    )
    
    try {
        Test-SCConnection
    }
    catch {
        Connect-O365ServiceCommunications
    }

    $Uri = "$($Script:SCConnection.ApiBase)/Services"
    [O365ServiceCommunications_Service[]](Invoke-RestMethod -Uri $Uri -Headers $Script:SCConnection.AuthHeader).Value
}
