param(
  [Parameter(Mandatory = $true)][string]$EnvKey,
  [string]$OutFile = ".\flags-raw.json"
)

$ErrorActionPreference = "Stop"
flagsmith get $EnvKey -o $OutFile
$rawOut = Get-Content -Path $OutFile -Raw
$jqOut  = $rawOut | jq -c -f .\scripts\filter-flags.jq | Out-String

$rawTokens = [math]::Ceiling($rawOut.Length / 4)
$jqTokens  = [math]::Ceiling($jqOut.Length / 4)

Write-Output "Raw JSON chars: $($rawOut.Length) (~$rawTokens tokens)"
Write-Output "Filtered jq chars: $($jqOut.Length) (~$jqTokens tokens)"
