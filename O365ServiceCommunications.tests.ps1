$ModulePath = Split-Path -Parent $MyInvocation.MyCommand.Path
$ModuleName = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -Replace ".Tests.ps1"

$ManifestPath   = "$ModulePath\$ModuleName.psd1"
Import-Module $ManifestPath

# test the module manifest - exports the right functions, processes the right formats, and is generally correct
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

	It 'processes all existing format files' {
		$FormatFiles = Get-ChildItem "$ModulePath\Formats\" -Filter *.ps1xml | select -ExpandProperty fullname
		$Script:Manifest.ExportedFormatFiles | Should Be $FormatFiles
	}

	It 'exports all public functions' {
		$FunctionFiles = Get-ChildItem "$ModulePath\Scripts\Public" -Filter *.ps1 | select -ExpandProperty basename
		$FunctionNames = $FunctionFiles | foreach {$_ -replace '-', "-$($Script:Manifest.Prefix)"}
		$Script:Manifest.ExportedFunctions.Values.Name | Should Be $FunctionNames
	}
}

# test the functions inside the module
#describe 'Module' {
#	InModuleScope O365ServiceCommunications {
#		It ''
#	}
#}