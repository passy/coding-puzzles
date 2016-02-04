public class Main {

    public static void main(String[] args) {
        System.out.println(addsUp(new int[] { 1, 3, 4 }, 2));
    }

    public static long fib(int n) {
        if (n < 1) return 0;
        if (n == 1) return 1;
        if (n == 2) return 1;

        return fib(n - 1) + fib(n - 2);
    }

    public static long fibIter(int n) {
        long a = 0, b = 1;
        for (int i = 1; i < n; i++) {
            long tmp = a;
            a = b;
            b = a + tmp;
        }

        return b;
    }

    public static long fac(int n) {
        if (n == 0) return 1;
        return n * fac(n - 1);
    }

    public static long facIter(int n) {
        int r = 1;
        for (int i = 2; i < n; i++) {
            r *= i;
        }

        return r;
    }

    public static String bigAdd(String a, String b) {
        final int max = Math.max(a.length(), b.length());
        final int[] as = asIntArray(a, max);
        final int[] bs = asIntArray(b, max);

        int carry = 0;
        StringBuilder res = new StringBuilder(max);
        for (int i = 0; i < max; i++) {
            int tmp = as[i] + bs[i] + carry;
            if (tmp >= 10) {
                carry = 1;
                tmp -= 10;
            } else {
                carry = 0;
            }

            res.append(tmp);
        }

        return res.reverse().toString();
    }

    private static int[] asIntArray(final String a, final int l) {
        final int al = a.length();
        final int[] as = new int[l];

        for (int i = 0; i < l; i++) {
            if (i < al) {
                as[i] = a.charAt(al - 1 - i) - '0';
            } else {
                as[i] = 0;
            }
        }

        return as;
    }

    private static boolean addsUp(final int[] arr, final int sum) {
        int i = 0;
        int j = -1;
        int tmp = 0;

        while (j < arr.length - 1) {
            tmp += arr[++j];

            while (tmp > sum) {
                tmp -= arr[i++];
            }

            if (sum == tmp) {
                return true;
            }
        }

        return false;
    }
}
