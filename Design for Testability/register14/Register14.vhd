library ieee;
use ieee.std_logic_1164.all;

Entity Register14 is
  Port(Inp : in std_logic_vector(13 downto 0);
    Load, Clk,reset : in std_logic;
    Outp : out std_logic_vector(13 downto 0));
  end Register14;

Architecture behav of Register14 is
  Signal storage : std_logic_vector(13 downto 0);
begin
  process(Inp, Load, Clk,reset) begin
	  if (reset = '1' ) then --and Clk'event and Clk = '1') then
	  	storage <= "00000000000000";
	  elsif (Clk'event and Clk = '1' and Load = '1') then
	  	storage <= Inp;
	  elsif (Clk'event and Clk = '0') then
	  	Outp <= storage;
	  end if;
	  Outp <= storage;
  end process;
end behav;


