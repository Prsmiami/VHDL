library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;                               

entity condition_logic_tb is
end condition_logic_tb;

architecture condition_logic_arch of condition_logic_tb is  signal
  endsim : boolean := false;                                      
  signal ce : std_logic;
  signal cond : std_logic;
  signal cond_code : std_logic_vector(3 downto 0);
  signal loop_cond : std_logic_vector(3 downto 0);
  signal s : std_logic;
  signal status : std_logic_vector(7 downto 0);
  
  component condition_logic
    port (
    ce : in std_logic;
    cond : out std_logic;
    cond_code : in std_logic_vector(3 downto 0);
    loop_cond : in std_logic_vector(3 downto 0);
    s : in std_logic;
    status : in std_logic_vector(7 downto 0)
    );
  end component;
begin
	dut : condition_logic
    port map (
    ce => ce,
    cond => cond,
    cond_code => cond_code,
    loop_cond => loop_cond,
    s => s,
    status => status
    );

  process begin
    cond_code <= (others => '0');
    loop_cond <= (others => '0');
    ce <= '1';
    status <= "01010101";
    s <= '0';
    wait for 20 ns;
    for i in natural range 0 to 15 loop
      for j in natural range 0 to 1 loop
        cond_code <= std_logic_vector(to_unsigned(i,4));
        status <= status(6 downto 0) & status(7);
        wait for 20 ns;
      end loop;
    end loop;
    s <= '1';
    for i in natural range 0 to 15 loop
      for j in natural range 0 to 1 loop
        loop_cond <= std_logic_vector(to_unsigned(i,4));
        status <= status(6 downto 0) & status(7);
        wait for 20 ns;
      end loop;
    end loop;
    endsim <= true;
    wait;
  end process;  
end condition_logic_arch;
