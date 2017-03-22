new_project -name project_nanoproc -folder . -createimpl_name project_nanoproc_impl
add_input_file {
../vhd/alu.vhd 
../vhd/nano_pkg.vhd
../vhd/rom_digit.vhd 
../vhd/system.vhd}
setup_design -manufacturer Altera -family "Cyclone II" -part EP2C20F484C -speed 7
compile
synthesize
save_project


