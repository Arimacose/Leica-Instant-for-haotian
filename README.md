# Leica一瞬 for haotian

当前新增 **R2 更新验证版 1005b（15PRO.R2.1005b）**：补会话状态复位、按会话识别预览结果、提前启动 stop/release 超时，并接入独立公开 SDR 录像后端。

- **[下载 R2 1005b APK](https://github.com/Arimacose/Leica-Instant-for-haotian/releases/download/r2-20261005b/Leica-15Pro-R2-1005b.apk)**
- [R2 1005b 改动、使用方式、测试结果与限制](R2.md)
- [R2 1005b Release / 实际适配代码 / 校验文件](https://github.com/Arimacose/Leica-Instant-for-haotian/releases/tag/r2-20261005b)
- [上一版 R2 1005a 说明](R2-1005a.md) · [上一版发布页](https://github.com/Arimacose/Leica-Instant-for-haotian/releases/tag/r2-20261005a)

本版作为 **预发布验证版**。普通 SDR 点击录制进入独立兼容页面；该通路提供普通影调，未完成徕卡录像 LUT 等价处理。杜比保留原增强后端，超级防抖未获得跨系统效果验证。

Android 16 模拟器上已验证保存、连续录制、封装与完整解码，以及 10 项合成停止/回调断言。模拟器实际帧率没有达到所选 30fps；没有小米 15 Pro 真机验证，不能宣称 HyperOS3/4 的反馈故障已修复。上一版 R2 和 R1 的发布文件保留。

---

## R1 历史说明与验收范围

面向 **小米 15 Pro（haotian）** 的徕卡一瞬相机适配测试版，当前版本 **15PRO.R1.1004a**。

## 下载

- **[下载 Leica-15Pro-R1.apk](https://github.com/Arimacose/Leica-Instant-for-haotian/releases/download/r1-20261004/Leica-15Pro-R1.apk)**
- [版本说明与校验文件](https://github.com/Arimacose/Leica-Instant-for-haotian/releases/tag/r1-20261004)

APK 存放在 **Releases**。GitHub 自动生成的 “Source code (zip/tar.gz)” 仅包含仓库文档，不包含 APK。

| 信息 | 当前版本 |
|---|---|
| 设备 | Xiaomi 15 Pro / haotian（2410DPN6CC） |
| 已验证系统 | Android 17 / API 37，OS4.0.0.15.XOBCNXM |
| 应用包名 | `com.starry.leica` |
| versionName | `15PRO.R1.1004a` |
| versionCode | `660005607` |

## 适配内容

- 主摄、超广角、实体长焦及 Camera5 SAT 镜头协调；修复传感器输入和重复裁切问题。
- 核对 2.6×、3.2× 中间倍率，明亮远景的 5× 照片已确认使用实体长焦。
- 保留 M9、M3、M10R 影调、AI 构图自动拍摄、肤色保护及夜景增强开关。
- 接入原生录像模块，包含分辨率、帧率、杜比视界、音频、编码和保存；修复录像初始化、资源查找及 Android 17 对焦调用兼容问题。
- 保留 **1080p / 4K、30 / 60 fps、SDR / Dolby Vision**；
- 应用独立安装；适配改动位于本应用内，未修改官方相机 APK 或 vendor 录像配置。

## 验证范围与已知限制

开发候选阶段完成了 1080p / 4K × 30 / 60 fps × SDR / 杜比视界八档实机文件验证，检查实际编码、立体声 AAC、时间戳和完整解码。杜比样本含 Main 10、BT.2020 / HLG、DOVI 配置及实际帧 RPU。R1 最终包另完成了杜比录像、原生连续变焦、对焦、前摄和普通拍照检查；没有将候选阶段八档测试表述为 R1 八档全部重录。

官方相机额外回归覆盖前后摄拍照、录像八档及录制中连续变焦，未观察到新增崩溃或 ANR；官方 APK 与两份 vendor 录像配置前后哈希相同。该结果针对所列测试环境，不保证未测模式或以后 ROM 的兼容性。

- 标准立体声 AAC 已验证；音频变焦、定向收音等高级音频功能未完成等价验证。
- 原生界面可能保留 720p30，该档不在专项矩阵内。
- 拍照通路观察到 OIS ON；录像使用原生防抖策略，测试中为 EIS ON / OIS OFF，没有机械防抖效果测量。
- 夜景开关及 MFNR 请求/返回已核对，画质收益未做量化。
- 15 Pro 的三枚后摄无法提供 17 Ultra 第四枚传感器的硬件能力。

本版本作为 **预发布测试版** 提供。

## 安装与签名

下载 APK 后通过 Android 安装器安装，或使用：

```sh
adb install -r Leica-15Pro-R1.apk
```

同证书覆盖更新可保留应用数据；若设备提示签名不一致，先核对现有版本并备份，不要直接卸载或清除数据。这里只验证了本次适配使用的同证书更新条件。

本 APK 使用公开 **AOSP testkey** 签名，证书 SHA-256 为：

```text
a40da80a59d170caa950cf15c18c454d47a39b26989d8b640ecd745ba71bf5dc
```


## 文件校验

APK SHA-256：

```text
8e4d0e66c57410a2e3735965f32195cb4d922067a6e37319c52ed3550865ef78
```

Release 附有 `SHA256SUMS.txt`。本仓库只发布 R1 APK、校验值与说明文档；不包含设备日志、私人照片/录像、应用数据备份或旧候选 APK。
