if ($env:APPVEYOR_REPO_COMMIT_MESSAGE -match "^!Deploy")
{
    $ModulePath = Join-Path $env:APPVEYOR_BUILD_FOLDER $env:APPVEYOR_PROJECT_NAME
    Import-Module PowerShellGet -Force
    Publish-Module -Path $ModulePath -NuGetApiKey ($env:PSGallery_Api_Key) -Confirm:$false
}

