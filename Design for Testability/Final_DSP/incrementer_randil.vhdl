library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;




entity increment is
port (   
   clk : IN std_logic; -- main clk
   reset : IN std_logic;             --reset signal
   incr_out: OUT std_logic_vector(13 downto 0) -- Increment ouput (next address to mux)
    );
end increment;

architecture behav of increment is
    
    signal counter : std_logic_vector(2 downto 0);
    signal incr_out_1 : std_logic_vector(13 downto 0);
begin  
process (clk) 
begin 
   if rising_edge(clk) then
       
      if reset = '1' then
         counter <= "000" ;       
      elsif counter = "101" then
         counter <= "000";
      else
         counter <= counter + 1 ;
      end if ;
   end if;
end process;  


process (clk)
begin
   if rising_edge(clk) then
       if reset = '1' then
          incr_out_1 <= "00000000000000" ;
       elsif counter = "101" then
          incr_out_1 <= incr_out_1 +1 ;
       else
          incr_out_1 <= incr_out_1 ;
      end if;
   end if ;    
end process ;    

incr_out <= incr_out_1 ;



end behav;