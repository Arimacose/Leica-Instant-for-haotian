# Leica一瞬 for haotian

新增 **R1 1006a画质回归更新**与 **R2 1006a原包处理链路兼容验证版**，面向小米15 Pro（haotian）。

| 分支 | 本次目的 | 验证范围 | 下载 |
|---|---|---|---|
| R1 1006a | 恢复原包拍照输入及徕卡曝光/白平衡，保留原生录像 | OS4.0.0.15/Android17，最终APK 11张照片和一段4K30杜比录像已保存并完整解码 | [R1 APK](https://github.com/Arimacose/Leica-Instant-for-haotian/releases/download/r1-20261006a/Leica-15Pro-R1-1006a.apk) |
| R2 1006a（Pre-release） | 移除独立原始SDR，沿用原录像处理链路并按能力适配 | 新录像仅构建/静态校验；此前拍照候选23张OEM/JPEG/YUV照片已验证 | [R2 APK](https://github.com/Arimacose/Leica-Instant-for-haotian/releases/download/r2-20261006a/Leica-15Pro-R2-1006a.apk) |

R2不再跳转缺少徕卡处理的独立SDR页面。普通录像仍可采用标准SDR编码，但使用原相机的界面、控制器、输入Surface、处理入口和保存链路。杜比保留原增强录制器。新录像方案待实测，不能宣称已修复HyperOS3/Android16（含3.0.7.0）或OS4.0.0.17的反馈故障。

- [R1本版说明](R1.md) · [R1 Release](https://github.com/Arimacose/Leica-Instant-for-haotian/releases/tag/r1-20261006a)
- [R2本版说明与限制](R2.md) · [R2 Release](https://github.com/Arimacose/Leica-Instant-for-haotian/releases/tag/r2-20261006a)
- 120fps已移除；两分支共用包名和数据，不能并装。使用公开AOSP testkey；安装/降级注意事项见版本说明。
- 本轮未修改官方相机APK、vendor/system或下载ROM。新版本的官方相机功能回归仍待完成。
- 本轮公开资产为APK、说明和校验值。GitHub自动Source code压缩包仅含仓库文档。本轮完整适配源码和详细本地验证资料未公开上传，发布不含私人媒体、日志、数据备份或私钥。

## 历史版本

[R1 1004a说明](R1-1004a.md) · [Release](https://github.com/Arimacose/Leica-Instant-for-haotian/releases/tag/r1-20261004)  
[R2 1005a说明](R2-1005a.md) · [Release](https://github.com/Arimacose/Leica-Instant-for-haotian/releases/tag/r2-20261005a)  
[R2 1005b说明](R2-1005b.md) · [Release](https://github.com/Arimacose/Leica-Instant-for-haotian/releases/tag/r2-20261005b)

历史资产和Release状态保留；各说明中的验证结果只适用于对应版本及环境。
