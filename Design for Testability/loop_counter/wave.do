onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /loop_counter_tb/clk
add wave -noupdate -radix unsigned /loop_counter_tb/load
add wave -noupdate -radix unsigned /loop_counter_tb/cntr_in
add wave -noupdate -radix unsigned /loop_counter_tb/ce
add wave -noupdate -radix unsigned /loop_counter_tb/cntr_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1191323 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 202
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 200000000
configure wave -griddelta 10
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {2005500 ps}
