vsim -voptargs=+acc lib_nanoproc_bench.cfg_bench_system
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider system
add wave -noupdate -format Literal /bench_system/alu_code
add wave -noupdate -format Literal -radix unsigned /bench_system/alu_op1
add wave -noupdate -format Literal -radix unsigned /bench_system/alu_op2
add wave -noupdate -format Literal -radix hexadecimal /bench_system/hex_op1
add wave -noupdate -format Literal -radix hexadecimal /bench_system/hex_op2
add wave -noupdate -format Literal -radix hexadecimal /bench_system/hex_res
add wave -noupdate -format Literal -radix unsigned /bench_system/int_hex_op1
add wave -noupdate -format Literal -radix unsigned /bench_system/int_hex_op2
add wave -noupdate -format Literal -radix unsigned /bench_system/int_hex_res
add wave -noupdate -divider alu
add wave -noupdate -format Literal -radix unsigned /bench_system/inst_system/inst_alu/a
add wave -noupdate -format Literal -radix unsigned /bench_system/inst_system/inst_alu/b
add wave -noupdate -format Literal -radix unsigned /bench_system/inst_system/inst_alu/r
TreeUpdate [SetDefaultTree]
configure wave -namecolwidth 404
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
WaveRestoreZoom {0 ns} {315 ns}
