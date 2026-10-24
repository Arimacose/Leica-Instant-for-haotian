# Licensing scope / 许可范围

The [MIT License](LICENSE) applies to the original adaptation-layer code published
in `src/main/java/org/haotian/palette/` and
`src/main/smali/org/haotian/leicaport/`, and the project-authored tools, tests,
and documentation in this repository.

MIT 许可覆盖本仓库公开的原创适配层、项目自编工具、测试与文档。
它不为第三方代码、资源或完整 APK 提供新的许可。

## Material outside this grant

- The full Leica Instant / Xiaomi camera implementation and donor camera APKs.
- Third-party native libraries, image-processing algorithms, models, LUTs,
  UI resources, filter thumbnails, fonts, trademarks, and branding.
- Third-party bytecode and patched upstream classes outside the published
  original helper namespaces, including relocated donor classes.
- APK assets on the Releases page. Those are composite distributions; this
  repository's MIT license does **not** relicense them as a whole or establish
  permission to redistribute their third-party components.
- Build tools and dependencies obtained separately, including Android SDK,
  D8/R8, Apktool, and HiddenApiBypass. Their own licenses continue to apply.

The helper source references upstream class names, resource identifiers, and
parameter contracts for interoperability. This is not a grant of rights to the
referenced implementation or resources. Users must obtain any required upstream
components lawfully and comply with their applicable terms.

No official affiliation or endorsement by Xiaomi or Leica is implied.

## Why this is a partial source release

The released R1-d APK combines project-authored helpers with upstream camera
components. This publication makes the original helper layer reviewable and
modifiable; it does not claim that the entire APK is open source, nor that this
checkout can reproduce the complete APK from source alone.

The 30 Smali files are disassembled from the project's own
`org.haotian.leicaport` classes in R1-d to preserve their final bytecode state.
They are not a dump of all classes in the APK. The 22 Java files are retained
source files from the release's adaptation workspace, verified against R1-d.

See [source provenance](docs/SOURCE_PROVENANCE.md) for exact coverage and checks.
