function Test-SCConnection
{
    if (!$Script:SCConnection)
    {
        return $false
    }

    if ($Script:SCConnection.Expires -lt [DateTimeOffset]::Now)
    {
        return $false
    }

    $true
}
