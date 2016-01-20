public class Main {
    public static void main(String... args) {
        final LruCache2 cache = new LruCache2(2);
        cache.set(1, 20);
        cache.set(2, 30);
        cache.set(3, 40);

        System.out.println(cache.get(1));
        System.out.println(cache.get(2));
        System.out.println(cache.get(3));
    }
}
