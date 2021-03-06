@{
    NestedModules     = "O365ServiceCommunications.psm1"
    ModuleVersion     = "2.0.1"
    GUID              = "bd4390dc-a8ad-4bce-8d69-f53ccf8e4163"
    Author            = "Matt McNabb"
    Copyright         = "(c) 2020 . All rights reserved."
    Description       = "Gathers data regarding Office 365 Service Health from the Office 365 Service Communications API"
    PowerShellVersion = "5.1"
    FormatsToProcess  = @(
        "Formats/Service.format.ps1xml"
        "Formats/Status.format.ps1xml"
    )
    FunctionsToExport = @()
    PrivateData       = @{
        PSData = @{
            Tags         = "Office365", "REST", "ServiceHealth", "ServiceCommunications"
            LicenseUri   = "https://github.com/mattmcnabb/O365ServiceCommunications/blob/master/O365ServiceCommunications/license"
            ProjectUri   = "https://github.com/mattmcnabb/O365ServiceCommunications"
            Prerelease   = '-alpha'
            ReleaseNotes = @"
            - Issue 19 New tenantparams property returned from API causing errors on object instantiation - fixed

"@
        }
    }
}
