function Test-SCConnection
{
    if (!$Script:SCConnection)
    {
        throw
    }

    if ($Script:SCConnection.Expires -lt [DateTimeOffset]::Now)
    {
        throw
    }
}
