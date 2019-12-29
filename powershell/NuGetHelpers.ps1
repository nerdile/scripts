Function Download-Nuget($nugetexe)
{
  if ([System.IO.File]::Exists($nugetexe)) {
    & $nugetexe update -self
  } else {
    wget https://dist.nuget.org/win-x86-commandline/latest/nuget.exe -OutFile $nugetexe
  }
}

Function Get-NugetLatestPackageVersion($nugetexe, $feedurl, $package)
{
  $pkgs = (& $nugetexe list $package -Source $feedurl -NonInteractive) | ?{ !($_.StartsWith("MSBuild auto-detection")) }
  if ($pkgs[0] -eq "No packages found") { return [Version]::Parse("0.0.0.0"); }
  $same = $pkgs | ?{ $_.Split(" ")[0] -eq $package }
  if ($same.Count -eq 0) { return [Version]::Parse("0.0.0.0"); }
  return [Version]::Parse($same.Split(" ")[1]);
}

