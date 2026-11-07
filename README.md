# Leica一瞬 for haotian

面向小米 15 Pro（haotian）的徕卡一瞬适配。当前正式发布 **R1-e**。

[下载最新 APK](https://github.com/Arimacose/Leica-Instant-for-haotian/releases/download/R1-e/Leica-R1-e.apk) · [查看 R1-e Release](https://github.com/Arimacose/Leica-Instant-for-haotian/releases/tag/R1-e)

**本仓库现公开 R1-d 的部分原创适配层源码，采用 MIT 许可。完整 APK 包含第三方相机代码和资源，不属于整体 MIT 开源；本仓库也不能单独从源码构建完整相机 APK。** 许可边界见 [LICENSING.md](LICENSING.md)。

Leica Instant for haotian is a community camera adaptation for Xiaomi 15 Pro.
This repository publishes the project's original adaptation helpers under MIT;
the complete camera APK depends on third-party components outside that grant.

| 版本 | 说明 |
| --- | --- |
| R1-e（Latest） | 新增实况照片，修复调色盘遮挡画面，大幅优化成片速度，并尝试优化冷启动速度 |
| R2-c | OEM 优先，按环境和输出组合隔离与回退；构建/静态验证通过，本版跨系统和录像效果尚未实测 |

- 两包共用包名与数据，只能择一安装。
- 未修改官方相机、system 或 vendor。该相机可以与官方相机共存，不影响官方相机功能。
- 本相机移植自徕卡一瞬相机，添加了 M9、M3、M10R 三种徕卡滤镜及对应算法，保留了基础的 AI 相机功能，并在原包基础上加入了录像，适配了 Dolby Vision。
- 拍摄后会在后台运算加入徕卡滤镜，R1-e 的处理时间应当普遍在两秒左右。

## R1-e 更新日志

- 增加了拍摄实况照片功能
- 修复打开调色盘遮挡画面的问题
- 大幅优化成片速度，现在的处理时间应当普遍在两秒左右
- 尝试优化冷启动速度

## 已公开的源码

2026-10-24 根据正式 R1-d APK 与保留的适配开发材料整理：

| 路径 | 内容 |
| --- | --- |
| [src/main/java/org/haotian/palette](src/main/java/org/haotian/palette) | 22 个 Java 文件：调色盘、专业模式桥接、配方管理、原生资源适配等 |
| [src/main/smali/org/haotian/leicaport](src/main/smali/org/haotian/leicaport) | 30 个 Smali 文件：相机路由、OEM 拍摄策略、夜景控制、录像停止生命周期等 |
| [tools](tools) | 编译、DEX 身份转换、汇编与已发布类比对工具 |
| [tests](tests) | 现有调色盘参数回归测试 |

源码核验结果：22 个 Java 文件重编译后生成的 **155 个类**，以及重新汇编的 **30 个适配类**，均与 R1-d 中对应类的标准化反汇编一致；现有调色盘回归测试通过。比较忽略调试信息和 `const-string/jumbo` 编码差异。

- [构建与验证方法](docs/BUILD.md)
- [源码来源、覆盖范围与验证记录](docs/SOURCE_PROVENANCE.md)
- [MIT License](LICENSE) 与 [许可范围](LICENSING.md)

构建输出是适配层 JAR/DEX，不是独立可安装的相机。上游相机实现、集成补丁、原生库、算法模型与素材等未包含在本次源码公开范围内。源码对应性检查不代表新增实机拍照或录像验收；完整 APK 的历史发布状态与各功能的实测范围仍应分开判断。

## 历史版本

R1-e（Latest）  
R1-d  
R1-c  
R2-c  
R1 1006a  
R2 1006a  
R1 1004a  
R2 1005a  
R2 1005b
