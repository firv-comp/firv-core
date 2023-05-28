#![no_std]
#![no_main]

use core::{arch::global_asm, panic::PanicInfo};

global_asm!(include_str!("../res/entry.s"));

/// A panic handler is required in Rust, this is probably the most basic one possible
#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}

const UART: usize = 0x10000000;
const SYSCON: usize = 0x100000;
const SHUTDOWN: u32 = 0x5555;

unsafe fn mmio_write<T>(addr: usize, value: T) {
    let reg = addr as *mut T;

    reg.write_volatile(value);
}

fn sw_exit() {
    unsafe {
        mmio_write(SYSCON, SHUTDOWN as u32)
    }
}

fn sw_print(s: &str) -> () {
    for c in s.bytes() {
        unsafe{
            mmio_write(UART, c as u8);
        }
    }
}

/// Main program function
#[no_mangle]
extern "C" fn main() -> () {
    sw_print("Hello World!\n");
    sw_exit();
}
