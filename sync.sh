#!/bin/bash

cd ~/.config/nvim

# Add changes
git add .

# Commit with timestamp
git commit -m "Auto Backup: $(date '+%Y-%m-%d %H:%M:%S')" 2>/dev/null

# Push to the main branch
git push origin main
