transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6/src/tristate.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6/src/test_memory.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6/src/SLC3_2.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6/src/regfile.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6/src/Reg_16.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6/src/multiplexer.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6/src/Mem2IO.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6/src/ISDU.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6/src/HexDriver.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6/src/datapath.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6/src/ALU.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6/src/slc3.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6/src/memory_contents.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6/src/lab6_toplevel.sv}

vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6/src/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 10 ms
