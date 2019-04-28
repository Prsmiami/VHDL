library ieee;                                               
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tristatebuffer14to16_tb is
end tristatebuffer14to16_tb;
architecture tristatebuffer14to16_arch of tristatebuffer14to16_tb is
  signal enable : std_logic;
  signal input : std_logic_vector(13 downto 0);
  signal output : std_logic_vector(15 downto 0);
  
  component tristatebuffer14to16
    port (
    enable : in std_logic;
    input : in std_logic_vector(13 downto 0);
    output : out std_logic_vector(15 downto 0)
    );
  end component;
begin
	dut : tristatebuffer14to16
    port map (
    enable => enable,
    input => input,
    output => output
    );
    
  process begin
    input <= std_logic_vector(to_unsigned(23,14));
    enable <= '0';
    wait for 20 ns;
    enable <= '1';
    wait for 20 ns;
    wait;
  end process;
end tristatebuffer14to16_arch;
