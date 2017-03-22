vsim -voptargs=+acc lib_nanoproc_bench.cfg_bench_system
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider system
add wave -noupdate -format Logic /bench_system/clk
add wave -noupdate -format Logic /bench_system/reset
add wave -noupdate -format Literal -radix binary /bench_system/alu_code
add wave -noupdate -format Literal -radix hexadecimal /bench_system/hex_op1
add wave -noupdate -format Literal -radix hexadecimal /bench_system/hex_op2
add wave -noupdate -format Literal -radix hexadecimal /bench_system/hex_res
add wave -noupdate -format Logic /bench_system/key_up_op1_b
add wave -noupdate -format Logic /bench_system/key_down_op1_b
add wave -noupdate -format Logic /bench_system/key_up_op2_b
add wave -noupdate -format Logic /bench_system/key_down_op2_b
add wave -noupdate -format Literal -radix unsigned /bench_system/int_hex_op1
add wave -noupdate -format Literal -radix unsigned /bench_system/int_hex_op2
add wave -noupdate -format Literal -radix unsigned /bench_system/int_hex_res
add wave -noupdate -divider alu
add wave -noupdate -format Literal -radix unsigned /bench_system/inst_system/inst_alu/a
add wave -noupdate -format Literal -radix unsigned /bench_system/inst_system/inst_alu/b
add wave -noupdate -format Literal -radix binary /bench_system/inst_system/inst_alu/alu_code
add wave -noupdate -format Literal -radix unsigned /bench_system/inst_system/inst_alu/r
add wave -noupdate -divider {sm op1}
add wave -noupdate -format Logic /bench_system/inst_system/inst_key_fsm_op1/key_up
add wave -noupdate -format Logic /bench_system/inst_system/inst_key_fsm_op1/key_down
add wave -noupdate -format Literal -radix unsigned /bench_system/inst_system/inst_key_fsm_op1/val
add wave -noupdate -format Literal /bench_system/inst_system/inst_key_fsm_op1/cur_state
add wave -noupdate -format Literal /bench_system/inst_system/inst_key_fsm_op1/nxt_state
add wave -noupdate -format Literal -radix unsigned /bench_system/inst_system/inst_key_fsm_op1/cur_val
add wave -noupdate -format Literal -radix unsigned /bench_system/inst_system/inst_key_fsm_op1/nxt_val
add wave -noupdate -format Logic /bench_system/inst_system/inst_key_fsm_op1/sync_key_up
add wave -noupdate -format Logic /bench_system/inst_system/inst_key_fsm_op1/sync_key_down
add wave -noupdate -divider sm_op2
add wave -noupdate -format Logic /bench_system/inst_system/inst_key_fsm_op2/key_up
add wave -noupdate -format Logic /bench_system/inst_system/inst_key_fsm_op2/key_down
add wave -noupdate -format Literal -radix unsigned /bench_system/inst_system/inst_key_fsm_op2/val
add wave -noupdate -format Literal /bench_system/inst_system/inst_key_fsm_op2/cur_state
add wave -noupdate -format Literal /bench_system/inst_system/inst_key_fsm_op2/nxt_state
add wave -noupdate -format Literal -radix unsigned /bench_system/inst_system/inst_key_fsm_op2/cur_val
add wave -noupdate -format Literal -radix unsigned /bench_system/inst_system/inst_key_fsm_op2/nxt_val
add wave -noupdate -format Logic /bench_system/inst_system/inst_key_fsm_op2/sync_key_up
add wave -noupdate -format Logic /bench_system/inst_system/inst_key_fsm_op2/sync_key_down
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
configure wave -namecolwidth 537
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
WaveRestoreZoom {0 ns} {420 ns}
