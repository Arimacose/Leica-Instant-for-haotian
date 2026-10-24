# Building and verifying the adaptation layer

This builds reviewable helper artifacts, **not** a standalone camera app.
It does not download upstream APKs, install anything on a phone, or sign an APK.

## Prerequisites

The verification recorded on 2026-10-24 used:

- Python 3.14 (the script requires Python 3.11 or newer).
- OpenJDK 25.0.3, with `java`, `javac`, and `jar` on `PATH`.
- Android SDK platform 36 (`android.jar`).
- Android SDK build-tools 37.0.0 (`d8.bat` on Windows, `d8` elsewhere).
- Apktool 3.0.3 JAR, used as the Smali assembler and DEX inspection library.

Obtain build tools from their official sources under their own licenses. They
are intentionally not vendored here. Other compiler versions may change generated
bytecode; the recorded release-class comparison uses the versions above.

## Compile and run the existing regression checks

PowerShell example (replace the example paths with your local tool paths):

```powershell
python tools/build_helpers.py `
  --android-jar 'C:/Android/Sdk/platforms/android-36/android.jar' `
  --d8 'C:/Android/Sdk/build-tools/37.0.0/d8.bat' `
  --apktool 'C:/Tools/apktool_3.0.3.jar'
```

For an additional class comparison against an existing, lawfully obtained R1-d
APK, append:

```powershell
  --reference-apk 'C:/Downloads/Leica-R1-d.apk'
```

The script rejects a reference APK whose SHA-256 does not equal:

```text
e0b1a7aab318330a71cc2231d681b55478b8c8021be5a842c443248fb20f66b6
```

The default output directory is `build/` (ignored by Git):

| Artifact | Contents |
| --- | --- |
| `helpers.jar` | Compiled Java helpers; the retained source's pre-release identity strings are still present here |
| `helpers-r1-d.dex` | Java helper DEX with the same identity substitutions used when packaging R1-d |
| `routing-helpers.dex` | Assembled device-routing and video-stop helper classes from the published Smali |
| `class-comparison.tsv` | Per-class canonical hashes for the Java helpers, when a reference APK is supplied |
| `verification.json` | Scope and results of this invocation |

`RelocateReleaseDex` applies only the three historical identity substitutions:
`com.Lieca.test` → `com.starry.leica`, `徕卡一瞬Test` → `Leica一瞬`, and
`Pro-T1.17-native` → `R1-d`. The Java source is retained rather than silently
rewritten. The script verifies that relocation makes no other semantic changes.

## What passing means

- The published Java compiles against Android's public SDK.
- The existing palette parameter regression checks pass, including 10,201
  two-axis combinations, zero/disabled behavior, clamping, and mist presets.
- With `--reference-apk`, all 155 generated Java helper classes match the
  corresponding R1-d classes, and all 30 routing/recording helper classes match
  the published R1-d class inventory for `org.haotian.leicaport`.
- Comparison uses normalized disassembly, ignoring debug information and the
  `const-string` versus `const-string/jumbo` encoding distinction.

This is **not** a new device test, image-quality evaluation, security audit,
or complete-APK reproducibility claim. The helpers depend at runtime on host
integration hooks and third-party camera components not supplied as source here.
JAR timestamps can vary between builds; a JAR's whole-file hash is not used to
claim reproducibility.
