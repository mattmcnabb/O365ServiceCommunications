if ($env:APPVEYOR_REPO_COMMIT_MESSAGE -match "^!Deploy")
{
    $ErrorActionPreference = "Stop"
    Import-Module PowerShellGet -Force
    Publish-Module -Path $Env:Build_Path -NuGetApiKey ($env:PSGallery_Api_Key) -Confirm:$false
}
