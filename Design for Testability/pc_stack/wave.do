onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /pc_stack_tb/reset
add wave -noupdate -radix binary /pc_stack_tb/clk
add wave -noupdate -radix binary /pc_stack_tb/push
add wave -noupdate -radix binary /pc_stack_tb/pop
add wave -noupdate -radix binary /pc_stack_tb/overflow
add wave -noupdate -radix binary /pc_stack_tb/underflow
add wave -noupdate -radix unsigned /pc_stack_tb/data_in
add wave -noupdate -radix unsigned /pc_stack_tb/data_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5720000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 191
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
WaveRestoreZoom {5622175 ps} {6535675 ps}
