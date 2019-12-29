Function Check-LastExitCode ($cmd)
{
  if ($LASTEXITCODE -ne 0) { throw "$cmd failed with $LASTEXITCODE"; }
}

Function Run-Command ($cmd)
{
  Write-Verbose "Executing: $cmd";
  iex $cmd;
  Check-LastExitCode $cmd;
}