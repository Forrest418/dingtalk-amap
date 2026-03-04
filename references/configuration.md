# Configuration

## Required file

- `./mcporter.json`

## Template

```json
{
  "mcpServers": {
    "高德地图": {
      "type": "streamable-http",
      "url": "https://mcp-gw.dingtalk.com/server/<serverId>?key=<key>"
    }
  }
}
```

## Verify

```bash
./scripts/preflight.sh
```
