---
name: brave-web-search
description: search the web using Brave Search API with a query as argument. Use this skill when the user asks to search for information on the web.
---
# Brave Web Search

## Command to execute

```bash
curl -s "https://api.search.brave.com/res/v1/web/search?q=$(echo "$ARGUMENTS_REST" | sed 's/ /+/g')&count=10" \
  -H "X-Subscription-Token: ${BRAVE}" \
  -H "Accept: application/json"
```
