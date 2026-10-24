# R1-d adaptation source provenance

Published on 2026-10-24, after the binary R1-d release. This source snapshot
does not change the released APK, its tag, signing identity, or release notes.

## Reference binary

- Release: [R1-d](https://github.com/Arimacose/Leica-Instant-for-haotian/releases/tag/R1-d)
- APK: `Leica-R1-d.apk`
- Package: `com.starry.leica`
- Version: `R1-d` / `660005638`
- SHA-256: `e0b1a7aab318330a71cc2231d681b55478b8c8021be5a842c443248fb20f66b6`
- The local reference hash was checked against the GitHub release asset digest.

## Published coverage

| Source | Origin | Verification |
| --- | --- | --- |
| 22 Java files in `org.haotian.palette` | Retained project-authored source used by the Pro-T1.17-native/R1-d release chain | Recompiled, packaged with R1-d identity substitutions; all 155 generated classes match `classes14.dex` |
| 30 Smali files in `org.haotian.leicaport` | Project-authored routing, night controls, capture policy, and video-stop classes extracted from R1-d `classes12.dex` and `classes13.dex` | Reassembled; complete matching namespace inventory and canonical class bodies |
| `PaletteValuesTest.java` | Existing adaptation-project regression test | Executed successfully against the published Java source |
| DEX and build tools | Project-authored inspection/relocation helpers and publication build tooling | Used for this source snapshot's verification |

The source archive is a **partial original adaptation layer**, not a complete
camera application source release. Some host integration patches, relocated
upstream classes, embedded donor components, native libraries, and image assets
are outside this publication. No claim is made that all code added anywhere in
the composite APK is covered by this snapshot.

## Evidence

- [Source hashes](source-manifest.json)
- [Build verification](source-verification.json)
- [Per-class Java helper comparison](class-comparison.tsv)
- [Build instructions](BUILD.md)
- [License scope and exclusions](../LICENSING.md)

Recorded checks establish correspondence between this source layer and the
existing APK. They do not establish fresh camera/photo/video behavior on a phone.
Historical release documents describe what was published or tested at their
respective dates; statements that all adaptation sources remained local predate
this limited source publication.
