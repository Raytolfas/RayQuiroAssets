# RayQuiro

<p align="left">
  <img src="https://img.shields.io/github/stars/Raytolfas/RayQuiroAssets?style=for-the-badge&color=0ea5e9" alt="Stars">
  <img src="https://img.shields.io/github/v/release/Raytolfas/RayQuiroAssets?style=for-the-badge&color=f59e0b" alt="Release">
  <img src="https://img.shields.io/visual-studio-marketplace/v/raytolfas.rayquiro-lang?style=for-the-badge&label=VS%20Code&color=2563eb" alt="VS Code Extension">
</p>

RayQuiro is a Windows-first programming language focused on apps, websites, tools, bots, and experiments.

This is the first public release, `0.0.1`.

## Installation

### Option 1

Download `rqio.exe`, put it in a folder from your `PATH`, then run:

```powershell
rqio version
```

### Option 2

One-line install from GitHub Raw:

```powershell
irm https://raw.githubusercontent.com/Raytolfas/RayQuiroAssets/main/install.ps1 | iex
```

The installer:

- downloads `update.json`
- reads `downloadUrl`
- downloads the latest `rqio.exe` into a temporary folder
- installs it into `C:\rayquiro\bin`
- adds `C:\rayquiro\bin` to the user `PATH`

After install, restart the terminal and run:

```powershell
rqio version
```

## What RayQuiro already has

- `rqio.exe` as the main CLI
- `.rq` source format
- built-in runtime execution
- VM bytecode packages through `.rqb`
- closed app bundles
- `rayquiro.ui`
- `rayquiro.engine`
- `rayquiro.web`
- framework install support
- VS Code extension

## Quick Start

Run a script:

```powershell
rqio file.rq
```

Create a new project:

```powershell
rqio init my-app
cd my-app
rqio
```

Bundle a closed app:

```powershell
rqio pack main.rq
rqio bundle main.rq -o build/my-app
```

## Frameworks

RayQuiro supports installable frameworks from GitHub:

```powershell
rqio framework install RayQuiro/Telebot
rqio framework install RayQuiro/Telebot --local
rqio install telebot
```

Registry source:

```text
https://raw.githubusercontent.com/Raytolfas/RayQuiroAssets/main/frameworks.json
```

## Built-in Capabilities

### `rayquiro.ui`

Native styled UI for apps and installers.

### `rayquiro.engine`

3D/game-style runtime for interactive projects.

### `rayquiro.web`

Live web builder with:

- routes
- `public/` shell
- per-page head tags
- local live port

### VM + `.rqb`

RayQuiro can package supported scripts into bytecode:

```powershell
rqio run --vm file.rq
rqio pack file.rq
rqio bundle file.rq -o build/my-app
```

## First Official Framework: Telebot

`Telebot` is the first larger external RayQuiro framework.

It already supports:

- Bot API helpers
- long polling
- commands
- text replies
- callback handlers
- inline buttons
- documents
- photos

## Examples

The repository keeps 4 main examples:

- `examples/main.rq`
  engine/game demo
- `examples/rayquiro_installer.rq`
  installer app with `rayquiro.ui`
- `examples/web_routes_demo.rq`
  live web demo with routes
- `examples/telebot_demo.rq`
  Telegram bot demo

## Links

- Releases: https://github.com/Raytolfas/RayQuiroAssets/releases
- Framework registry: https://github.com/Raytolfas/RayQuiroAssets
- VS Code extension: https://marketplace.visualstudio.com/items?itemName=raytolfas.rayquiro-lang
- Website: coming soon

## Release Note

For the first runtime-first release, the public-facing shape can stay minimal:

- `rqio.exe`
- `RayQuiro/Telebot`
- `Raytolfas/RayQuiroAssets/frameworks.json`
- `Raytolfas/RayQuiroAssets/update.json`

---

*powered by raytolfas*
