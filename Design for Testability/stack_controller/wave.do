onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /stack_controller_tb/reset
add wave -noupdate -radix unsigned /stack_controller_tb/clk
add wave -noupdate -radix unsigned /stack_controller_tb/pmd
add wave -noupdate -radix unsigned /stack_controller_tb/cond
add wave -noupdate -radix unsigned /stack_controller_tb/add_sel
add wave -noupdate -radix unsigned /stack_controller_tb/ce
add wave -noupdate -radix unsigned /stack_controller_tb/overflow
add wave -noupdate -radix unsigned /stack_controller_tb/underflow
add wave -noupdate -radix unsigned /stack_controller_tb/rs
add wave -noupdate -radix unsigned /stack_controller_tb/push
add wave -noupdate -radix unsigned /stack_controller_tb/pop
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {369326 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 221
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
WaveRestoreZoom {0 ps} {388500 ps}
