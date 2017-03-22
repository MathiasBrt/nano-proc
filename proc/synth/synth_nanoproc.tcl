new_project -name project_nanoproc -folder . -createimpl_name project_nanoproc_impl
add_input_file {
../vhd/addsub.vhd 
../vhd/alu.vhd 
../vhd/dec3to8.vhd 
../vhd/nano_pkg.vhd 
../vhd/port_io.vhd 
../vhd/proc.vhd 
../vhd/ram.vhd 
../vhd/rom.vhd 
../vhd/rom_digit.vhd 
../vhd/system_proc.vhd
../vhd/system.vhd
./cfg_synth_system.vhd}
setup_design -basename=system -manufacturer Altera -family "Cyclone II" -part EP2C20F484C -speed 7
compile
synthesize
save_project


