vsim -sdftyp /bench_system/U1=../pr/simulation/modelsim/system_vhd.sdo -sdfnoerror -t ps -voptargs=+acc lib_nanoproc_bench.cfg_bench_system_pr
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /bench_system/reset
add wave -noupdate -format Logic /bench_system/clock_50
add wave -noupdate -format Literal /bench_system/key
add wave -noupdate -format Literal /bench_system/filter_in
add wave -noupdate -format Literal /bench_system/filter_out
add wave -noupdate -format Logic /bench_system/adc_eocb
add wave -noupdate -format Logic /bench_system/adc_convstb
add wave -noupdate -format Logic /bench_system/adc_rdb
add wave -noupdate -format Logic /bench_system/dac_wrb
add wave -noupdate -format Literal /bench_system/hex0
add wave -noupdate -format Literal /bench_system/hex1
add wave -noupdate -format Literal /bench_system/hex2
add wave -noupdate -format Literal /bench_system/hex3
add wave -noupdate -format Literal /bench_system/int_hex0
add wave -noupdate -format Literal /bench_system/int_hex1
add wave -noupdate -format Literal /bench_system/int_hex2
add wave -noupdate -format Literal /bench_system/int_hex3
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
WaveRestoreZoom {0 ns} {1050 ns}
