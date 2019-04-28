library ieee;                                               
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;          

entity tristatebuffer14_tb is
end tristatebuffer14_tb;
architecture tristatebuffer14_arch of tristatebuffer14_tb is
  signal data : std_logic_vector(13 downto 0);
  signal en : std_logic;
  signal outp : std_logic_vector(13 downto 0);
  
  component tristatebuffer14
    port (
    data : in std_logic_vector(13 downto 0);
    en : in std_logic;
    outp : out std_logic_vector(13 downto 0)
    );
  end component;
begin
	dut : tristatebuffer14
    port map (
    data => data,
    en => en,
    outp => outp
    );
  
  process begin
    data <= std_logic_vector(to_unsigned(14,14));
    en <= '0';
    wait for 20 ns;
    en <= '1';
    wait for 20 ns;
    wait;
  end process;
end tristatebuffer14_arch;
