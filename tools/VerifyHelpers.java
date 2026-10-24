import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.security.MessageDigest;
import java.util.*;

/** Compares only rebuilt project helpers; it does not certify the whole APK. */
public final class VerifyHelpers {
    private static String hash(String value) throws Exception {
        return HexFormat.of().formatHex(MessageDigest.getInstance("SHA-256")
                .digest(value.getBytes(StandardCharsets.UTF_8)));
    }
    public static void main(String[] args) throws Exception {
        var rebuilt = DexTools.read(Path.of(args[0]));
        var released = DexTools.read(Path.of(args[1]));
        List<String> rows = new ArrayList<>();
        List<String> failures = new ArrayList<>();
        rows.add("class\trebuilt_sha256\treleased_sha256\tmatch");
        int count = 0;
        for (var entry : rebuilt.entrySet()) {
            String name = entry.getKey();
            if (!name.startsWith("Lorg/haotian/palette/")) continue;
            if (name.startsWith("Lorg/haotian/palette/donor/")) {
                throw new AssertionError("Unexpected upstream class in helper build: " + name);
            }
            count++;
            String actual = DexTools.normalized(entry.getValue());
            String expected = released.containsKey(name)
                    ? DexTools.normalized(released.get(name)) : "MISSING";
            boolean matches = actual.equals(expected);
            rows.add(name + "\t" + hash(actual) + "\t" + hash(expected) + "\t" + matches);
            if (!matches) failures.add(name);
        }
        if (count == 0) throw new AssertionError("No project helper classes found");
        Files.write(Path.of(args[2]), rows, StandardCharsets.UTF_8);
        System.out.println("Compared helper classes: " + count);
        if (!failures.isEmpty()) throw new AssertionError("Class mismatches: " + failures);
        System.out.println("PASS: all rebuilt helper classes match R1-d, ignoring debug information and const-string/jumbo encoding");
    }
}
