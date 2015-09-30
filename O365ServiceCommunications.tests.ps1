$ModulePath = Split-Path -Parent $MyInvocation.MyCommand.Path
$ModuleName = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -Replace ".Tests.ps1"

$ManifestPath   = "$ModulePath\$ModuleName.psd1"

Describe "Manifest" {
    $Manifest = $null
    It "has a valid manifest" {
        {
            $Script:Manifest = Test-ModuleManifest -Path $ManifestPath -ErrorAction Stop -WarningAction SilentlyContinue
        } | Should Not Throw
    }

    It "has a valid name in the manifest" {
        $Script:Manifest.Name | Should Be $ModuleName
    }

    It "has a valid guid in the manifest" {
        $Script:Manifest.Guid | Should Be 'bd4390dc-a8ad-4bce-8d69-f53ccf8e4163'
    }

    It "has a valid version in the manifest" {
        $Script:Manifest.Version -as [Version] | Should Not BeNullOrEmpty
    }
}