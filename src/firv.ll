target datalayout = "e-m:e-p:32:32-i64:64-n32-S128"
target triple = "riscv32"

define i32 @sw_f(i32 %a, i32 %b) unnamed_addr #1 {
  %x = add i32 %a, %b
  %y = sub i32 %a, %b
  %1 = mul i32 %x, %y
  ret i32 %1
}

define i32 @sw_f_hardened(i32 %a, i32 %b) unnamed_addr firv_harden #1 {
  %x = add i32 %a, %b
  %y = sub i32 %a, %b
  %1 = mul i32 %x, %y
  ret i32 %1
}

attributes #1 = { nounwind "target-cpu"="generic-rv32" "target-features"="+m,+a,+c" }
