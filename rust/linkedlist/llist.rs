#[link(name="llist", vers="0.1")];
#[crate_type="lib"];
#[desc="An immutable linked list"];
#[warn(deprecated_mode)];
#[warn(deprecated_pattern)];
#[warn(vecs_implicitly_copyable)];
#[deny(non_camel_case_types)];

pub enum LList<T> {
    Cons(T, @LList<T>),
    Nil
}

pub fn head<T>(xs: LList<T>) -> T {
    match xs {
        Cons(x, _) => x,
        Nil => fail!(~"empty list")
    }
}

pub fn tail<T>(xs: LList<T>) -> @LList<T> {
    match xs {
        Cons(_, xss) => xss,
        Nil => fail!(~"empty list")
    }
}


#[test]
fn test_construction() {
    let xs : LList<int> = Cons(4, @Cons(8, @Cons(15, @Cons(16, @Nil))));
    assert!(head(xs) == 4);
    assert!(head(*tail(xs)) == 8);
}
