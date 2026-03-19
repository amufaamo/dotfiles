# Skill: WSL Google Drive (G:) Mount Management

## Overview
WSL2 significantly improves performance for many tasks but can lose access to Windows-mounted drives like Google Drive (G:) after a restart or wake from sleep. This skill documents how to diagnose and fix this issue.

## Diagnosis
If you see an error like:
`<3>WSL (...) ERROR: CreateProcessCommon:790: chdir(/mnt/g/...) failed 19`
Or if `ls /mnt/g` returns "No such device" or is empty.

## Fix: Manual Remount
In your WSL terminal, run:
```bash
sudo mkdir -p /mnt/g
sudo mount -t drvfs G: /mnt/g
```

## Best Practice: Git Operations
When performing `git clone` or other permission-heavy git operations on a Google Drive path, **use Windows natively (PowerShell/CMD)** instead of WSL to avoid `chmod` and metadata permission errors.

```powershell
# In Windows PowerShell:
git clone https://github.com/user/repo.git "G:\My Drive\target_folder"
```

## Related
- Refer to `CLAUDE.md` and `GEMINI.md` for team-wide rules.
