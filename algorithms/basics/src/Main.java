public class Main {

    public static void main(String[] args) {
        System.out.println(fib(8));
        System.out.println(fibIter(100));
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
}
