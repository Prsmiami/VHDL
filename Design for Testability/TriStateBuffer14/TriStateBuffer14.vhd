library ieee;
use ieee.std_logic_1164.all;

Entity TriStateBuffer14 is
  Port(Data : in std_logic_vector(13 downto 0);
       En : in std_logic;
       Outp : out std_logic_vector(13 downto 0));
end  TriStateBuffer14;

Architecture behav of TriStateBuffer14 is
  begin
    process(Data, En)
      begin
      if (En = '1') then
        Outp <= Data;
      else
        Outp <= "ZZZZZZZZZZZZZZ";
      end if;
    end process;
end behav;