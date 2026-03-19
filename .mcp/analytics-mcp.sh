#!/bin/bash
source /Users/marcelocampana/Projects/webmometro-seo-skills/.env
export GOOGLE_APPLICATION_CREDENTIALS="$GOOGLE_APPLICATION_CREDENTIALS"
exec /Users/marcelocampana/.local/bin/analytics-mcp
