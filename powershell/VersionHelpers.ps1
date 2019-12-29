Function Normalize-Version($ver)
{
  return [Version]::new(
    [Math]::Max($ver.Major, 0),
    [Math]::Max($ver.Minor, 0),
    [Math]::Max($ver.Build, 0),
    [Math]::Max($ver.Revision, 0)
  )
}

Add-Type -TypeDefinition @"
public class FileAndVersion {
  public string FileName { get; set; }
  public System.Version Version { get; set; }
}
"@;

# Enumerates $folder\$wildcard and then finds the version from
# the file using the VersionRegex with named capture group "version"
# And returns the filename with the highest version
Function Find-LatestVersionByPatternInFolder (
  $Folder,
  $Wildcard,
  $VersionRegex
)
{
  $items = @();
  gci $Folder $Wildcard | %{ $_.Name } | %{ if ($_ -match $VersionRegex) {
    $ver = [Version]::Parse($Matches["version"]);
    $items += (New-Object FileAndVersion -Property @{
      FileName = $_;
      Version = $ver;
    });
    Write-Verbose "$_`: $ver";
  } };
  if ($items.Count -eq 0) { throw "No results found: $Folder\$Wildcard matching $VersionRegex"; }

  $MaxVer = ($items | Measure -Property Version -Maximum).Maximum;
  Write-Verbose "Max version: $MaxVer";
  return ($items | ?{ $_.Version -eq $MaxVer })[0];
}

Function Find-NugetLatestPackage($PackagesDir, $PackageName) {
  return (Find-LatestVersionByPatternInFolder $PackagesDir "$PackageName.*" "$PackageName\.(?<version>\d+\.\d+(\.\d+(\.\d+)?)?)").FileName
}
