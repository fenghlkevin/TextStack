<div align="center">

<img src="art/TextStack.png" width="112" alt="TextStack 图标">

# TextStack

**在 Mac 上阅读大日志、检查数据、编辑 Markdown。**

原生 macOS 文本编辑器 · 本地与 SSH 远程日志 · 多格式预览 · 并排比较与合并

[下载最新版本](https://github.com/fenghlkevin/TextStack/releases/latest) · [图文使用手册](docs/user-guide.md) · [反馈问题](https://github.com/fenghlkevin/TextStack/issues)

**简体中文** | [English](README.en.md) | [日本語（历史版本）](README.ja.md)

</div>

![日志、CSV、JSON 与差异比较四种工作场景](docs/img/four-kinds-of-text.jpg)

> 截图来自项目已有版本，部分窗口仍显示旧名 MrEditor；当前产品统一为 TextStack。截图用于展示功能，实际界面以安装版本为准。

## 为什么使用 TextStack

从数 GB 的日志里找出错误，展开接口返回的 JSON，核对 CSV 数据，再对比两份配置。TextStack 把这些日常操作放进同一个原生工作区，支持简体中文、英文和日文界面。

| 你要做的事 | TextStack 提供的工具 |
| --- | --- |
| 排查大型日志 | 大文件读取、后台全文搜索、正则、匹配行筛选、上下文和末尾跟随 |
| 分析异常时段 | 时间轴、级别统计、时间范围和字段精确筛选、结果导出 |
| 检查结构化数据 | JSON 树、CSV/TSV 表格、NDJSON 记录浏览、格式化与数据清洗 |
| 编写技术文档 | Markdown 实时预览、公式、Mermaid、目录，以及 HTML/PDF/PNG 导出 |
| 核对配置变更 | 并排行级与字符级差异、手动编辑与采纳差异、独立保存合并结果 |
| 阅读服务器日志 | SSH 连接管理、远程目录、服务器侧过滤、跟随与重连 |

## 功能截图

### 大文件与日志搜索

使用内存映射、稀疏行索引与可见行绘制读取大文件，配合增量编辑结构处理修改。支持正则、大小写、多词 AND 查询和只显示匹配行；筛选结果保留原始行号，并可展开上下文。

![大型日志全文搜索与匹配高亮](docs/img/search-10gb-dark.png)

- 行号跳转、书签、ANSI 日志颜色、自动换行和实时跟随。
- 时间轴与 ERROR/FATAL、WARN 统计；按时间范围或字段值筛选并导出完整结果。
- UTF-8、UTF-16、GB18030/GBK、Shift-JIS、EUC-JP 编码支持，以及字符和换行检查。
- gzip/zip 自动识别；支持命令行文件参数和标准输入。

[查看 10 GB 日志演示](docs/media/mreditor-10gb.mp4)。该视频来自历史版本，实际速度取决于硬件、文件内容和操作，不作为当前版本的性能承诺。

### JSON、CSV 与记录检查

源码之外，使用结构化视图阅读嵌套对象与表格，减少在密集文本中逐字符核对的工作。

![JSON 原文与结构化展示](docs/img/json_structured_before_after.png)

![CSV 原文与列对齐展示](docs/img/csv_structured_before_after.png)

- **JSON**：折叠树、节点定位、分页加载；格式化生成新文档，保留键顺序、重复键与数字原始写法。
- **CSV/TSV**：表头开关、列宽和列顺序调整、记录过滤、单元格详情及宽表分页。
- **NDJSON**：逐条查看记录，也可导出为 JSON 数组。
- **数据清洗**：去空白、处理空值、类型转换与按列去重，导出到独立文件。

### Markdown 与多格式预览

在源码旁查看渲染结果，支持双向比例滚动同步、浅色和深色外观。内置渲染器、字体和样式，普通预览无需联网。

![Markdown 预览：代码高亮、公式、Mermaid、提示块与表格](docs/img/markdown-preview.png)

*此图为项目渲染器的真实 WebKit 测试截图，展示预览内容区域。*

| 格式 | 预览能力 |
| --- | --- |
| Markdown | CommonMark/GFM、语法高亮、KaTeX、Mermaid、目录、任务列表、脚注、GitHub Alerts |
| JSON / YAML | 可折叠树、全部展开与折叠、解析错误提示 |
| CSV / TSV | 固定表头、列宽调整、排序和文本过滤 |
| 代码 / 配置 / 日志 | 语言高亮、行号、搜索和日志级别着色 |
| Mermaid / HTML / SVG | 图表、清理后的文档与矢量图预览 |

Markdown 可导出带内嵌资源的 HTML、分页 PDF 和 PNG 长图。应用还包含 Finder Quick Look 扩展；启用后选中文件按空格查看，最终提供程序由 Finder 决定。

### 并排比较与合并

比较两个文件、已打开文档、剪贴板或 HTTPS URL 内容，定位行级和字符级变化。

![并排差异比较](docs/img/diff_vew.png)

比较后可在右侧编辑合并结果，点击差异块采纳左侧内容，配合同步滚动、差异导航和撤销。合并结果另存为独立文件，保留两个原文件。手动合并编辑支持每侧最多 16 MiB、50,000 行；更大文件使用流式按块合并。

### 远程工作区与日常编辑

- **SSH**：密码、私钥、加密私钥、SSH Agent、跳板机；远程目录浏览、按需读取、服务器侧过滤和跟随。凭据可存入 macOS Keychain，首次连接确认主机指纹。
- **编辑**：多光标、矩形列选择、查找全部、逐项勾选的替换预览，以及跨目录搜索与替换。
- **工作区**：本地与服务器分区、多文档切换、会话与未保存草稿恢复、Finder 打开和打印。
- **外观**：主题、等宽字体、行距、插入符和背景透明度设置。

## 下载与快速开始

要求 **macOS 13 或更新版本**。从 [GitHub Releases](https://github.com/fenghlkevin/TextStack/releases/latest) 下载 DMG，将 `TextStack.app` 拖入 Applications 后打开。每次发布的处理器架构和签名状态见对应发布说明；本地 ad-hoc 签名包不等于 Apple 公证包。

1. 按 `⌘O` 打开日志、文本、JSON、CSV 或 Markdown，也可以直接拖入文件。
2. 按 `⌘F` 搜索，启用“仅匹配行”聚焦结果；用 `⌘L` 跳到原始行。
3. 在“显示方式”选择结构化视图或预览，按 `⇧⌘D` 比较文件。
4. 使用“格式”菜单分析日志、清洗数据或导出 Markdown。

完整操作步骤见 [图文使用手册](docs/user-guide.md)，应用内通过 **帮助 → TextStack 功能使用说明** 离线阅读。

## 使用范围

- 编辑器分栏预览面向不超过 **8 MiB** 的文件；Quick Look 最多读取 **4 MiB**，超限会提示截断。大文件继续使用文本编辑器。
- 表格、树、搜索和工具预览存在各自的显示上限，预览样本不代表全部导出结果；详见各功能文档。
- HTML/SVG 预览会清理脚本、样式与外部资源；远程图片被阻止，本地图片访问限定在文档目录。
- SSH 窗格用于阅读、过滤和跟随，分析范围为已加载片段；断线重连不保证补齐全部日志。
- 跨目录替换会先备份原文件；操作前核对勾选项，恢复方法见 [排查工具说明](docs/investigation-tools.md)。

## 从源码构建

需要 macOS 13+、Swift 5.9+（Xcode 15+）与 Python 3。

```sh
git clone https://github.com/fenghlkevin/TextStack.git
cd TextStack
swift build -c release
sh scripts/make_app.sh release
codesign --verify --deep --strict .build/TextStack.app
open .build/TextStack.app
```

安装到 Applications 并验证启动：

```sh
sh scripts/install_app.sh
```

安装脚本正常退出应用，保留未保存文档确认流程，然后直接替换旧程序并启动，不创建旧程序备份。

预览资源已随仓库提交，普通 Swift 构建无需 Node.js。修改 `web-renderer/` 后先执行 `sh scripts/build_markdown_renderer.sh`。制作 Apple Silicon 与 Intel 通用 DMG 使用 `sh scripts/make_dmg.sh`。

可选命令行入口：

```sh
sh scripts/install-cli.sh
mreditor /path/to/app.log
cat /path/to/app.log | mreditor
```

## 文档与贡献

- [图文使用手册](docs/user-guide.md) · [预览说明](docs/markdown-preview.md) · [Markdown 示例](docs/markdown-preview-demo.md)
- [日志与数据排查工具](docs/investigation-tools.md) · [SSH 连接说明](docs/SSH_CONNECTIONS.md)
- [大文件架构](docs/ARCHITECTURE_v0.1.md) · [贡献指南](CONTRIBUTING.md) · [提交问题](https://github.com/fenghlkevin/TextStack/issues)

## 开源许可

TextStack 基于 MrEditor 持续开发，原始代码采用 [MIT 许可](LICENSE)，© 2026 TABATA Hitoshi。项目目录、部分模块名、命令行入口与历史截图仍保留 MrEditor 名称。

第三方组件许可随应用的 `ThirdPartyNotices.txt` 分发；DOMPurify 选择 Apache-2.0 许可。预览集成来源及依赖说明见 [UPSTREAM.md](web-renderer/UPSTREAM.md)。
