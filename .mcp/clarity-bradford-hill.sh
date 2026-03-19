#!/bin/bash
source /Users/marcelocampana/Projects/webmometro-seo-skills/.env
export CLARITY_API_TOKEN="$CLARITY_TOKEN_BRADFORD_HILL"
exec npx -y @microsoft/clarity-mcp-server
