vsim -sdftyp /bench_system/inst_system=../pr/simulation/modelsim/system_vhd.sdo -sdfnoerror -t ps -voptargs=+acc lib_nanoproc_bench.cfg_bench_system_pr
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /bench_system/clk
add wave -noupdate -format Logic /bench_system/reset
add wave -noupdate -format Logic /bench_system/key_up_op1_b
add wave -noupdate -format Logic /bench_system/key_down_op1_b
add wave -noupdate -format Logic /bench_system/key_up_op2_b
add wave -noupdate -format Logic /bench_system/key_down_op2_b
add wave -noupdate -format Literal -radix binary /bench_system/alu_code
add wave -noupdate -format Literal -radix unsigned /bench_system/int_hex_op1
add wave -noupdate -format Literal -radix unsigned /bench_system/int_hex_op2
add wave -noupdate -format Literal -radix unsigned /bench_system/int_hex_res
add wave -noupdate -format Literal -radix hexadecimal /bench_system/hex_op1
add wave -noupdate -format Literal -radix hexadecimal /bench_system/hex_op2
add wave -noupdate -format Literal -radix hexadecimal /bench_system/hex_res
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
configure wave -namecolwidth 324
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
update
WaveRestoreZoom {0 ps} {630840 ps}
