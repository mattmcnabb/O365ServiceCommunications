Import-Module O365ServiceCommunications

# Import a credential object to use against the Service Communications API
# this needs to be a global admin for your Office 365 tenant
# To save a credential, run Get-Credential | Export-CliXml -Path c:\scripts\cred.xml
$Credential = Import-Clixml -Path "$PSScriptRoot\cred.xml"

# gather events from the Service Communications API
$MySession = New-SCSession -Credential $Credential
$Events = Get-SCEvent -EventTypes Incident -PastDays 1 -SCSession $MySession |
    Select-Object Id, Status, StartTime,
    @{n='ServiceName'; e={$_.AffectedServiceHealthStatus.servicename}},
    @{n='Message';e={$_.messages[0].messagetext}}


if ($Events)
{
    $Tables = foreach ($Event in $Events)
    {
        @"
        <table>
            <tr>
                <th>Id</th>
                <th>ServiceName</th>
                <th>Status</th>
                <th>StartTime</th>
            </tr>
			
            <tr>
                <td>$($Event.Id)</td>
                <td>$($Event.ServiceName)</td>
                <td>$($Event.Status)</td>
                <td>$($Event.StartTime)</td>
            </tr>
        </table>

        <table>
            <tr>
                <td>$($Event.Message)</td>
            </tr>
        </table>
"@
        
    }

    $Html = @"
    <!DOCTYPE HTML>
    <html>
        <Head>
            <style>
                body {}
				table {width: 100%; }
                table, th, td  {
                    font-family: calibri,arial,verdana;
                    border: 2px solid white;
                    border-collapse: collapse;
                    background-color: #daeded;
                }
            </style>
        </head>

        <body>
            $Tables
        </body>
    </html>
"@
    
    $Splat = @{
        SmtpServer  = 'servername.domain.local'
        Body        = $Html
        BodyAsHtml  = $true
        To          = 'matt@domain.local'
        From        = 'O365Events@domain.local'
        Subject     = 'Office 365 Service Health Alerts'
        Priority    = 'High'
    }
    Send-MailMessage @Splat
}
