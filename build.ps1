Import-Module ModuleBuilder -Force
Import-Module PlatyPS -Force

Build-Module -SourcePath "$PSScriptRoot/Source/build.psd1"
$null = New-ExternalHelp -Path "$PSScriptRoot/Docs/" -OutputPath "$PSScriptRoot/Output/en-US"
