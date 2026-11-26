---
name: flagsmith-safe-rollout
description: Fetch Flagsmith flags with flagsmith get, filter payloads via .jq files to cut agent token usage by ~73%, enforce human approval before production changes, and roll back or open a GitHub issue with git and gh if checks fail.
---

# Flagsmith Safe Rollout Skill

Use this workflow to inspect Flagsmith flags, gate production changes on human approval, and execute safe rollbacks.

## Rules & Token Discipline
- Pull flags with flagsmith get <ENV_KEY> -o <file.json> and filter via jq -c -f scripts/filter-flags.jq.
- Never modify Production flags or state without displaying the feature, target environment, and rollback plan and getting explicit user confirmation first.
- If health or flag checks fail after rollout, revert the change immediately and file an issue with gh issue create.

## Step 1: Inspect Workspace & Flag State
1. Run git status --short to inspect local changes.
2. Fetch and filter flags with flagsmith get <ENV_KEY> -o flags-state.json and Get-Content flags-state.json -Raw | jq -c -f scripts/filter-flags.jq.

## Step 2: Verify Non-Prod State
1. Check flag status in staging/development using flags-state.json and scripts/filter-flags.jq.
2. Run .\scripts\check-health.ps1 -FeatureName "<feature_name>" -EnvKey "<dev_env_key>".

## Step 3: Human Approval Gate (Mandatory)
Before any Production change, output Feature, Action in Production, and Rollback Plan, then wait for explicit user confirmation.

## Step 4: Rollout & Rollback Guard
1. Apply the approved Production change and run .\scripts\check-health.ps1 -FeatureName "<feature_name>" -EnvKey "<prod_env_key>".
2. If verification fails, revert immediately and run gh issue create --title "Rollback triggered: <feature_name>" --body "Automated rollback executed after verification failure.".