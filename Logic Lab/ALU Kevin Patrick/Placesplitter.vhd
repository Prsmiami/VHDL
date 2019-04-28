
library ieee;
use ieee.std_logic_1164.all;
entity placesplitter is
Port(
Input: in std_logic_vector(15 downto 0); --input
Out1 : out std_logic_vector(3 downto 0); 
Out2 : out std_logic_vector(3 downto 0); 
Out3 : out std_logic_vector(3 downto 0); 
Out4 : out std_logic_vector(3 downto 0));
end entity placesplitter;

Architecture behav of placesplitter is
begin
	Out1 <= input(15 downto 12);
	Out2 <= input(11 downto 8);
	Out3 <= input(7 downto 4);
	Out4 <= input(3 downto 0);
end behav;