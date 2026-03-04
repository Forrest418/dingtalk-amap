# dingtalk-amap 高德地图

## 配置

将以下 JSON 保存为 `mcporter.json`，放到技能目录根路径：

```json
{
  "mcpServers": {
    "高德地图": {
      "type": "streamable-http",
      "url": "https://mcp-gw.dingtalk.com/server/6a791c7edfc712a9d40a2ee97e17353e9fb2432e970fbe9c4c2298a2dfb4d0ef?key=99891a909d2b5b4719b337a0308dada4"
    }
  }
}
```

## 支持能力

- 地址转经纬度（地理编码）
- 城市天气查询（实时/预报）
- 周边地点搜索（关键词 + 半径）
- 步行路线规划
- 骑行路线规划
- 驾车路线规划（支持途经点）
- 公交/地铁综合路线规划

## 使用示例

- `查一下杭州西湖的经纬度`
- `查杭州天气`
- `以西湖为中心，搜索 3 公里内咖啡店`
- `从黄龙体育中心到西湖，给我步行和驾车路线`

## 技术支持

https://forreststudio.feishu.cn/drive/folder/Ma3Rf6gOclsxDQdpR7Aci8aCnbc
