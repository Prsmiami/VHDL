library ieee;
use ieee.std_logic_1164.all;

entity Multiplexer4to1 is
  port(Inp1: in std_logic_vector(7 downto 0);
	Inp2, Inp3, Inp4 : in std_logic_vector(15 downto 0);
        Sel : in std_logic_vector(1 downto 0);
        Outp : out std_logic_vector(15 downto 0));
  end Multiplexer4to1;
  
  
architecture behav of Multiplexer4to1 is
  begin
    process(Inp1, Inp2, Inp3, Inp4, Sel)
      begin
       if (Sel = "00") then
         Outp <= "XXXXXXXX" & Inp1;
       elsif (Sel = "01") then
         Outp <= Inp2;
	elsif (Sel = "10") then
         Outp <= Inp3;
	elsif (Sel = "11") then
         Outp <= Inp4;
       else
         null;
       end if;
 end process;
end behav;
