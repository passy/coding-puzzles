public class Main {

    public static void main(String[] args) {
        System.out.println(facIter(10));
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
}
