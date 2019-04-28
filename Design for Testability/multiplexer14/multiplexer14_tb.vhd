library ieee;                                               
use ieee.std_logic_1164.all;   
use ieee.numeric_std.all;                                    

entity multiplexer14_tb is
end multiplexer14_tb;
architecture multiplexer14_arch of multiplexer14_tb is
  signal inp1 : std_logic_vector(13 downto 0);
  signal inp2 : std_logic_vector(13 downto 0);
  signal outp : std_logic_vector(13 downto 0);
  signal sel : std_logic;
  
  component multiplexer14
    port (
    inp1 : in std_logic_vector(13 downto 0);
    inp2 : in std_logic_vector(13 downto 0);
    outp : out std_logic_vector(13 downto 0);
    sel : in std_logic
    );
  end component;
begin
	dut : multiplexer14
	port map (
    inp1 => inp1,
    inp2 => inp2,
    outp => outp,
    sel => sel
    );
    
  process begin
    inp1 <= std_logic_vector(to_unsigned(1,14));
    inp2 <= std_logic_vector(to_unsigned(2,14));
    sel <= '0';
    wait for 20 ns;
    sel <= '1';
    wait for 20 ns;
    wait;
  end process;
end multiplexer14_arch;
