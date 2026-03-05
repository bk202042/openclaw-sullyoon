---
title: "The Ultimate OpenClaw Secure Setup Guide"
description: "Comprehensive guide on securing OpenClaw installations. Covers sandboxing, docker setup, tool permissions (elevated/allowlist), mounting specific directories, and reviewing skills."
tags: [openclaw, security, sandbox, docker, configuration]
trigger: "openclaw security setup, sandbox guide, securing openclaw"
---

# The Ultimate OpenClaw Secure Setup Guide


## Core Security Principles

The fundamental risk of OpenClaw is its ability to execute terminal commands (`exec` tool), which grants unlimited access to local data. The guide advocates a "deny all, then allow selectively" approach:
1. **Sandbox everything first.**
2. **Gradually ease limitations** for specific use cases.
3. **Verify restrictions** by attempting to hijack the system.
4. **Manually inspect every skill** before installation (checking for malicious commands, data exfiltration, or unauthorized `curl` requests).

## Key Configuration Steps

### 1. Tool Execution Security (The Most Critical Step)
Configure `~/.openclaw/openclaw.json` to always ask for confirmation before executing commands, mitigating risks even without full sandboxing:
```json
"tools": {
  "elevated": {
    "enabled": false
  },
  "exec": {
    "security": "allowlist",
    "ask": "on-miss"
  }
}
```
*Note: Disabling `elevated` ensures tools cannot silently bypass the sandbox into the host OS.*

### 2. Docker Sandboxing
Isolate OpenClaw in a Docker container to strictly control folder and network access.
1. Generate the base sandbox image: `bash scripts/sandbox-setup.sh`
2. Create a custom Dockerfile (e.g., `Dockerfile.sandbox-mcporter`) to install necessary dependencies like `node.js` and `mcporter`.
3. Build the image: `docker build -f Dockerfile.sandbox-mcporter -t openclaw-sandbox-mcporter:latest .`

### 3. Agent Configuration
Configure `~/.openclaw/openclaw.json` to route agents through the custom Docker sandbox:
```json
"agents": {
  "defaults": {
    "sandbox": {
      "mode": "all",
      "scope": "session",
      "workspaceAccess": "none",
      "docker": {
        "network": "bridge",
        "image": "openclaw-sandbox-mcporter:latest",
        "dangerouslyAllowExternalBindSources": true,
        "binds": [
          "/path/to/local/folder:/mnt/docker/folder:ro" 
        ]
      }
    }
  }
}
```
- `mode: "all"` forces all sessions into the sandbox.
- `binds` explicitly maps local directories to the container (use `:ro` for read-only, `:rw` for read/write).
- `dangerouslyAllowExternalBindSources: true` is required in newer versions to enable folder mounting.

### 4. Network Exposure
Ensure the OpenClaw gateway is only accessible via `localhost` (127.0.0.1) and is not exposed to the local network or the internet. Verify this by attempting to access the gateway via your local IP address.

## Skill Installation Discipline
- **Never blindly install skills.**
- Review the `SKILL.md` or scripts for `rm -rf`, unexpected `curl` requests, or attempts to read sensitive directories like `~/.ssh`.
- Install skills manually if necessary, placing them in `~/.openclaw/workspace/skills`.

Source: [Nodus Labs: The Ultimate OpenClaw Secure Setup Guide](https://noduslabs.substack.com/p/ultimate-openclaw-secure-setup)
