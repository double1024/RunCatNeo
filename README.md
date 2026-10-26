# RunCat Neo

A running cat in your macOS menu bar that reflects system load.

## Installation

- Requires macOS 26.3 or later.
- [Download from the Mac App Store](https://apps.apple.com/us/app/runcat-neo/id6757801838)

## Custom Metrics

RunCat Neo watches a local JSON file and displays its contents as a dashboard card. Add the file in **Settings → Metrics → Custom Metrics**. The app refreshes the card when the file changes.

### JSON 写法

JSON 文件顶层必须包含 `title`、`metrics` 和 `lastUpdatedDate`。`symbol`、`metricsBarValue` 和 `buttons` 是可选字段。

```json
{
  "title": "音乐播放器",
  "symbol": "music.note",
  "metricsBarValue": "播放中",
  "metrics": [
    {
      "title": "歌曲",
      "formattedValue": "示例歌曲"
    }
  ],
  "buttons": [
    {
      "title": "打开",
      "url": "music-app://open"
    },
    {
      "title": "退出",
      "url": "music-app://quit"
    }
  ],
  "lastUpdatedDate": "2026-10-26T06:30:00Z"
}
```

- `title`：卡片标题；`symbol`：可选的 SF Symbols 图标名称。
- `metrics`：指标数组，每项需要 `title` 和 `formattedValue`。可选的 `normalizedValue` 是 0 到 1 的数值，用于显示进度条。
- `metricsBarValue`：可选的菜单栏指标摘要。
- `buttons`：可选的按钮数组，每项包含按钮文字 `title` 和要打开的 `url`。URL 必须使用目标软件已注册的 URL Scheme。点击按钮只会打开/交由该 Scheme 处理，不会直接控制或强制结束任意软件；“退出”行为需要目标软件自身实现对应的 Scheme。
- `lastUpdatedDate`：必填的 ISO 8601 时间，例如 `2026-10-26T06:30:00Z`。

请使用严格 JSON 格式（不支持注释和尾随逗号），并在写入时采用临时文件后原子替换，避免应用读取到不完整内容。更多字段说明和示例见 [Custom Metrics Schema](docs/CustomMetricsSchema.md)。

RunCat Neo itself does not make outbound network connections. The app sandbox disables outgoing network access, and custom metric buttons reject common network URL schemes. A custom URL Scheme may launch another app; any network activity by that app is outside RunCat Neo's control.

## Requirements

- macOS 26.3 or later
- Xcode 26.2 or later
- Swift 6.2
