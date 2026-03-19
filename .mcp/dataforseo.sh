#!/bin/bash
source /Users/marcelocampana/Projects/webmometro-seo-skills/.env
export DATAFORSEO_LOGIN="$DATAFORSEO_LOGIN"
export DATAFORSEO_PASSWORD="$DATAFORSEO_PASSWORD"
exec bash -lc "cd /Users/marcelocampana/Projects/mcps/servers/dataforseo-mcp-server && node dist/index.js"
