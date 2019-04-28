library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity loop_stack_tb  is 
end;
 
architecture loop_stack_tb_arch   of loop_stack_tb   is
  signal endsim : boolean := false;
  signal overflow :  std_logic; 
  signal push :  std_logic; 
  signal data_in :  std_logic_vector (17 downto 0); 
  signal data_out :  std_logic_vector (17 downto 0); 
  signal underflow :  std_logic; 
  signal clk :  std_logic := '1'; 
  signal reset :  std_logic; 
  signal pop :  std_logic; 
  component loop_stack  
    port ( 
      overflow : out std_logic; 
      push : in std_logic; 
      data_in : in std_logic_vector (17 downto 0); 
      data_out : out std_logic_vector (17 downto 0); 
      underflow : out std_logic; 
      clk : in std_logic; 
      reset : in std_logic; 
      pop : in std_logic 
    ); 
  end component; 
begin
  dut : loop_stack  
    port map ( 
      overflow => overflow,
      push => push,
      data_in => data_in ,
      data_out => data_out,
      underflow => underflow,
      clk => clk,
      reset => reset,
      pop => pop
    ); 

  process begin
    push <= '0';
    pop <= '0';
    reset <= '1';
    data_in <= (others => '0');
    wait for 20 ns;
    reset <= '0';
    for i in natural range 0 to 6 loop
      pop <= '0';
      for j in natural range 0 to i loop
        data_in <= std_logic_vector(to_unsigned(i*j,14));
        push <= '1';
        wait for 20 ns;
      end loop;
      push <= '0';
      for j in natural range 0 to i + 1 loop
        pop <= '1';
        wait for 20 ns;
      end loop;
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
end loop_stack_tb_arch;