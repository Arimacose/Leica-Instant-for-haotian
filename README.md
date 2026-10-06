# Leica一瞬 for haotian

面向小米 15 Pro（haotian）的徕卡一瞬适配。当前正式发布 **R1 1006b** 与 **R2 1006b**。

| 分支 | 方向 | 本版验证范围 | 下载 |
|---|---|---|---|
| R1 1006b（Latest） | 优先 OEM 长焦输入，保留原包徕卡策略 | OS4.0.0.15 / Android17 已安装，维护者手动测试反馈不错；完整量化与录像回归待完成 | [R1 APK](https://github.com/Arimacose/Leica-Instant-for-haotian/releases/download/r1-20261006b/Leica-15Pro-R1-1006b.apk) |
| R2 1006b | OEM 优先，按环境和输出组合隔离与回退 | 构建/静态验证通过；本版跨系统和录像效果尚未实测 | [R2 APK](https://github.com/Arimacose/Leica-Instant-for-haotian/releases/download/r2-20261006b/Leica-15Pro-R2-1006b.apk) |

- [R1 更新与安装说明](R1.md) · [R1 Release](https://github.com/Arimacose/Leica-Instant-for-haotian/releases/tag/r1-20261006b)
- [R2 更新与兼容范围](R2.md) · [R2 Release](https://github.com/Arimacose/Leica-Instant-for-haotian/releases/tag/r2-20261006b)
- 两个 1006b 均为正式 Release，验证范围请以各分支说明为准。HyperOS3 / Android16（含 3.0.7.0）、OS4.0.0.17 和全录像档位仍待验收。
- 120fps 已移除；1080p / 4K、30 / 60fps、杜比按各分支现有能力门控保留。独立原始 SDR 后端继续撤下。
- 两包共用包名与数据，只能择一安装；签名使用公开 AOSP testkey。切换分支前请备份。
- 公开附件为 APK、版本说明和校验值；完整适配源码和详细验证记录保留本机。GitHub 自动生成的 Source code ZIP 仅包含仓库文档。
- 未修改官方相机、system 或 vendor。官方相机完整功能回归尚待完成。

## 历史版本

[R1 1006a 说明](R1-1006a.md) · [Release](https://github.com/Arimacose/Leica-Instant-for-haotian/releases/tag/r1-20261006a)  
[R2 1006a 说明](R2-1006a.md) · [Release](https://github.com/Arimacose/Leica-Instant-for-haotian/releases/tag/r2-20261006a)  
[R1 1004a 说明](R1-1004a.md) · [Release](https://github.com/Arimacose/Leica-Instant-for-haotian/releases/tag/r1-20261004)  
[R2 1005a 说明](R2-1005a.md) · [Release](https://github.com/Arimacose/Leica-Instant-for-haotian/releases/tag/r2-20261005a)  
[R2 1005b 说明](R2-1005b.md) · [Release](https://github.com/Arimacose/Leica-Instant-for-haotian/releases/tag/r2-20261005b)

历史版本说明和验收结果仅适用于对应版本与环境。
