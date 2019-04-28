library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity incremental is
port (   
   clk : IN std_logic; -- main clk
   reset,En : IN std_logic;             --reset signal
   incr_out: OUT std_logic_vector(13 downto 0) -- Increment ouput (next address to mux)
    );
end incremental;

architecture behav of incremental is
    
    signal counter : std_logic_vector(2 downto 0);
    signal incr_out_1 : std_logic_vector(13 downto 0);
begin  
process (clk) 
begin 
   if  rising_edge(clk) and En ='1' then
       
      if reset = '1' then
         counter <= "000" ;       
      elsif counter = "010" then
         counter <= "000";
      else
         counter <= counter + 1 ;
      end if ;
   end if;
end process;  


process (clk)
begin
    if(En = '1') then
   if rising_edge(clk) then
       if reset = '1' then
          incr_out_1 <= "00000000000001" ;
       elsif counter = "010" then
          incr_out_1 <= incr_out_1 +1 ;
       else
          incr_out_1 <= incr_out_1 ;
      end if;
   end if ;   
   else null;
   end if;
--incr_out <= incr_out_1 ;
end process ;    

incr_out <= incr_out_1 ;



end behav;
