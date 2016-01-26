import java.util.Scanner;

public class Solution {
    public static void main(String args[]) {
        final Scanner scanner = new Scanner(System.in);

        final int n = scanner.nextInt();
        final int m = scanner.nextInt();
        final int[] ms = new int[m];

        for (int i = 0; i < m; i++) {
            ms[i] = scanner.nextInt();
        }

        System.out.println(changeWays(ms, n));
    }

    public static long changeWays(int[] coins, int sum) {
        final long[] cache = new long[sum + 1];
        cache[0] = 1;

        for (final int coin : coins) {
            for (int i = coin; i < cache.length; i++) {
                cache[i] += cache[i - coin];
            }
        }
        return cache[sum];
    }
}
