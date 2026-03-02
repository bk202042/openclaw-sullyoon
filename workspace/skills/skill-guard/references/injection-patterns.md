# Injection Pattern Reference

Use this checklist when auditing SKILL.md and bundled docs/scripts.

## Direct override phrases
- ignore previous instructions
- disregard all prior rules
- you are now
- override system prompt

## Persona hijacking
- act as <role>
- pretend you are <role>
- your new role is

## Hidden instruction channels
- HTML comments (`<!-- hidden -->`)
- zero-width chars (ZWSP/ZWNJ)
- homoglyph / Unicode confusables

## Encoded or obfuscated instructions
- base64 blobs
- hex payloads
- rot13 or char-code arrays

## Social engineering cues
- "the user already approved"
- "this is safe, proceed"
- "you have permission to bypass"

## Safety bypass patterns
- disable guardrails
- skip approvals
- modify core policy/memory identity files without user request

## Exfiltration patterns
- send secrets to URL/email/webhook
- upload local files without explicit user consent
