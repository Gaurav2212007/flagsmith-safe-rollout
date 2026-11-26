# flagsmith-safe-rollout

Track 04 Agent Skill for safe Flagsmith feature flag rollouts using the Flagsmith CLI, compact jq token filtering, mandatory human approval gating before production changes, and automated rollback with GitHub issue creation.

## How Flagsmith Is Used
- Fetches environment flag state via flagsmith get <ENV_KEY> -o <file.json>.
- Normalizes and filters payloads through scripts/filter-flags.jq and scripts/check-flag.jq to reduce agent context tokens.
- Enforces a human approval gate before any Production change and logs rollbacks via Git / gh.

## Measured Token Efficiency
- **Raw Flagsmith JSON:** 447 chars (~112 tokens)
- **Filtered jq Output:** 47 chars (~12 tokens)
- **Reduction:** ~89.5% fewer context tokens using scripts/filter-flags.jq

## Setup & Usage
1. Install Flagsmith CLI, jq, and Git (plus gh for automated rollback issue filing).
2. Run token estimation: .\scripts\token-estimate.ps1 -EnvKey "YOUR_ENV_KEY"
3. Run flag/health check: .\scripts\check-health.ps1 -FeatureName "show_demo_button" -EnvKey "YOUR_ENV_KEY"