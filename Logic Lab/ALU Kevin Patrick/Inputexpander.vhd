
library ieee;
use ieee.std_logic_1164.all;
entity Inputexpander4to24 is
Port(
Inp : in std_logic_vector(3 downto 0);
Outp: out std_logic_vector(23 downto 0));
end entity Inputexpander4to24;

Architecture behav of Inputexpander4to24 is
begin
Inputexpander4to24: process(Inp)
begin
outp <= "000000000000" & Inp & "00000000";
end process;
end;