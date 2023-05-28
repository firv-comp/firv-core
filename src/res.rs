#![no_std]
#![no_main]

use core::{
    arch::global_asm,
    panic::PanicInfo,
};

global_asm!(include_str!("../res/entry.s"));

/// A panic handler is required in Rust, this is probably the most basic one possible
#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}

fn sw_f(a: i32, b: i32) -> i32 {
    let x = a + b;
    let y = a - b;

    return x * y;
}

#[no_mangle]
extern "C" fn main() -> () {
    sw_f(40, 2);
}
