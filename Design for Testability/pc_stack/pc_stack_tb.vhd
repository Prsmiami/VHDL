library ieee;                                               
use ieee.std_logic_1164.all;    
use ieee.numeric_std.all;                            

entity pc_stack_tb is
end pc_stack_tb;

architecture pc_stack_arch of pc_stack_tb is 
  signal endsim : boolean := false; 
  signal clk : std_logic := '1';
  signal data_in : std_logic_vector(13 downto 0);
  signal data_out : std_logic_vector(13 downto 0);
  signal overflow : std_logic;
  signal pop : std_logic;
  signal push : std_logic;
  signal reset : std_logic;
  signal underflow : std_logic;
  
  component pc_stack
    port (
    clk : in std_logic;
    data_in : in std_logic_vector(13 downto 0);
    data_out : out std_logic_vector(13 downto 0);
    overflow : out std_logic;
    pop : in std_logic;
    push : in std_logic;
    reset : in std_logic;
    underflow : out std_logic
    );
  end component;
begin
	dut : pc_stack
	port map (
	clk => clk,
	data_in => data_in,
	data_out => data_out,
	overflow => overflow,
	pop => pop,
	push => push,
	reset => reset,
	underflow => underflow
	);
  
  process begin
    push <= '0';
    pop <= '0';
    reset <= '1';
    data_in <= (others => '0');
    wait for 20 ns;
    reset <= '0';
    for i in natural range 0 to 16 loop
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
end pc_stack_arch;
