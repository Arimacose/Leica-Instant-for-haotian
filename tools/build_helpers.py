#!/usr/bin/env python3
"""Compile the published adaptation helpers; optionally compare with R1-d.

This builds a helper JAR/DEX, not an installable or standalone camera APK.
No downloads, signing, installation, or network operations are performed.
"""
from pathlib import Path
import argparse
import hashlib
import json
import os
import shutil
import subprocess
import tempfile
import zipfile

ROOT = Path(__file__).resolve().parents[1]
R1D_SHA256 = "e0b1a7aab318330a71cc2231d681b55478b8c8021be5a842c443248fb20f66b6"


def run(*args):
    subprocess.run([str(arg) for arg in args], check=True, cwd=ROOT)


def sha256(path):
    with Path(path).open("rb") as stream:
        return hashlib.file_digest(stream, "sha256").hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--android-jar", type=Path, required=True)
    parser.add_argument("--d8", type=Path, required=True)
    parser.add_argument("--apktool", type=Path, required=True,
                        help="Apktool 3.0.3 JAR, used for DEX normalization")
    parser.add_argument("--reference-apk", type=Path,
                        help="Optional existing R1-d APK; checked by SHA-256")
    parser.add_argument("--output", type=Path, default=ROOT / "build")
    args = parser.parse_args()
    for item in (args.android_jar, args.d8, args.apktool):
        if not item.is_file():
            parser.error(f"Missing tool/input: {item}")
    if args.reference_apk and sha256(args.reference_apk) != R1D_SHA256:
        parser.error("Reference APK does not match the published R1-d SHA-256")
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=True)
    sources = sorted((ROOT / "src/main/java").rglob("*.java"))
    if not sources:
        parser.error("No helper sources found")
    with tempfile.TemporaryDirectory(prefix="helpers-", dir=output) as stage:
        stage = Path(stage)
        classes, dex, tool_classes = (stage / p for p in ("classes", "dex", "tools"))
        for directory in (classes, dex, tool_classes):
            directory.mkdir()
        run("javac", "-encoding", "UTF-8", "--release", "8", "-classpath",
            args.android_jar.resolve(), "-d", classes, *sources)
        run("jar", "cf", stage / "helpers.jar", "-C", classes, ".")
        run(args.d8.resolve(), "--release", "--min-api", "29", "--lib",
            args.android_jar.resolve(), "--output", dex, stage / "helpers.jar")
        run("javac", "-encoding", "UTF-8", "-cp", args.apktool.resolve(),
            "-d", tool_classes, ROOT / "tools/DexTools.java",
            ROOT / "tools/RelocateReleaseDex.java", ROOT / "tools/VerifyHelpers.java",
            ROOT / "tools/BuildRouting.java")
        tool_cp = os.pathsep.join((str(args.apktool.resolve()), str(tool_classes)))
        run("java", "-cp", tool_cp, "RelocateReleaseDex", dex / "classes.dex",
            stage / "helpers-r1-d.dex")
        # Existing regression tests execute the pure parameter-mapping paths.
        test_cp = os.pathsep.join((str(classes), str(args.android_jar.resolve())))
        run("javac", "-encoding", "UTF-8", "--release", "8", "-cp", test_cp,
            "-d", classes, ROOT / "tests/PaletteValuesTest.java")
        run("java", "-cp", test_cp, "PaletteValuesTest")
        report = {
            "scope": "Published original Java and Smali adaptation helpers only; not the complete APK",
            "java_source_files": len(sources), "palette_regressions": "passed",
            "smali_source_files": len(list((ROOT / "src/main/smali").rglob("*.smali"))),
            "release_identity_normalization": "passed",
            "reference_apk_sha256": R1D_SHA256 if args.reference_apk else None,
            "released_class_comparison": "not_requested",
        }
        reference_dexes = []
        if args.reference_apk:
            with zipfile.ZipFile(args.reference_apk) as archive:
                (stage / "released-classes14.dex").write_bytes(archive.read("classes14.dex"))
                for name in ("classes12.dex", "classes13.dex"):
                    target = stage / ("released-" + name)
                    target.write_bytes(archive.read(name))
                    reference_dexes.append(target)
            run("java", "-cp", tool_cp, "VerifyHelpers", stage / "helpers-r1-d.dex",
                stage / "released-classes14.dex", output / "class-comparison.tsv")
            report["released_class_comparison"] = "passed"
        run("java", "-cp", tool_cp, "BuildRouting", ROOT / "src/main/smali",
            stage / "routing-helpers.dex", *reference_dexes)
        report["routing_class_comparison"] = "passed" if args.reference_apk else "not_requested"
        for filename in ("helpers.jar", "helpers-r1-d.dex", "routing-helpers.dex"):
            shutil.copyfile(stage / filename, output / filename)
        report["artifacts"] = {
            filename: sha256(output / filename)
            for filename in ("helpers.jar", "helpers-r1-d.dex", "routing-helpers.dex")
        }
        (output / "verification.json").write_text(
            json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(report, indent=2))


if __name__ == "__main__":
    main()
