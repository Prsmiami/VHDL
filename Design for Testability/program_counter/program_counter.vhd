library ieee;
use ieee.std_logic_1164.all;
  

entity program_counter is
       
 port(clk,rs: IN std_logic;
             
	input: IN std_logic_vector(13 downto 0);
  output: OUT std_logic_vector(13 downto 0));

end program_counter;
 
architecture behav of program_counter is
		signal Reg1: std_logic_vector(13 downto 0)  ;
 begin
 process(clk)
  begin     
	if rs='1' then 
		Reg1 <= (others=>'0');             
		output<=(others=>'0'); 
	elsif(rising_edge(clk)) then
		Reg1 <= input;
	elsif (falling_edge(clk)) then        	
		output <= Reg1;  
	end if;   
end process;
   
end behav;
