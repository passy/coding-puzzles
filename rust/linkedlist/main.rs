// A functional singly-linked list

enum LList<T> {
    Cons(T, @LList<T>),
    Nil
}

fn head<T>(xs: LList<T>) -> T {
    match xs {
        Cons(x, _) => x,
        Nil => fail!(~"empty list")
    }
}

fn tail<T>(xs: LList<T>) -> @LList<T> {
    match xs {
        Cons(_, xss) => xss,
        Nil => fail!(~"empty list")
    }
}

fn main() {
    let xs : LList<int> = Cons(4, @Cons(8, @Cons(15, @Cons(16, @Nil))));
    println(fmt!("First value: %d", head(xs)));
    println(fmt!("Second value: %d", head(*tail(xs))));
}
