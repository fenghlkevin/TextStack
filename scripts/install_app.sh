#!/bin/sh
set -eu
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
APP="$ROOT/.build/TextStack.app"
codesign --verify --deep --strict "$APP"
[ "$(/usr/libexec/PlistBuddy -c 'Print :CFBundleName' "$APP/Contents/Info.plist")" = TextStack ]
swift scripts/quit_app.swift
# User preference: replace old application bundles without creating backups.
for name in MrEditor TextStack; do
    if [ -d "/Applications/$name.app" ]; then
        rm -rf "/Applications/$name.app"
    fi
done
ditto "$APP" /Applications/TextStack.app
codesign --verify --deep --strict /Applications/TextStack.app
open /Applications/TextStack.app
sleep 3
ps -axo pid,command | grep '/Applications/TextStack.app/Contents/MacOS/TextStack' | grep -v grep
printf 'Installed: /Applications/TextStack.app (no backup)\n'
