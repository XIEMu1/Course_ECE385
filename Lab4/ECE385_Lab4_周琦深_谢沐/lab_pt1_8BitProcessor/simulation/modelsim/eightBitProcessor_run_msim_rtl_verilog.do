transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/lab_pt1_8BitProcessor/lib {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/lab_pt1_8BitProcessor/lib/Synchronizers.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/lab_pt1_8BitProcessor/lib {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/lab_pt1_8BitProcessor/lib/Router.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/lab_pt1_8BitProcessor/lib {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/lab_pt1_8BitProcessor/lib/Reg_4.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/lab_pt1_8BitProcessor/lib {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/lab_pt1_8BitProcessor/lib/HexDriver.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/lab_pt1_8BitProcessor/lib {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/lab_pt1_8BitProcessor/lib/Control.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/lab_pt1_8BitProcessor/lib {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/lab_pt1_8BitProcessor/lib/compute.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/lab_pt1_8BitProcessor/lib {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/lab_pt1_8BitProcessor/lib/Register_unit.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/lab_pt1_8BitProcessor/lib {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/lab_pt1_8BitProcessor/lib/Processor.sv}

vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/lab_pt1_8BitProcessor/lib {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab4/lab_pt1_8BitProcessor/lib/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run -all
