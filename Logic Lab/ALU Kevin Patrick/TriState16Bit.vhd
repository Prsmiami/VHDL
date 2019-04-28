Library ieee;
use ieee.std_logic_1164.all;

entity TriState4Bit is
  port (TriIn : in std_logic_vector (15 downto 0);
    TriEnable : in std_logic;
    TriOut : out std_logic_vector(15 downto 0));
  end TriState4Bit;
  
  architecture behav of TriState4Bit is
    begin
      process (TriIn, TriEnable)
        begin
          if (TriEnable = '1') then TriOut <= TriIn;
          else TriOut<= "ZZZZZZZZZZZZZZZZ";
       end if;
     end process;
   end behav;