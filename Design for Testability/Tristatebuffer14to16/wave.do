onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tristatebuffer14to16_tb/enable
add wave -noupdate -radix unsigned /tristatebuffer14to16_tb/input
add wave -noupdate -radix unsigned /tristatebuffer14to16_tb/output
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {19991 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 236
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
WaveRestoreZoom {0 ps} {42 ns}
