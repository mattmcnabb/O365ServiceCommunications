@{

# Script module or binary module file associated with this manifest.
RootModule = 'O365ServiceCommunications.psm1'

# Version number of this module.
ModuleVersion = '1.4'

# ID used to uniquely identify this module
GUID = 'bd4390dc-a8ad-4bce-8d69-f53ccf8e4163'

# Author of this module
Author = 'Matt McNabb'

# Company or vendor of this module
# CompanyName = 'Unknown'

# Copyright statement for this module
Copyright = '(c) 2015 . All rights reserved.'

# Description of the functionality provided by this module
Description = 'Gathers data regarding Office 365 Service Health from the Office 365 Service Communications API'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '3.0'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
FormatsToProcess = "Formats\Event.format.ps1xml","Formats\TenantEvent.format.ps1xml"

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module
FunctionsToExport = 'Get-SCEvent','Get-SCServiceInfo','Get-SCTenantEvent','Get-SCTenantServiceInfo','New-SCSession'

# Cmdlets to export from this module
#CmdletsToExport = '*'

# Variables to export from this module
#VariablesToExport = '*'

# Aliases to export from this module
#AliasesToExport = '*'

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess
PrivateData = @{
    PSData = @{
        Tags = 'Office365','REST'
        LicenseUri = 'http://opensource.org/licenses/MIT'
        ProjectUri = 'https://github.com/mattmcnabb/O365ServiceCommunications'
        IconUri = ''
        ReleaseNotes = 'v1.3 used incorrect service URL - fixed'
    }
}

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = 'SC'

}
