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

    It "has a valid name" {
        $Script:Manifest.Name | Should Be $ModuleName
    }

	It "has a valid root module" {
        $Script:Manifest.RootModule | Should Be "$ModuleName.psm1"
    }

	It "has a valid Description" {
        $Script:Manifest.Description | Should Not BeNullOrEmpty
    }

    It "has a valid guid" {
        $Script:Manifest.Guid | Should Be 'bd4390dc-a8ad-4bce-8d69-f53ccf8e4163'
    }

    It "has a valid version" {
        $Script:Manifest.Version -as [Version] | Should Not BeNullOrEmpty
    }

	It "has a valid prefix" {
		$Script:Manifest.Prefix | Should Not BeNullOrEmpty
	}

	It "has a valid copyright" {
		$Script:Manifest.CopyRight | Should Not BeNullOrEmpty
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
Describe 'Module' {
	InModuleScope O365ServiceCommunications {
		Context 'New-Session'{
			BeforeEach {
				$TestCred = New-Object System.Management.Automation.PSCredential ('testUser', (ConvertTo-SecureString '1234abcD' -AsPlainText -Force))
				$CookieText = 'qwertyuiopasdfghjkl;'
			}

			It 'should output a session object' {
				Mock Invoke-RestMethod {[pscustomobject]@{RegistrationCookie = $CookieText}}
				$Result = New-SCSession -Credential $TestCred
				$Result.PsObject.TypeNames[0] | Should Be $SessionTypeName
			}
		}
		


	}
}