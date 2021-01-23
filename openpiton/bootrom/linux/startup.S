# start sequence of the bootloader
# 
# 
#include <smp.h>
#define DRAM_BASE 0x80000000

  .section .text.init
  .option norvc
  .globl _prog_start
_prog_start:
  li x0, 0
  li x1, 0
  li x2, 0
  li x3, 0
  li x4, 0
  li x5, 0
  li x6, 0
  li x7, 0
  li x8, 0
  li x9, 0
  li x10, 0
  li x11, 0
  li x12, 0
  li x13, 0
  li x14, 0
  li x15, 0
  li x16, 0
  li x17, 0
  li x18, 0
  li x19, 0
  li x20, 0
  li x21, 0
  li x22, 0
  li x23, 0
  li x24, 0
  li x25, 0
  li x26, 0
  li x27, 0
  li x28, 0
  li x29, 0
  li x30, 0
  li x31, 0
  # Enable FPU
  li x31, 0x2000
  csrs mstatus,x31
  csrr a0, mhartid
  li t1, 0
  li t2, MAX_HARTS
  addi t2, t2, -1
  beq t2, t1, _init
  li t4, 0x70000000
  bne a0, t1, _init
loop:
  addi t1, t1, 1
  slli t5, t1, 49
  sd t5, 0(t4)
  bltu t1, t2, loop
_init:
  smp_pause(s1, s2)
  li sp, 0x84000000
  call main
  smp_resume(s1, s2)
  csrr a0, mhartid
  la a1, _dtb
  li s1, DRAM_BASE
  jr s1

  .section .dtb
  .globl _dtb
  .align 4, 0
_dtb:
  .incbin "ariane.dtb"
