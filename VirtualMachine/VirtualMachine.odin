package VirtualMachine

import "core:fmt"
import "core:os"

Inst_set :: enum i8 {
	PUSH,
	POP,
	PRINT,
	ADD,
	SUB,
	MUL,
	DIV,
}

Inst :: struct {
	type:  Inst_set,
	value: i32,
}

VirtualMachine :: struct {
	programs: [dynamic]^Inst,
	pc:       i32,
	stack:    [1024]i32,
	sp:       i32,
}

vm := new(VirtualMachine)

push :: proc(value: i32) {
	vm.stack[vm.sp] = value
	vm.sp += 1
}

pop_st :: proc() -> i32 {
	if vm.sp <= 0 {
		fmt.eprintln("Stack Underflow!")
		os.exit(1)
	}
	vm.sp -= 1
	return vm.stack[vm.sp]
}

add_inst :: proc(inst: ^Inst) {
	append(&vm.programs, inst)
	vm.pc += 1
}

exec_programs :: proc() {
	for inst in vm.programs {
		switch inst.type {
		case .PUSH:
			push(inst.value)
			break

		case .POP:
			pop_st()
			break

		case .ADD:
			push(pop_st() + inst.value)
			break

		case .SUB:
			push(pop_st() - inst.value)
			break

		case .MUL:
			push(pop_st() * inst.value)
			break

		case .DIV:
			value := pop_st()

			if value == 0 || inst.value == 0 {
				fmt.eprintln("Division by 0")
				os.exit(1)
			}

			push(value / inst.value)
			break

		case .PRINT:
			if vm.sp <= 0 {
				fmt.eprintln("Empty Stack, Inst: Print")
				os.exit(1)
			}

			fmt.println(pop_st())
			break
		}
	}
}
