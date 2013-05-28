#[warn(deprecated_mode)];
#[warn(deprecated_pattern)];
#[warn(vecs_implicitly_copyable)];
#[deny(non_camel_case_types)];


extern mod llist;

use llist::{LList, Cons, Nil, head, tail};

fn main() {
    let xs : LList<int> = Cons(4, @Cons(8, @Cons(15, @Cons(16, @Nil))));
    println(fmt!("First value: %d", head(xs)));
    println(fmt!("Second value: %d", head(*tail(xs))));
}
