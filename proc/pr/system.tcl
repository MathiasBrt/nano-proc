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
set_location_assignment -to RESET PIN_T21
set_location_assignment -to CLOCK_50  PIN_L1
set_location_assignment -to KEY[1] PIN_R21 
set_location_assignment -to KEY[0] PIN_R22
set_location_assignment -to Filter_In[7] PIN_F12 
set_location_assignment -to Filter_In[6] PIN_F15 
set_location_assignment -to Filter_In[5] PIN_E14 
set_location_assignment -to Filter_In[4] PIN_H14 
set_location_assignment -to Filter_In[3] PIN_H12 
set_location_assignment -to Filter_In[2] PIN_H13 
set_location_assignment -to Filter_In[1] PIN_G15 
set_location_assignment -to Filter_In[0] PIN_E15 
set_location_assignment -to Filter_Out[7] PIN_F20 
set_location_assignment -to Filter_Out[6] PIN_E18 
set_location_assignment -to Filter_Out[5] PIN_G18 
set_location_assignment -to Filter_Out[4] PIN_G17 
set_location_assignment -to Filter_Out[3] PIN_H17 
set_location_assignment -to Filter_Out[2] PIN_H18 
set_location_assignment -to Filter_Out[1] PIN_N21 
set_location_assignment -to Filter_Out[0] PIN_N15 
set_location_assignment -to ADC_Eocb PIN_D16
set_location_assignment -to ADC_Convstb PIN_G16
set_location_assignment -to ADC_Rdb PIN_F13
set_location_assignment -to DAC_WRb PIN_P18
set_location_assignment -to HEX0[6] PIN_E2 
set_location_assignment -to HEX0[5] PIN_F1 
set_location_assignment -to HEX0[4] PIN_F2 
set_location_assignment -to HEX0[3] PIN_H1 
set_location_assignment -to HEX0[2] PIN_H2 
set_location_assignment -to HEX0[1] PIN_J1 
set_location_assignment -to HEX0[0] PIN_J2 
set_location_assignment -to HEX1[6] PIN_D1 
set_location_assignment -to HEX1[5] PIN_D2 
set_location_assignment -to HEX1[4] PIN_G3 
set_location_assignment -to HEX1[3] PIN_H4 
set_location_assignment -to HEX1[2] PIN_H5 
set_location_assignment -to HEX1[1] PIN_H6 
set_location_assignment -to HEX1[0] PIN_E1 
set_location_assignment -to HEX2[6] PIN_D3 
set_location_assignment -to HEX2[5] PIN_E4 
set_location_assignment -to HEX2[4] PIN_E3 
set_location_assignment -to HEX2[3] PIN_C1 
set_location_assignment -to HEX2[2] PIN_C2 
set_location_assignment -to HEX2[1] PIN_G6 
set_location_assignment -to HEX2[0] PIN_G5 
set_location_assignment -to HEX3[6] PIN_D4 
set_location_assignment -to HEX3[5] PIN_F3 
set_location_assignment -to HEX3[4] PIN_L8 
set_location_assignment -to HEX3[3] PIN_J4 
set_location_assignment -to HEX3[2] PIN_D6 
set_location_assignment -to HEX3[1] PIN_D5 
set_location_assignment -to HEX3[0] PIN_F4 

# Create timing assignments
create_base_clock -fmax "50 MHz" -target clk CLOCK_50

#close project
project_close
