library ieee;                                               
use ieee.std_logic_1164.all;                          use ieee.numeric_std.all;      

entity register14_tb is
end register14_tb;

architecture register14_arch of register14_tb is
  signal endsim : boolean := false;
  signal clk : std_logic := '1';
  signal inp : std_logic_vector(13 downto 0);
  signal load : std_logic;
  signal outp : std_logic_vector(13 downto 0);
  signal reset : std_logic;
  
  component register14
    port (
    clk : in std_logic;
    inp : in std_logic_vector(13 downto 0);
    load : in std_logic;
    outp : out std_logic_vector(13 downto 0);
    reset : in std_logic
    );
  end component;
begin
	dut : register14
    port map (
    clk => clk,
    inp => inp,
    load => load,
    outp => outp,
    reset => reset);
  
  process begin
    reset <= '1';
    load <= '0';
    inp <= std_logic_vector(to_unsigned(20,14));
    wait for 20 ns;
    reset <= '0';
    load <= '1';
    wait for 20 ns;
    endsim <= true;
    wait;
  end process;
  
  process begin
    if endsim = false then
      clk <= not clk;
      wait for 10 ns;
    else
      wait;
    end if;
  end process;
end register14_arch;
