library ieee;
use ieee.std_logic_1164.all;
 
entity program_counter is
port(clk,rs: IN std_logic;          
	input: IN std_logic_vector(13 downto 0);
  output: OUT std_logic_vector(13 downto 0));

end program_counter;


architecture behav of program_counter is
		signal storage: std_logic_vector(13 downto 0)  ;
 begin
      process(clk,rs)
  begin
         
	if rs='1' then
             --
	storage <= (others=>'0');
             
	output<=(others=>'0');
          
	elsif(clk='0' and clk' event) then
           
 	OUTPUT <= input;
          
	elsif (clk='1' and clk' event) then
--           
 	output <= storage;
          
	end if;
        
  end process;
   
end behav;
	