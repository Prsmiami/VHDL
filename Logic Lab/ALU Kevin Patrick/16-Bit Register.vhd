library ieee;
use ieee.std_logic_1164.all;  
  Entity Register16Bit is
    Port(RegIn : in std_logic_vector(15 downto 0); 
        RegLoad, RegClk : in std_logic;
        RegOut : out std_logic_vector(15 downto 0)); 
  end Register16Bit;

Architecture behavior of Register16Bit is
  Signal storage : std_logic_vector(15 downto 0);
    begin
      process(RegIn, RegLoad, RegClk)
      begin
        if (RegClk'event and RegClk = '1' and RegLoad = '1') then 
          storage <= RegIn;
        elsif (RegClk'event and RegClk = '0') then
          RegOut <= storage; 
        end if; 
      end process;
    end behavior;