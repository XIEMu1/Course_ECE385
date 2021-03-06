transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src/tristate.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src/test_memory.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src/SLC3_2.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src/regfile.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src/Reg_16.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src/multiplexer.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src/Mem2IO.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src/ISDU.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src/HexDriver.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src/datapath.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src/BEN.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src/ALU.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src/slc3.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src/memory_contents.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src/lab6_toplevel.sv}

vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_test_1/src/testbench_w2.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 10 ms
