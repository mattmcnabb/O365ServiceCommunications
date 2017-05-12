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
Import-Module $ModulePath -Force

Describe 'helper functions' {
    InModuleScope O365ServiceCommunications {
        Context 'New-CustomObject' {
            BeforeEach {
                $InputObject = [PSCustomObject]@{
                    Property1 = 1
                    Property2 = 'two'
                    Property3 = @{hash = 'table'}
                    Property4 = @(4,'four')
                }
                $TypeName = 'Custom'
            }
            
            It 'sets typename' {
                $Object = $InputObject | New-CustomObject -TypeName $TypeName
                $Object.PSObject.TypeNames[0] | Should be $TypeName
            }
            
            It 'adds properties' {
                $Properties = @{Property5 = 5; Property6 = 'six'}
                $Object = $InputObject | New-CustomObject -TypeName $TypeName -ExtraProperties $Properties
                $Object.PSObject.Properties.Name -contains 'Property5' | Should Be $true
                $Object.PSObject.Properties.Name -contains 'Property6' | Should Be $true
            }
            
            It 'excludes properties' {
                $Object = $InputObject | New-CustomObject -TypeName $TypeName -ExcludedProperties 'Property4','Property3'
                $Object.PSObject.Properties.Name -notcontains 'Property3' | Should Be $true
                $Object.PSObject.Properties.Name -notcontains 'Property4' | Should Be $true
            }
            
            It 'outputs all properties' {
                $Object = $InputObject | New-CustomObject -TypeName $TypeName
                $Object.PSObject.Properties.Name.Count | Should Be 4
            }
            
            It 'outputs correct property values' {
                $Object = $InputObject | New-CustomObject -TypeName $TypeName
                $Object.Property1 | Should Be 1
                $Object.Property2 | Should BeExactly 'two'
            }
            
            It 'outputs correct property value types' {
                $Object = $InputObject | New-CustomObject -TypeName $TypeName
                $Object.Property3.GetType().FullName | Should Be 'System.Collections.Hashtable'
                $Object.Property4.GetType().BaseType.FullName | Should Be 'System.Array'
            }
        }
    }
}

Describe 'public functions' {
    InModuleScope O365ServiceCommunications {
        $TestCred = New-Object System.Management.Automation.PSCredential ('testUser', (ConvertTo-SecureString '1234abcD' -AsPlainText -Force))
        
        Context 'New-SCSession'{
            BeforeEach {
                $CookieText = 'qwertyuiopasdfghjkl;'
            }

            It 'should output a session object' {
                Mock Invoke-RestMethod {[pscustomobject]@{RegistrationCookie = $CookieText}}
                $Result = New-SCSession -Credential $TestCred
                $Result.PsObject.TypeNames[0] | Should Be $SessionTypeName
            }
        }
        
        Context 'Get-SCServiceInfo' {
            BeforeEach {
                Mock New-SCSession { [pscustomobject]@{Cookie = 'qwertyuiopasdfghjkl;'; Locale = 'en-US'} | New-CustomObject -TypeName $SessionTypeName }
                Mock Invoke-RestMethod {[PSCustomObject]@{ ServiceInfo = 'ServiceInfoTest' }}
            }
        
            It 'outputs a service info object' {
                $Session = New-SCSession -Credential $TestCred
                $Result = Get-SCServiceInfo -SCSession $Session
                $Result.PSObject.TypeNames[0] | Should Be $ServiceInfoTypeName
            }
        }
        
        Context 'Get-SCEvent' {
            BeforeEach {
                Mock New-SCSession { [pscustomobject]@{Cookie = 'qwertyuiopasdfghjkl;'; Locale = 'en-US'} | New-CustomObject -TypeName $SessionTypeName }
                Mock Invoke-RestMethod {[PSCustomObject]@{ Events = 'EventTest' }}
            }
        
            It 'outputs an event object' {
                $Session = New-SCSession -Credential $TestCred
                $Result = Get-SCEvent -SCSession $Session
                $Result.PSObject.TypeNames[0] | Should Be $EventTypeName
            }
        }
        
        Context 'Get-SCTenantServiceInfo' {
            BeforeEach {
                Mock New-SCSession { [pscustomobject]@{Cookie = 'qwertyuiopasdfghjkl;'; Locale = 'en-US'} | New-CustomObject -TypeName $SessionTypeName }
                Mock Invoke-RestMethod {[PSCustomObject]@{ TenantServiceInfo = 'TenantServiceInfoTest' }}
            }
        
            It 'outputs an service info object' {
                $Session = New-SCSession -Credential $TestCred
                $Result = Get-SCTenantServiceInfo -SCSession $Session -Domains domain.com
                $Result.PSObject.TypeNames[0] | Should Be $TenantServiceInfoTypeName
            }
        }
        
        Context 'Get-SCTenantEvent' {
            BeforeEach {
                Mock New-SCSession { [pscustomobject]@{Cookie = 'qwertyuiopasdfghjkl;'; Locale = 'en-US'} | New-CustomObject -TypeName $SessionTypeName }
                Mock Invoke-RestMethod {[PSCustomObject]@{ Events = 'TenantEventTest' }}
            }
        
            It 'outputs a tenant event object' {
                $Session = New-SCSession -Credential $TestCred
                $Result = Get-SCTenantEvent -SCSession $Session -Domains domain.com
                $Result.PSObject.TypeNames[0] | Should Be $TenantEventTypeName
            }
        }
    }
}
