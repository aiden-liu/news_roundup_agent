---
name: tavily-search
description: search the web using Tavily API with a query as argument. Use this skill when the user asks to search for information on the web.
---
# Tavily Search

## Command to execute

```bash
curl -s -X POST https://api.tavily.com/search \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer ${TAVILY}" \
  -d "{\"query\": \"$ARGUMENTS_REST\", \"search_depth\": \"advanced\", \"max_results\": 6, \"time_range\": \"week\"}"
```
