#!/bin/bash
source /Users/marcelocampana/Projects/webmometro-seo-skills/.env
export PAGESPEED_API_KEY="$PAGESPEED_API_KEY"
exec node /Users/marcelocampana/Projects/mcps/servers/mcp-server-pagespeed/build/index.js
