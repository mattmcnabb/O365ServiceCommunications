$Functions = Get-ChildItem -Path "$PSScriptRoot\functions" -File -Filter *.ps1
$Helpers = Get-ChildItem -Path "$PSScriptRoot\helpers" -File -Filter *.ps1


foreach ($Script in ($Functions + $Helpers))
{
    . $Script.FullName
}
