transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlib lab9_soc
vmap lab9_soc lab9_soc
vlog -sv -work lab9_soc +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab9/Lab9_Avalon_Provided_2.0/lab9_soc/synthesis/submodules {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab9/Lab9_Avalon_Provided_2.0/lab9_soc/synthesis/submodules/avalon_aes_interface.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab9/Lab9_Avalon_Provided_2.0 {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab9/Lab9_Avalon_Provided_2.0/SubBytes.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab9/Lab9_Avalon_Provided_2.0 {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab9/Lab9_Avalon_Provided_2.0/KeyExpansion.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab9/Lab9_Avalon_Provided_2.0 {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab9/Lab9_Avalon_Provided_2.0/InvShiftRows.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab9/Lab9_Avalon_Provided_2.0 {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab9/Lab9_Avalon_Provided_2.0/InvMixColumns.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab9/Lab9_Avalon_Provided_2.0 {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab9/Lab9_Avalon_Provided_2.0/AES.sv}
vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab9/Lab9_Avalon_Provided_2.0 {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab9/Lab9_Avalon_Provided_2.0/AddRoundKey.sv}

vlog -sv -work work +incdir+D:/home/Documents/University/Lessons/ECE_385/LAB/Lab9/Lab9_Avalon_Provided_2.0 {D:/home/Documents/University/Lessons/ECE_385/LAB/Lab9/Lab9_Avalon_Provided_2.0/testbench_lab9.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -L lab9_soc -voptargs="+acc"  testbench_lab9

add wave *
view structure
view signals
run 1 ms
