library ieee;                                               
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;              

entity loop_counter_tb is
end loop_counter_tb;

architecture loop_counter_arch of loop_counter_tb is
  signal endsim : boolean := false; 
  signal clk : std_logic := '1';
  signal ce : std_logic;
  signal cntr_in : std_logic_vector(13 downto 0);
  signal cntr_out : std_logic_vector(13 downto 0);
  signal load : std_logic;
  
  component loop_counter
    port (
    ce : out std_logic;
    clk : in std_logic;
    cntr_in : in std_logic_vector(13 downto 0);
    cntr_out : out std_logic_vector(13 downto 0);
    load : in std_logic
    );
  end component;
begin
	dut : loop_counter
    port map (
    ce => ce,
    clk => clk,
    cntr_in => cntr_in,
    cntr_out => cntr_out,
    load => load
    );
  
  process begin
    cntr_in <= std_logic_vector(to_unsigned(0,14));
    for i in natural range 1 to 10 loop
      load <= '0';
      wait for 20 ns * (i + 3);
      load <= '1';
      cntr_in <= std_logic_vector(to_unsigned(i,14));
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
end loop_counter_arch;
