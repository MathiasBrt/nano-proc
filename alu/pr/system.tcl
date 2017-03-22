# create project
project_new system -overwrite

# Assign family, device, and top-level file
set_global_assignment -name FAMILY "Cyclone II"
set_global_assignment -name DEVICE EP2C20F484C7
set_global_assignment -name EDIF_FILE system.edf
set_global_assignment -name EDA_DESIGN_ENTRY_SYNTHESIS_TOOL "Precision Synthesis"
set_global_assignment -name EDA_LMF_FILE mentor.lmf -section_id eda_design_synthesis
set_global_assignment -name EDA_INPUT_DATA_FORMAT EDIF -section_id eda_design_synthesis

# Assign pins
set_location_assignment -to alu_code[1] PIN_L21
set_location_assignment -to alu_code[0] PIN_L22
set_location_assignment -to alu_op1[3] PIN_L2
set_location_assignment -to alu_op1[2] PIN_M1
set_location_assignment -to alu_op1[1] PIN_M2
set_location_assignment -to alu_op1[0] PIN_U11
set_location_assignment -to alu_op2[3] PIN_U12
set_location_assignment -to alu_op2[2] PIN_W12
set_location_assignment -to alu_op2[1] PIN_V12
set_location_assignment -to alu_op2[0] PIN_M22
set_location_assignment -to hex_res[6] PIN_E2 
set_location_assignment -to hex_res[5] PIN_F1 
set_location_assignment -to hex_res[4] PIN_F2 
set_location_assignment -to hex_res[3] PIN_H1 
set_location_assignment -to hex_res[2] PIN_H2 
set_location_assignment -to hex_res[1] PIN_J1 
set_location_assignment -to hex_res[0] PIN_J2 
set_location_assignment -to HEX1[6] PIN_D1 
set_location_assignment -to HEX1[5] PIN_D2 
set_location_assignment -to HEX1[4] PIN_G3 
set_location_assignment -to HEX1[3] PIN_H4 
set_location_assignment -to HEX1[2] PIN_H5 
set_location_assignment -to HEX1[1] PIN_H6 
set_location_assignment -to HEX1[0] PIN_E1 
set_instance_assignment -name RESERVE_PIN "AS OUTPUT DRIVING VCC" -to HEX1[6]
set_instance_assignment -name RESERVE_PIN "AS OUTPUT DRIVING VCC" -to HEX1[5]
set_instance_assignment -name RESERVE_PIN "AS OUTPUT DRIVING VCC" -to HEX1[4]
set_instance_assignment -name RESERVE_PIN "AS OUTPUT DRIVING VCC" -to HEX1[3]
set_instance_assignment -name RESERVE_PIN "AS OUTPUT DRIVING VCC" -to HEX1[2]
set_instance_assignment -name RESERVE_PIN "AS OUTPUT DRIVING VCC" -to HEX1[1]
set_instance_assignment -name RESERVE_PIN "AS OUTPUT DRIVING VCC" -to HEX1[0]
set_location_assignment -to hex_op2[6] PIN_D3 
set_location_assignment -to hex_op2[5] PIN_E4 
set_location_assignment -to hex_op2[4] PIN_E3 
set_location_assignment -to hex_op2[3] PIN_C1 
set_location_assignment -to hex_op2[2] PIN_C2 
set_location_assignment -to hex_op2[1] PIN_G6 
set_location_assignment -to hex_op2[0] PIN_G5 
set_location_assignment -to hex_op1[6] PIN_D4 
set_location_assignment -to hex_op1[5] PIN_F3 
set_location_assignment -to hex_op1[4] PIN_L8 
set_location_assignment -to hex_op1[3] PIN_J4 
set_location_assignment -to hex_op1[2] PIN_D6 
set_location_assignment -to hex_op1[1] PIN_D5 
set_location_assignment -to hex_op1[0] PIN_F4 


# Create timing assignments
create_base_clock -fmax "50 MHz" -target clk CLOCK_50

#close project
project_close
