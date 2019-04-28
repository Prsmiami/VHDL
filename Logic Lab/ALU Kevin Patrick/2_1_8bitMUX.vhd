library ieee;
	use ieee.std_logic_1164.all;
	
	entity mux2_1_8bit is
		port (in0, in1: in std_logic_vector(7 downto 0);
			S: in std_logic;
			output: out std_logic_vector(7 downto 0));
		end mux2_1_8bit;

	architecture behav of mux2_1_8bit is
	begin
		process(in0,in1,s)
			begin
				if(s='0') then
				output<=in0;
				elsif(s='1') then
				output<=in1;

				end if;
			end process;
		end behav;
