transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model/tristate_mux41.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model/tristate.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model/test_memory.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model/Synchronizers.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model/SLC3_2.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model/REGFILE.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model/reg_16bit.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model/mux_41_dynamic.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model/mux_21_dynamic.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model/Mem2IO.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model/ISDU.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model/HexDriver.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model/datapath.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model/BEN.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model/ALU.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model/slc3.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model/memory_contents.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model/lab6_toplevel.sv}

vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab6/lab6_model/testbench_w2.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 10 us
