// experimental RLE compression (http://en.wikipedia.org/wiki/Run-length_encoding) for BoxBot game data
// input: ascii string (0x20-0x26: data (7 possible values), >= 0x27: repetition marker)

import java.util.List;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Random;

public class RleCompress {

    public static void main(String[] args) {
        Random random = new Random();
        int[] input = new int[100];
        for (int i = 0; i < input.length; i++) {
            input[i] = random.nextInt(3);
        }

        String compressed = compress(binToAscii(input));
        int[] decompressed = decompress(compressed, input.length);

        System.out.println(String.format("original  : [%s]", binToAscii(input)));
        System.out.println(String.format("compressed: [%s]", compressed));
        System.out.println(String.format("ratio     : %.2f%%", (float) compressed.length() / binToAscii(decompressed).length()));
        System.out.println(String.format("validation: %s", Arrays.equals(input, decompressed)));
    }

    public static String binToAscii(int[] array) {
        StringBuilder builder = new StringBuilder();
        for (int i : array) {
            builder.append((char) (0x20 + i));
        }
        return builder.toString();
    }

    public static String compress(String input) {
        int shift = 0x20;
        StringBuilder compressed = new StringBuilder();
        String u = input + "/";
        Character init = u.toCharArray()[0];
        List<Character> chars = new ArrayList<Character>();
        for (Character c : u.toCharArray()) {
            if (c.equals(init) && chars.size() <= 88) {
                chars.add(c);
            } else {
                if (chars.size() > 2) {
                    compressed.append((char) (chars.size() + shift + 5)).append(chars.get(0));
                } else {
                    for (char ch : chars) {
                        compressed.append(ch);
                    }
                }
                chars.clear();
                init = c;
                chars.add(c);
            }
        }
        return compressed.toString();
    }

    public static int[] decompress(String input, int size) {
        int[] res = new int[size];
        int repeat = 1;
        int index = 0;
        for (char c : input.toCharArray()) {
            if (c >= 0x27) {
                repeat = c - 0x25;
            } else {
                for (int i = 0; i < repeat; i++) {
                    res[index++] = c - 0x20;
                }
                repeat = 1;
            }
        }
        return res;
    }

    private static int[] decompress(String input, int index, int[] output) {
        int repeat = 1;
        int idx = 0;
        int count = 0;
        for (char c : input.toCharArray()) {
            if (c >= 0x27) {
                repeat = c - 0x25;
            } else {
                for (int i = 0; i < repeat; i++) {
                    if (idx >= index * output.length && count < output.length) {
                        output[count++] = c - 0x20;
                    }
                    idx++;
                }
                repeat = 1;
            }
        }
        return output;
    }
}
