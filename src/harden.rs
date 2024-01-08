#![no_std]
#![no_builtins]
#![no_main]

use core::{
    arch::global_asm,
    panic::PanicInfo,
};

global_asm!(include_str!("../res/entry.s"));

/// A panic handler is required in Rust, this is probably the most basic one possible
#[panic_handler]
extern fn panic(_info: &PanicInfo) -> ! {
    loop {}
}

const UART: usize = 0x10000000;
const SYSCON: usize = 0x100000;
const SHUTDOWN: u32 = 0x5555;

unsafe fn mmio_write<T>(addr: usize, value: T) {
    let reg = addr as *mut T;

    reg.write_volatile(value);
}

fn exit() {
    unsafe {
        mmio_write(SYSCON, SHUTDOWN as u32)
    }
}

fn putc(c: char) -> () {
    unsafe{
        mmio_write(UART, c as u8);
        mmio_write(UART, '\n');
    }
}

#[firv_harden]
#[no_mangle]
extern "C"
fn sw_f(a: i32, b: i32) -> i32 {
    let x = a + b;
    let y = a - b;

    return x * y;
}

#[no_mangle]
extern "C" fn main() -> () {
    let y = sw_f(2, 1);

    if y == 3 {
        putc('1');
    } else {
        putc('0');
    }

    exit()
}
