#!/bin/bash
source /Users/marcelocampana/Projects/webmometro-seo-skills/.env
export GOOGLE_APPLICATION_CREDENTIALS="$GSC_CREDENTIALS"
exec npx -y mcp-server-gsc
