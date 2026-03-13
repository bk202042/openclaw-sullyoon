# OpenClaw Drive Migration Plan

Source: `/Users/macbookair/Documents/문서 - 강병의 MacBook Air/personal/09 openclaw`
Destination root: OpenClaw (`1VnD04mvIMt34xuhCx3DFLBQI-1jH3ALH`)

## Summary
- Planned folder moves: **7**
- Planned root file uploads: **7**
- Root file total size: **2.49 MB**

## Bucket mapping
- `01 Official_docs` → `05_Docs`
- `02 skills` → `03_Skills`
- `03 resource` → `05_Docs`
- `04 config` → `02_Config`
- `05 mission control` → `04_Use_Cases`
- `07 prompts` → `05_Docs`
- `08 PROJECT` → `04_Use_Cases`
- root loose files → ext-based (`docs/assets`)

## Next execution order
1. Create top-level mirror folders under each bucket (same names as source)
2. Upload root loose files
3. Upload high-priority subtree first: `04 config` → `02_Config`
4. Upload remaining folders in parallel-safe batches (2-3 jobs)

CSV: `openclaw_drive_migration_map.csv`
