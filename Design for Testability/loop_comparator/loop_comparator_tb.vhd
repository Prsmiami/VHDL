library ieee;                                               
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;                            

entity loop_comparator_tb is
end loop_comparator_tb;
architecture loop_comparator_arch of loop_comparator_tb is
  signal endsim : boolean := false; 
  signal clk : std_logic := '1';
  signal islast : std_logic;
  signal last_inst : std_logic_vector(13 downto 0);
  signal next_inst : std_logic_vector(13 downto 0);
  
  component loop_comparator
    port (
    clk : in std_logic;
    islast : out std_logic;
    last_inst : in std_logic_vector(13 downto 0);
    next_inst : in std_logic_vector(13 downto 0)
    );
  end component;
begin
	dut : loop_comparator
    port map (
    clk => clk,
    islast => islast,
    last_inst => last_inst,
    next_inst => next_inst
    );

  process begin
    last_inst <= std_logic_vector(to_unsigned(3,14));
    next_inst <= std_logic_vector(to_unsigned(5,14));
    wait for 20 ns;
    last_inst <= std_logic_vector(to_unsigned(7,14));
    next_inst <= std_logic_vector(to_unsigned(7,14));
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
end loop_comparator_arch;
