Import-Module PlatyPS -Force
# build variables depending on environment
if ($env:APPVEYOR)
{
    $ModuleName = $env:APPVEYOR_PROJECT_NAME
    $Version = $env:APPVEYOR_BUILD_VERSION   
    $TestExit = $true 
}
else
{
    $ModuleName = Split-Path $PSScriptRoot -Leaf
    $Version = '0.1.0'
    $TestExit = $false
}

$ModulePath = Join-Path $PSScriptRoot $ModuleName

# Update manifest with version number
$ManifestPath = Join-Path $ModulePath "$ModuleName.psd1"
$ManifestData = Get-Content $ManifestPath
$ManifestData = $ManifestData -replace "ModuleVersion = `"\d+\.\d+\.\d+`"", "ModuleVersion = `"$Version`""
$ManifestData | Out-File $ManifestPath -Force -Encoding utf8

# build help file
$DocsPath = Join-Path $PSScriptRoot "docs"
$DocsOutPutPath = Join-Path $ModulePath "en-US"
$null = New-Item -ItemType Directory -Path $DocsOutPutPath -Force
$null = New-ExternalHelp -Path $DocsPath -OutPutPath $DocsOutPutPath -Force

# run tests
$TestScript = Join-Path $PSScriptRoot "$ModuleName.tests.ps1"
Invoke-Pester -Script @{Path = $TestScript; Parameters = @{DocsOutputpath = $DocsOutPutPath}} -EnableExit:$TestExit