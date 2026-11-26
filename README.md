# flagsmith-safe-rollout

Agent skill for safe Flagsmith feature flag rollouts, token-efficient flag inspection, human approval gating before production changes, and automated rollback with GitHub issue logging.

## Measured Token Efficiency
- **Raw Flagsmith JSON:** 447 chars (~112 tokens)
- **Filtered jq Output:** 47 chars (~12 tokens)
- **Reduction:** ~89.5% fewer context tokens using scripts/filter-flags.jq

## Repository Structure
- SKILL.md - Agent skill instructions, production approval gate, and rollback rules
- scripts/token-estimate.ps1 - Fetches flag JSON via flagsmith get and measures raw vs. filtered token counts
- scripts/check-health.ps1 - Verifies target flag state and optional health URL
- scripts/filter-flags.jq - Normalizes raw flag JSON into compact {name, enabled} entries
- scripts/check-flag.jq - Evaluates whether a specific feature flag is enabled

## Quick Usage
.\scripts\token-estimate.ps1 -EnvKey "YOUR_ENV_KEY"
.\scripts\check-health.ps1 -FeatureName "show_demo_button" -EnvKey "YOUR_ENV_KEY"