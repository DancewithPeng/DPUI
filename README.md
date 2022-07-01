# DPUI

总结的UI开发套件，主要包含控件、扩展、工具

[TOC]

## 导入

### CocoaPods

导入主模块

```ruby
pod 'DPUI', '~> 1.0.0'
```

DPUI支持**subspec**

```ruby
pod 'DPUI/Extensions', '~> 1.0.0'
```

> 支持的**subspec**列表如下：
>
> - DPUI
>   - DPUI/Extensions
>     - DPUI/Extensions/Namespace
>     - DPUI/Extensions/VisiblePage
>   - DPUI/Controls
>     - DPUI/Controls/ImageLayer
>     - DPUI/Controls/PalaceGridView