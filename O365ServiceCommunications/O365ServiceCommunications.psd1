@{
    NestedModules = "O365ServiceCommunications.psm1"
    ModuleVersion = "0.1.0"
    GUID = "bd4390dc-a8ad-4bce-8d69-f53ccf8e4163"
    Author = "Matt McNabb"
    Copyright = "(c) 2015 . All rights reserved."
    Description = "Gathers data regarding Office 365 Service Health from the Office 365 Service Communications API"
    PowerShellVersion = "3.0"
    FormatsToProcess = "Formats\Event.format.ps1xml","Formats\TenantEvent.format.ps1xml"
    FunctionsToExport = "Get-SCEvent","Get-SCServiceInfo","Get-SCTenantEvent","Get-SCTenantServiceInfo","New-SCSession"
    PrivateData = @{
        PSData = @{
            Tags = "Office365","REST"
            LicenseUri   = "https://github.com/mattmcnabb/O365ServiceCommunications/blob/master/O365ServiceCommunications/license"
            ProjectUri = "https://github.com/mattmcnabb/O365ServiceCommunications"
            IconUri = ""
            ReleaseNotes = @"
Fix issue with partner commands - thanks to PowerShellNinja for that one!
"@
        }
    }
}
