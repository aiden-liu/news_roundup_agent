# News Roundup Agent

Run Docker Agent inside a container to generate IT news reports with a custom skill.

## What This Repo Does

- Builds a runtime image that includes the `docker-agent` binary.
- Runs `docker-agent run /workspace/config.yaml` through Docker Compose.
- Mounts local configuration and skills from `.agents` into the container.
- Writes generated report files to `data/`.

## Project Structure

- `compose.yml`: Service and model wiring for local execution.
- `Dockerfile`: Runtime image based on Ubuntu and Docker Agent binary.
- `config.yaml`: Agent/model configuration used by Docker Agent.
- `.agents/skills/news-roundup/SKILL.md`: Skill logic for searching and report generation.
- `data/`: Output folder for generated markdown reports.
- `git.sh`: Helper script for quick add/commit/push.

## Prerequisites

- Docker with Compose support.
- Access to the model endpoint referenced in `compose.yml` (`ai/qwen3:latest`).
- A `.env` file for secrets used by the skill.

## Environment Variables

Create `.env` in repo root and add at least:

```env
TAVILY=your_tavily_api_key
```

Notes:

- `compose.yml` already sets `TELEMETRY_ENABLED=false` for Docker Agent.
- `.env` is loaded by Compose via `env_file`.

## Run

Build and run the service:

```bash
docker compose run --rm --build news-roundup
```

Optional full rebuild without layer cache:

```bash
docker compose build --no-cache news-roundup
docker compose run --rm --build news-roundup
```

## How The Skill Works

The skill in `.agents/skills/news-roundup/SKILL.md` performs:

1. Search recent news via Tavily API.
2. Enrich each article URL with additional context.
3. Generate a markdown report with:
	- summary,
	- article-by-article coverage,
	- key trend bullets.
4. Save output to:

```text
/workspace/data/news-report-YYYYMMDD-HHMMSS.md
```

Because `./data` is mounted to `/workspace/data`, reports appear locally in `data/`.

## Troubleshooting

- If you see Docker Agent telemetry text at startup, that is informational; telemetry is disabled by environment setting.
- If no news is returned, verify `TAVILY` is present and valid in `.env`.
- If model startup fails, check model availability and Docker model/runtime configuration.

## License

See `LICENSE`.
