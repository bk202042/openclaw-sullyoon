#!/bin/bash
# Summarize CLI Installer for OpenClaw
# https://github.com/steipete/summarize

set -e

echo "📝 Summarize CLI Installer"
echo "=========================="

# Check for npm
if ! command -v npm &> /dev/null; then
    echo "❌ npm is required but not installed."
    exit 1
fi

echo "✅ npm found"

# Install summarize globally
echo ""
echo "📦 Installing @steipete/summarize..."
npm install -g @steipete/summarize

# Verify installation
if command -v summarize &> /dev/null; then
    echo ""
    echo "✅ Summarize CLI installed successfully!"
    echo ""
    echo "Version: $(summarize --version 2>/dev/null || echo 'installed')"
    echo ""
    echo "Quick start:"
    echo '  summarize "https://example.com/article"'
    echo '  summarize "/path/to/document.pdf"'
    echo '  summarize "https://youtu.be/..." --youtube auto'
    echo ""
    echo "For Chrome Extension:"
    echo "  1. Install CLI (done)"
    echo "  2. Start daemon: summarize daemon"
    echo "  3. Load Chrome extension"
else
    echo "❌ Installation failed"
    exit 1
fi
