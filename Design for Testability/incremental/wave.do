onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /incremental_tb/reset
add wave -noupdate -radix unsigned /incremental_tb/en
add wave -noupdate -radix unsigned /incremental_tb/clk
add wave -noupdate -radix unsigned /incremental_tb/incr_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {170000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 175
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
WaveRestoreZoom {0 ps} {913500 ps}
