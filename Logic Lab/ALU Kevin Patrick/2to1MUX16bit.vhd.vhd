
library ieee;
  use ieee.std_logic_1164.all;
  
  entity MUX21_16bit is 
    port(MUX21in0, MUX21in1: IN std_logic_vector(15 downto 0);
      MUX21Sel: IN std_logic;
      MUX21Out: OUT std_logic_vector(15 downto 0));
      
    end MUX21_16bit;
    
    architecture behavior of MUX21_16bit is 
    begin
      process(MUX21in0, MUX21in1, MUX21Sel)
        begin
          if(MUX21Sel='0') then MUX21Out<=MUX21in0;
          elsif(MUX21Sel='1') then MUX21Out <=MUX21in1;
          end if;
        end process;
      end behavior;
