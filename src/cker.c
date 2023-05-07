#define UART 0x10000000

#define SYSCON 0x100000
#define SHUTDOWN 0x5555

void emit_char(char* addr, char c) {
    *addr = c;
}

void emit_int(int* addr, int i) {
    *addr = i;
}

void print(char* str) {
    char c;
    while ((c = *str)) {
        emit_char((char*) UART, c);
        str++;
    } 
}

void print_num(int i) {
    char buf[16];
    char p = 0;

    while (i > 0) {
        buf[p] = '0' + i % 10;

        i /= 10;
        p++;
    }

    while (p --> 0) {
        emit_char((char*) UART, buf[p]);
    }

    emit_char((char*) UART, '\n');
}

void shutdown() {
    emit_int((int*) SYSCON, SHUTDOWN);
}

int gcd(int a, int b) {
    if (b == 0) return a;

    return gcd(b, a % b);
}

int main() {
    print("Hello RISC-V!\n");

    print_num(1234567890);

    shutdown();

    return 0;
}
