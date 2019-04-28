library ieee;
use ieee.std_logic_1164.all;

entity loop_comparator is

port (  next_inst,last_inst: IN std_logic_vector(13 downto 0); 
				clk: IN std_logic; -- Clock
				isLast: OUT std_logic);
end loop_comparator;

architecture behav of loop_comparator is
begin
  process(clk)
		begin
			if(clk='1' and clk' event) then -- clk rising edge
			if(next_inst = last_inst) then
			isLast <= '1';

			elsif(next_inst /= last_inst) then
			isLast <= '0';
 			end if;
			end if;
end process;
end behav;


