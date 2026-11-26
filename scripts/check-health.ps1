param(
  [Parameter(Mandatory = $true)][string]$FeatureName,
  [Parameter(Mandatory = $true)][string]$EnvKey,
  [string]$HealthUrl = ""
)

$ErrorActionPreference = "Stop"
$tempJson = ".\health-check-flags.json"
flagsmith get $EnvKey -o $tempJson
$matched = Get-Content -Path $tempJson -Raw | jq -r -f .\scripts\check-flag.jq --arg fname "$FeatureName"

if ($matched -ne "true") {
  throw "Feature flag '$FeatureName' is not enabled in environment '$EnvKey'."
}

if ($HealthUrl -ne "") {
  Invoke-WebRequest -Uri $HealthUrl -UseBasicParsing | Out-Null
}
