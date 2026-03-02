#!/bin/bash
# QMD Install Script for OpenClaw
# https://github.com/tobi/qmd

set -e

echo "🔍 QMD - Query Markup Documents Installer"
echo "=========================================="

# Check for bun
if ! command -v bun &> /dev/null; then
    echo "❌ Bun is required but not installed."
    echo "   Install: curl -fsSL https://bun.sh/install | bash"
    exit 1
fi

echo "✅ Bun found: $(bun --version)"

# Check for sqlite (macOS)
if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command -v sqlite3 &> /dev/null; then
        echo "⚠️  SQLite not found. Installing via Homebrew..."
        brew install sqlite
    else
        echo "✅ SQLite found"
    fi
fi

# Install qmd globally
echo ""
echo "📦 Installing qmd..."
bun install -g https://github.com/tobi/qmd

# Verify installation
if command -v qmd &> /dev/null; then
    echo ""
    echo "✅ QMD installed successfully!"
    echo ""
    echo "Version: $(qmd --version 2>/dev/null || echo 'installed')"
    echo ""
    echo "Quick start:"
    echo "  qmd collection add ~/.openclaw/memory --name openclaw-memory"
    echo "  qmd embed"
    echo "  qmd search 'your query'"
else
    echo "❌ Installation failed"
    exit 1
fi
