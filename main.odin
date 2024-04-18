package main

import "core:fmt"

Inst_set :: enum i8 {
  PUSH,
  POP,
  PRINT
}

Inst :: struct {
  type: Inst_set,
  value: i32
}

VirtualMachine :: struct {
  programs: [1024]^Inst,
  pc: i32,
  stack: [1024]i32,
  sp: i32
}

vm := new(VirtualMachine)

push :: proc(value: i32) {
  vm.stack[vm.sp] = value
  vm.sp += 1
}

pop_st :: proc() -> i32 {
  vm.sp -= 1
  return vm.stack[vm.sp]
}

add_inst :: proc(inst: ^Inst) {
  vm.programs[vm.pc] = inst
  vm.pc += 1
}

main :: proc() {
  add_inst(&Inst{.PUSH, 100})
  add_inst(&Inst{.PRINT,0})

  for inst in vm.programs {
    switch inst.type {
      case .PUSH:
        push(inst.value)
        break
      case .POP:
        pop_st()
        break
      case .PRINT:
        fmt.println(pop_st())
        break
    }
  }
}