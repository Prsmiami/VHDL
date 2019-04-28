library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity increment is 
port (   incr_in: IN std_logic_vector(13 downto 0); -- Increment input (from PC counter)         
         incr_out: OUT std_logic_vector(13 downto 0) -- Increment ouput (to next address mux)
        );
end increment;

architecture behav of increment is
begin  
process(incr_in)    
begin     
incr_out <= incr_in+1; -- 
  end process;
end behav;
   