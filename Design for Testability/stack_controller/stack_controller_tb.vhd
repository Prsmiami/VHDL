library ieee;                                               
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;                              

entity stack_controller_tb is
end stack_controller_tb;
architecture stack_controller_arch of stack_controller_tb is
  signal endsim : boolean := false;
  signal clk : std_logic := '1';
  signal add_sel : std_logic_vector(1 downto 0);
  signal ce : std_logic;
  signal cond : std_logic;
  signal overflow : std_logic_vector(2 downto 0);
  signal pmd : std_logic_vector(23 downto 0);
  signal pop : std_logic_vector(2 downto 0);
  signal push : std_logic_vector(2 downto 0);
  signal reset : std_logic;
  signal rs : std_logic_vector(2 downto 0);
  signal underflow : std_logic_vector(2 downto 0);
  
  component stack_controller
    port (
    add_sel : in std_logic_vector(1 downto 0);
    ce : in std_logic;
    clk : in std_logic;
    cond : in std_logic;
    overflow : in std_logic_vector(2 downto 0);
    pmd : in std_logic_vector(23 downto 0);
    pop : out std_logic_vector(2 downto 0);
    push : out std_logic_vector(2 downto 0);
    reset : in std_logic;
    rs : out std_logic_vector(2 downto 0);
    underflow : in std_logic_vector(2 downto 0)
    );
  end component;
begin
	dut : stack_controller
    port map (
    add_sel => add_sel,
    ce => ce,
    clk => clk,
    cond => cond,
    overflow => overflow,
    pmd => pmd,
    pop => pop,
    push => push,
    reset => reset,
    rs => rs,
    underflow => underflow
    );
    
  process begin
    reset <= '1';
    pmd <= (others => '0');
    ce <= '0';
    cond <= '0';
    add_sel <= "00";
    overflow <= "000";
    underflow <= "000";
    wait for 20 ns;
    reset <= '0';
    wait for 20 ns;
    
    pmd(23 downto 18) <= "000101";
    overflow(2 downto 1) <= "00";
    wait for 20 ns;
    overflow(2 downto 1) <= "11";
    wait for 20 ns;
    
    pmd(3 downto 0) <= "1110";
    overflow(0) <= '0';
    wait for 20 ns;
    overflow(0) <= '1';
    wait for 20 ns;
    
    pmd(23 downto 18) <= "000111";
    cond <= '0';
    wait for 20 ns;
    cond <= '1';
    wait for 20 ns;
    
    pmd(23 downto 8) <= "0000101100000000";
    pmd(5 downto 4) <= "01";
    cond <= '0';
    wait for 20 ns;
    cond <= '1';
    wait for 20 ns;
    
    pmd(23 downto 16) <= "00000011";
    pmd(0) <= '0';
    wait for 20 ns;
    pmd(0) <= '1';
    wait for 20 ns;
    
    pmd(23 downto 4) <= "00001010000000000000";
    cond <= '0';
    wait for 20 ns;
    cond <= '1';
    wait for 20 ns;
    
    add_sel <= "10";
    cond <= '0';
    wait for 20 ns;
    cond <= '1';
    wait for 20 ns;
    
    ce <= '0';
    wait for 20 ns;
    ce <= '1';
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
end stack_controller_arch;
