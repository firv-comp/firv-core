#![no_std]
#![no_main]

use core::{arch::global_asm, panic::PanicInfo};

global_asm!(include_str!("../res/entry.s"));

/// A panic handler is required in Rust, this is probably the most basic one possible
#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}

enum Reason {
    FI
}

fn SW_f(a: i32, b: i32) -> Result<i32, Reason> {
    let x = a + b;
    let y = a + b;

    if x != y {
        return Err(Reason::FI);
    }

    return Ok(x);
}

#[no_mangle]
extern "C" fn main() -> () {
    SW_f(40, 2);
}
