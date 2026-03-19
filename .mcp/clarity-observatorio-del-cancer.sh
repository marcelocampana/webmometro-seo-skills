#!/bin/bash
source /Users/marcelocampana/Projects/webmometro-seo-skills/.env
export CLARITY_API_TOKEN="$CLARITY_TOKEN_OBSERVATORIO_DEL_CANCER"
exec npx -y @microsoft/clarity-mcp-server
