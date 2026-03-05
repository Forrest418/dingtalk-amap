# dingtalk-amap 高德地图

## 配置

将以下 JSON 保存为 `mcporter.json`，放到技能目录根路径：

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


## 相关技能仓库

- dingtalk-contacts: https://github.com/Forrest418/dingtalk-contacts
- dingtalk-teambition: https://github.com/Forrest418/dingtalk-teambition
- dingtalk-chatgroup: https://github.com/Forrest418/dingtalk-chatgroup
- dingtalk-calendar: https://github.com/Forrest418/dingtalk-calendar
- dingtalk-attendance: https://github.com/Forrest418/dingtalk-attendance
- dingtalk-videomeeting: https://github.com/Forrest418/dingtalk-videomeeting
- dingtalk-amap: https://github.com/Forrest418/dingtalk-amap
