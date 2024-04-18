package main

import vm "VirtualMachine"
import "core:fmt"
import "core:os"

main :: proc() {
	using vm

	add_inst(&Inst{.PUSH, 100})
	add_inst(&Inst{.ADD, 10})
	add_inst(&Inst{.SUB, 60})
	add_inst(&Inst{.MUL, 4})
	add_inst(&Inst{.DIV, 10})
	add_inst(&Inst{.PRINT, 0})

	exec_programs()
}

