---
name: dingtalk-amap
description: 高德地图技能（地址转坐标、天气查询、周边搜索、步行/骑行/驾车/公交路线规划）。当用户提到“地图/导航/路线/天气/周边/坐标/高德”时使用。技能通过地图 MCP 调用工具；用户只需在技能目录维护 mcporter.json。
homepage: https://mcp.dingtalk.com
metadata:
  openclaw:
    emoji: "🗺️"
    requires:
      bins: ["mcporter", "jq"]
---

# AMap Skill

Use this skill to:

- Geocode address to coordinates
- Query city weather
- Search POIs around coordinates
- Plan walking, bicycling, driving, and transit routes

## User-Maintained Config (Only)

Users only need to maintain `mcporter.json` in skill root.

## Execution Policy

- Always call via `scripts/mcp.sh`.
- Run `scripts/preflight.sh` before first use.
- Current deployment is read-only query tools.

## Common Workflows

### 1) Address to coordinates

```bash
scripts/geocode.sh --address "杭州西湖"
```

### 2) Weather

```bash
scripts/weather.sh --city "330100" --extensions base
```

### 3) Search around

```bash
scripts/search_around.sh --location "120.153576,30.287459" --keywords "咖啡" --radius 3000
```

### 4) Route planning

```bash
scripts/route_driving.sh --origin "120.153576,30.287459" --destination "120.130203,30.259324"
scripts/route_walking.sh --origin "120.153576,30.287459" --destination "120.130203,30.259324"
scripts/route_bicycling.sh --origin "120.153576,30.287459" --destination "120.130203,30.259324"
scripts/route_transit.sh --city "杭州" --origin "120.153576,30.287459" --destination "120.130203,30.259324"
```

## References

- Config setup: `references/configuration.md`
- Tool discovery: `references/tool-discovery.md`
