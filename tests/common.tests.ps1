$ProjectPath = Split-Path $PSScriptRoot

if ($env:APPVEYOR)
{
    $ModuleName = $env:Appveyor_Project_Name
    $Version = $env:APPVEYOR_BUILD_VERSION
}
else
{
    $ModuleName = Split-Path $ProjectPath -Leaf
    $Version = "0.1.0"
}

$ModulePath = Join-Path $ProjectPath $ModuleName
$ManifestPath = Join-Path $ModulePath "$ModuleName.psd1"
if (Get-Module -Name $ModuleName) { Remove-Module $ModuleName -Force }
Import-Module $ManifestPath -Force

Pester\Describe 'PSScriptAnalyzer' {
    Pester\It "passes Invoke-ScriptAnalyzer" {
        $AnalyzeSplat = @{
            Path        = $ModulePath
            ExcludeRule = "PSUseDeclaredVarsMoreThanAssignments"
            Severity    = "Warning"
        }
        Invoke-ScriptAnalyzer @AnalyzeSplat | Should be $null
    }
}

Pester\Describe "Docs" {
    Pester\It "help file exists" {
        $DocsPath = Join-Path $ModulePath "en-US"
        $Doc = Join-Path $DocsPath "$ModuleName-help.xml"
        Test-Path $Doc | Should Be $true
    }
}

# test the module manifest - exports the right functions, processes the right formats, and is generally correct
Pester\Describe "Manifest" {
    $Content = Get-Content -Path $ManifestPath -Raw
    $SB = [scriptblock]::Create($Content)
    $ManifestHash = & $SB

    Pester\It "has a valid manifest" {
        {
            $null = Test-ModuleManifest -Path $ManifestPath -ErrorAction Stop -WarningAction SilentlyContinue
        } | Should Not Throw
    }

    Pester\It "has a valid nested module" {
        $ManifestHash.NestedModules | Should Be "$ModuleName.psm1"
    }

    Pester\It "has a valid Description" {
        $ManifestHash.Description | Should Not BeNullOrEmpty
    }

    Pester\It "has a valid guid" {
        $ManifestHash.Guid | Should Be "bd4390dc-a8ad-4bce-8d69-f53ccf8e4163"
    }

    Pester\It "has a valid version" {
        $ManifestHash.ModuleVersion | Should Be $Version
    }

    Pester\It "has a valid copyright" {
        $ManifestHash.CopyRight | Should Not BeNullOrEmpty
    }

    Pester\It 'exports all public functions' {
        $FunctionFiles = Get-ChildItem "$ModulePath\functions" -Filter *.ps1 | Select-Object -ExpandProperty basename
        $FunctionNames = $FunctionFiles
        $ManifestHash.FunctionsToExport | Should Be $FunctionNames
    }
    
    Pester\It 'has a valid license Uri' {
        $ManifestHash.PrivateData.Values.LicenseUri | Should Be "https://github.com/mattmcnabb/O365ServiceCommunications/blob/master/O365ServiceCommunications/license"
    }
    
    Pester\It 'has a valid project Uri' {
        $ManifestHash.PrivateData.Values.ProjectUri | Should Be "https://github.com/mattmcnabb/O365ServiceCommunications"
    }
    
    Pester\It "gallery tags don't contain spaces" {
        foreach ($Tag in $ManifestHash.PrivateData.Values.tags)
        {
            $Tag -notmatch '\s' | Should Be $true
        }
    }
}

