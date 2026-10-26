#!/bin/bash
# Tools installed with their own installers, which keep them updated. Each
# only needs to run when the tool is missing.
set -euo pipefail

# https://code.claude.com/docs/en/quickstart
if ! command -v claude >/dev/null && [ ! -x ~/.local/bin/claude ]; then
  curl -fsSL https://claude.ai/install.sh | bash
fi

# https://docs.astral.sh/uv/getting-started/installation/
if ! command -v uv >/dev/null && [ ! -x ~/.local/bin/uv ]; then
  # ~/.config/shell/env.sh already puts ~/.local/bin on PATH, so keep the
  # installer from editing the shell startup files chezmoi manages.
  curl -LsSf https://astral.sh/uv/install.sh | env UV_NO_MODIFY_PATH=1 sh
fi
