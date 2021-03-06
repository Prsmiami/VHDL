library ieee;                                               
use ieee.std_logic_1164.all;   
use ieee.numeric_std.all;                             

entity program_counter_tb is
end program_counter_tb;

architecture program_counter_arch of program_counter_tb is               
  signal endsim : boolean := false; 
  signal clk : std_logic := '1';
  signal input : std_logic_vector(13 downto 0);
  signal output : std_logic_vector(13 downto 0);
  signal rs : std_logic;
  
  component program_counter
    port (
    clk : in std_logic;
    input : in std_logic_vector(13 downto 0);
    output : out std_logic_vector(13 downto 0);
    rs : in std_logic
    );
  end component;
begin
	dut : program_counter
    port map (
    clk => clk,
    input => input,
    output => output,
    rs => rs
    );
  
  process begin
    rs <= '0';
    input <= (others => '0');
    wait for 20 ns;
    for i in natural range 1 to 10 loop
      input <= std_logic_vector(to_unsigned(i,14));
      wait for 12 ns;
      input <= (others => 'Z');
      wait for 8 ns;
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
end program_counter_arch;
