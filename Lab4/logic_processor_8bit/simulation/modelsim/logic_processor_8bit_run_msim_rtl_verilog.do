transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/logic_processor_8bit/lib {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/logic_processor_8bit/lib/Synchronizers.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/logic_processor_8bit/lib {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/logic_processor_8bit/lib/Router.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/logic_processor_8bit/lib {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/logic_processor_8bit/lib/Reg_4.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/logic_processor_8bit/lib {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/logic_processor_8bit/lib/HexDriver.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/logic_processor_8bit/lib {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/logic_processor_8bit/lib/Control.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/logic_processor_8bit/lib {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/logic_processor_8bit/lib/compute.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/logic_processor_8bit/lib {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/logic_processor_8bit/lib/Register_unit.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/logic_processor_8bit/lib {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/logic_processor_8bit/lib/Processor.sv}

vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/logic_processor_8bit/lib {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/logic_processor_8bit/lib/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 1000 ns
