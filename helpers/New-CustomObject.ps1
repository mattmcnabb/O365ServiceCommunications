function New-CustomObject
{
	param
	(
		[Parameter(ValueFromPipeline)]
		[Object]
		$InputObject,

		[Parameter()]
		[hashtable]
		$ExtraProperties,

		[Parameter()]
		[System.String[]]
		$ExcludedProperties,

		[Parameter()]
		[System.String]
		$TypeName
	)

	PROCESS
	{
		$Properties = @{}
		foreach ($Property in $InputObject.PsObject.Properties)
		{
			$PropertyName = $Property.Name
			if ($PropertyName -notin $ExcludedProperties)
			{
				$Properties.$PropertyName = $Property.Value
			}
		}

		if ($ExtraProperties)
		{
			foreach ($Property in $ExtraProperties.GetEnumerator())
			{
				$Properties.Add($Property.Name, $Property.Value)
			}
		}

		$Properties.PSTypeName = $TypeName
		New-Object -TypeName PSCustomObject -Property $Properties
	}
}