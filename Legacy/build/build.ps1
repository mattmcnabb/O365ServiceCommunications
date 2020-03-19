$ProjectPath = Split-Path $PSScriptRoot

if ($env:APPVEYOR)
{
    $ModuleName = $env:APPVEYOR_PROJECT_NAME
    $Version = $env:APPVEYOR_BUILD_VERSION   
    $TestExit = $true 
}
else
{
    $ModuleName = Split-Path $ProjectPath -Leaf
    $Version = '0.1.0'
    $TestExit = $false
}

$ModulePath = Join-Path $ProjectPath $ModuleName

# Update manifest with version number
$ManifestPath = Join-Path $ModulePath "$ModuleName.psd1"
$ManifestData = Get-Content $ManifestPath
$ManifestData = $ManifestData -replace "ModuleVersion = `"\d+\.\d+\.\d+`"", "ModuleVersion = `"$Version`""
$ManifestData | Out-File $ManifestPath -Force -Encoding utf8

# build help file
$DocsPath = Join-Path $ProjectPath "docs"
$DocsOutPutPath = Join-Path $ModulePath "en-US"
$null = New-Item -ItemType Directory -Path $DocsOutPutPath -Force
$null = New-ExternalHelp -Path $DocsPath -OutPutPath $DocsOutPutPath -Encoding ([System.Text.Encoding]::UTF8) -Force

# run tests
Invoke-Pester -EnableExit:$TestExit
