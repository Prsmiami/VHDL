onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /loop_stack/clk
add wave -noupdate /loop_stack/data_in
add wave -noupdate /loop_stack/data_out
add wave -noupdate /loop_stack/push
add wave -noupdate /loop_stack/pop
add wave -noupdate /loop_stack/reset
add wave -noupdate /loop_stack/overflow
add wave -noupdate /loop_stack/underflow
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {470534 ps} 0}
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
configure wave -timelineunits sec
update
WaveRestoreZoom {181455 ps} {544365 ps}
view wave 
wave clipboard store
wave create -pattern none -portmode in -language vhdl /loop_stack/clk 
wave create -pattern none -portmode in -language vhdl -range 17 0 /loop_stack/data_in 
wave create -pattern none -portmode out -language vhdl -range 17 0 /loop_stack/data_out 
wave create -pattern none -portmode in -language vhdl /loop_stack/push 
wave create -pattern none -portmode in -language vhdl /loop_stack/pop 
wave create -pattern none -portmode in -language vhdl /loop_stack/reset 
wave create -pattern none -portmode out -language vhdl /loop_stack/overflow 
wave create -pattern none -portmode out -language vhdl /loop_stack/underflow 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 20ns -dutycycle 50 -starttime 0ns -endtime 10000ns Edit:/loop_stack/clk 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 30ns -dutycycle 50 -starttime 0ns -endtime 10000ns Edit:/loop_stack/push 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 40ns -dutycycle 50 -starttime 0ns -endtime 10000ns Edit:/loop_stack/push 
wave modify -driver freeze -pattern clock -initialvalue 1 -period 40ns -dutycycle 50 -starttime 40ns -endtime 10000ns Edit:/loop_stack/pop 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 20ns -dutycycle 50 -starttime 40ns -endtime 10000ns Edit:/loop_stack/pop 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 20ns -dutycycle 50 -starttime 40ns -endtime 10000ns Edit:/loop_stack/pop 
wave modify -driver freeze -pattern clock -initialvalue 1 -period 40ns -dutycycle 50 -starttime 40ns -endtime 10000ns Edit:/loop_stack/pop 
wave modify -driver freeze -pattern constant -value 0 -starttime 0ns -endtime 40ns Edit:/loop_stack/pop 
wave modify -driver freeze -pattern constant -value 0 -starttime 0ns -endtime 40ns Edit:/loop_stack/push 
wave modify -driver freeze -pattern constant -value 1 -starttime 0ns -endtime 40ns Edit:/loop_stack/reset 
wave modify -driver freeze -pattern constant -value 0 -starttime 40ns -endtime 10000ns Edit:/loop_stack/reset 
wave modify -driver freeze -pattern clock -initialvalue 1 -period 40ns -dutycycle 50 -starttime 40ns -endtime 10000ns Edit:/loop_stack/push 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 40ns -dutycycle 50 -starttime 40ns -endtime 10000ns Edit:/loop_stack/pop 
{wave export -file C:/Users/Skodra/Documents/Radovi/VDHL/Final_DSP/simulation/modelsim/Loop_Stack_TB.v -starttime 0 -endtime 10000 -format vlog -designunit loop_stack} 
WaveCollapseAll -1
wave clipboard restore
