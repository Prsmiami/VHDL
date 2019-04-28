library ieee;                                               
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;                              

entity incremental_tb is
end incremental_tb;
architecture incremental_arch of incremental_tb is
  signal endsim : boolean := false; 
  signal clk : std_logic := '1';
  signal en : std_logic;
  signal incr_out : std_logic_vector(13 downto 0);
  signal reset : std_logic;
  component incremental
    port (
    clk : in std_logic;
    en : in std_logic;
    incr_out : out std_logic_vector(13 downto 0);
    reset : in std_logic
    );
  end component;
begin
	dut : incremental
    port map (
  -- list connections between master ports and signals
    clk => clk,
    en => en,
    incr_out => incr_out,
    reset => reset
    );
    
  process begin
    reset <= '1';
    en <= '0';
    wait for 20 ns;
    for i in natural range 0 to 30 loop
      reset <= '0';
      en <= '0';
      wait for 40 ns;
      en <= '1';
      wait for 20 ns * i;
      reset <= '1';
      wait for 20 ns;
    end loop;
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
end incremental_arch;
