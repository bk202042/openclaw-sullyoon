---
title: GWS Automation OS
description: Plan to use Google Workspace CLI skills to build an automated OS for VIP consulting.
tags: [gws, automation, consulting, crm, operations]
trigger: Reference this when setting up or modifying the GWS automation pipeline for sales and delivery.
---

# GWS Automation OS Plan

## Goal
Convert Google Workspace into an automated Operating System (OS) to reduce admin noise to zero, allowing 100% focus on high-leverage work (sales, strategy, VIP case studies).

## Phase 1: Leverage Engine (Sales & CRM)
- **Inbound Filtering**: Use `gws-gmail-triage` to filter out non-VIP noise.
- **Lightweight CRM**: Use `gws-sheets` as a highly efficient CRM for target lists and deal pipelines.
- **Deep Work Protection**: Use `recipe-block-focus-time` to enforce deep work blocks on the calendar, allowing only VIP meetings.

## Phase 2: Delivery Engine (Consulting Execution)
- **Asset Generation**: Use `gws-drive` and `gws-docs` to automatically provision dedicated client folders and workflow audit skeleton documents immediately upon closing a deal.

## Phase 3: Autopilot (Daily Operations)
- **Daily Briefing**: Use `gws-workflow-standup-report` running on a cron schedule for morning summaries.
- **Actionable Inbox**: Use `gws-workflow-email-to-task` to push only critical emails requiring deep thought into Google Tasks.

## Next Actions
- Initialize the VIP target and pipeline CRM using `gws-sheets`.
