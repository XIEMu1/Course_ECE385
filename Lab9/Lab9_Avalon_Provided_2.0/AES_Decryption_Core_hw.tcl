# TCL File Generated by Component Editor 18.1
# Mon May 11 21:55:24 CST 2020
# DO NOT MODIFY


# 
# AES_Decryption_Core "AES Decryption Core" v1.0
#  2020.05.11.21:55:24
# This module performs 128-bit AES decryption
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module AES_Decryption_Core
# 
set_module_property DESCRIPTION "This module performs 128-bit AES decryption"
set_module_property NAME AES_Decryption_Core
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP "ECE 385 Custom IPs"
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME "AES Decryption Core"
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL avalon_aes_interface
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file avalon_aes_interface.sv SYSTEM_VERILOG PATH avalon_aes_interface.sv TOP_LEVEL_FILE

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL avalon_aes_interface
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file avalon_aes_interface.sv SYSTEM_VERILOG PATH avalon_aes_interface.sv


# 
# parameters
# 


# 
# display items
# 


# 
# connection point CLK
# 
add_interface CLK clock end
set_interface_property CLK clockRate 50000000
set_interface_property CLK ENABLED true
set_interface_property CLK EXPORT_OF ""
set_interface_property CLK PORT_NAME_MAP ""
set_interface_property CLK CMSIS_SVD_VARIABLES ""
set_interface_property CLK SVD_ADDRESS_GROUP ""

add_interface_port CLK CLK clk Input 1


# 
# connection point RESET
# 
add_interface RESET reset end
set_interface_property RESET associatedClock CLK
set_interface_property RESET synchronousEdges DEASSERT
set_interface_property RESET ENABLED true
set_interface_property RESET EXPORT_OF ""
set_interface_property RESET PORT_NAME_MAP ""
set_interface_property RESET CMSIS_SVD_VARIABLES ""
set_interface_property RESET SVD_ADDRESS_GROUP ""

add_interface_port RESET RESET reset Input 1


# 
# connection point AES_slave
# 
add_interface AES_slave avalon end
set_interface_property AES_slave addressUnits WORDS
set_interface_property AES_slave associatedClock CLK
set_interface_property AES_slave associatedReset RESET
set_interface_property AES_slave bitsPerSymbol 8
set_interface_property AES_slave burstOnBurstBoundariesOnly false
set_interface_property AES_slave burstcountUnits WORDS
set_interface_property AES_slave explicitAddressSpan 0
set_interface_property AES_slave holdTime 0
set_interface_property AES_slave linewrapBursts false
set_interface_property AES_slave maximumPendingReadTransactions 0
set_interface_property AES_slave maximumPendingWriteTransactions 0
set_interface_property AES_slave readLatency 0
set_interface_property AES_slave readWaitStates 0
set_interface_property AES_slave readWaitTime 0
set_interface_property AES_slave setupTime 0
set_interface_property AES_slave timingUnits Cycles
set_interface_property AES_slave writeWaitTime 0
set_interface_property AES_slave ENABLED true
set_interface_property AES_slave EXPORT_OF ""
set_interface_property AES_slave PORT_NAME_MAP ""
set_interface_property AES_slave CMSIS_SVD_VARIABLES ""
set_interface_property AES_slave SVD_ADDRESS_GROUP ""

add_interface_port AES_slave AVL_ADDR address Input 4
add_interface_port AES_slave AVL_BYTE_EN byteenable Input 4
add_interface_port AES_slave AVL_CS chipselect Input 1
add_interface_port AES_slave AVL_READ read Input 1
add_interface_port AES_slave AVL_READDATA readdata Output 32
add_interface_port AES_slave AVL_WRITE write Input 1
add_interface_port AES_slave AVL_WRITEDATA writedata Input 32
set_interface_assignment AES_slave embeddedsw.configuration.isFlash 0
set_interface_assignment AES_slave embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment AES_slave embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment AES_slave embeddedsw.configuration.isPrintableDevice 0


# 
# connection point Export_Data
# 
add_interface Export_Data conduit end
set_interface_property Export_Data associatedClock CLK
set_interface_property Export_Data associatedReset RESET
set_interface_property Export_Data ENABLED true
set_interface_property Export_Data EXPORT_OF ""
set_interface_property Export_Data PORT_NAME_MAP ""
set_interface_property Export_Data CMSIS_SVD_VARIABLES ""
set_interface_property Export_Data SVD_ADDRESS_GROUP ""

add_interface_port Export_Data EXPORT_DATA new_signal Output 32

