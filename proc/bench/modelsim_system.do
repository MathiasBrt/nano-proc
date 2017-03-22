vsim -voptargs=+acc lib_nanoproc_bench.cfg_bench_system
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /bench_system/u1/reset
add wave -noupdate -format Logic /bench_system/u1/clock_50
add wave -noupdate -divider touches
add wave -noupdate -format Literal /bench_system/u1/key
add wave -noupdate -divider afficheur
add wave -noupdate -format Literal /bench_system/hex0
add wave -noupdate -format Literal /bench_system/hex1
add wave -noupdate -format Literal /bench_system/hex2
add wave -noupdate -format Literal /bench_system/hex3
add wave -noupdate -format Literal -radix hexadecimal /bench_system/int_hex0
add wave -noupdate -format Literal -radix hexadecimal /bench_system/int_hex1
add wave -noupdate -format Literal -radix hexadecimal /bench_system/int_hex2
add wave -noupdate -format Literal -radix hexadecimal /bench_system/int_hex3
add wave -noupdate -divider adc
add wave -noupdate -format Literal -radix unsigned /bench_system/u1/filter_in
add wave -noupdate -format Analog-Step -radix unsigned -scale 0.039 /bench_system/u1/reg_d
add wave -noupdate -format Analog-Step -radix unsigned -scale 0.039 /bench_system/u1/reg_q
add wave -noupdate -format Logic /bench_system/u1/adc_convstb
add wave -noupdate -format Logic /bench_system/u1/eocb_sync
add wave -noupdate -format Logic /bench_system/u1/adc_eocb
add wave -noupdate -format Logic /bench_system/u1/adc_rdb
add wave -noupdate -divider dac
add wave -noupdate -format Literal /bench_system/u1/filter_out
add wave -noupdate -format Logic /bench_system/u1/dac_wrb
add wave -noupdate -divider system_proc
add wave -noupdate -divider {port io (interface)}
add wave -noupdate -format Logic /bench_system/u1/u1/u4/ecr
add wave -noupdate -format Logic /bench_system/u1/u1/u4/adress
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/u4/dat_in_io
add wave -noupdate -format Literal -radix hexadecimal -scale 0.039 /bench_system/u1/u1/u4/in_io
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/u4/dat_out_io
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/u4/out_io
add wave -noupdate -divider {port io (signaux internes)}
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/u4/reg_d
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/u4/reg_q
add wave -noupdate -divider {rom (interface)}
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/u3/address
add wave -noupdate -format Literal -radix binary /bench_system/u1/u1/u3/output
add wave -noupdate -divider {ram (interface)}
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/u2/add
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/u2/data_in
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/u2/data_out
add wave -noupdate -format Logic /bench_system/u1/u1/u2/write
add wave -noupdate -divider {proc (interface)}
add wave -noupdate -format Logic /bench_system/u1/u1/wr
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/d_in
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/data_in
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/sys_add_bus
add wave -noupdate -divider {proc (signaux internes)}
add wave -noupdate -format Literal /bench_system/u1/u1/u1/cur_inst
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/u1/din
add wave -noupdate -format Logic /bench_system/u1/u1/u1/write
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/u1/rd_out
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/u1/rad_out
add wave -noupdate -format Literal /bench_system/u1/u1/u1/p_state
add wave -noupdate -format Literal /bench_system/u1/u1/u1/p_next_state
add wave -noupdate -format Literal /bench_system/u1/u1/u1/alu_code
add wave -noupdate -format Logic /bench_system/u1/u1/u1/incr_pc
add wave -noupdate -format Logic /bench_system/u1/u1/u1/br_pc
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/u1/offset_pc
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/u1/res_alu
add wave -noupdate -format Logic /bench_system/u1/u1/u1/z_bit
add wave -noupdate -format Logic /bench_system/u1/u1/u1/g_bit
add wave -noupdate -format Literal /bench_system/u1/u1/u1/r_ld
add wave -noupdate -format Logic /bench_system/u1/u1/u1/ra_ld
add wave -noupdate -format Logic /bench_system/u1/u1/u1/rg_ld
add wave -noupdate -format Logic /bench_system/u1/u1/u1/ri_ld
add wave -noupdate -format Logic /bench_system/u1/u1/u1/rd_ld
add wave -noupdate -format Logic /bench_system/u1/u1/u1/rad_ld
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/u1/r_q
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/u1/r_d
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/u1/ra_q
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/u1/ra_d
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/u1/rg_q
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/u1/rg_d
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/u1/ri_q
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/u1/ri_d
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/u1/rd_q
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/u1/rd_d
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/u1/rad_q
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/u1/rad_d
add wave -noupdate -format Logic /bench_system/u1/u1/u1/rw_q
add wave -noupdate -format Logic /bench_system/u1/u1/u1/rw_d
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/u1/xreg
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/u1/yreg
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/u1/mux_sel
add wave -noupdate -format Literal /bench_system/u1/u1/u1/i
add wave -noupdate -format Literal /bench_system/u1/u1/u1/rx
add wave -noupdate -format Literal /bench_system/u1/u1/u1/ry
add wave -noupdate -format Literal -radix hexadecimal /bench_system/u1/u1/u1/nanobus
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
configure wave -namecolwidth 370
configure wave -valuecolwidth 161
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
WaveRestoreZoom {0 ns} {1050 us}
