library ieee;                                               
use ieee.std_logic_1164.all;         
use ieee.numeric_std.all;                            

entity next_address_selector_tb is
end next_address_selector_tb;

architecture next_address_selector_arch of next_address_selector_tb is
  signal endsim : boolean := false;
  signal add_sel : std_logic_vector(1 downto 0);
  signal cond : std_logic;
  signal inst : std_logic_vector(23 downto 0);
  signal lastinst : std_logic := '0';
  signal rs : std_logic;
  component next_address_selector
    port (
    add_sel : out std_logic_vector(1 downto 0);
    cond : in std_logic;
    inst : in std_logic_vector(23 downto 0);
    lastinst : in std_logic;
    rs : in std_logic
    );
  end component;
begin
	dut : next_address_selector
    port map (
    add_sel => add_sel,
    cond => cond,
    inst => inst,
    lastinst => lastinst,
    rs => rs
    );
  
  process begin
    rs <= '0';
    cond <= '0';
    inst <= (others => '0');
    wait for 20 ns;
    inst(23 downto 19) <= "00011";
    for i in natural range 1 to 10 loop
      inst(4 downto 0) <= std_logic_vector(to_unsigned(i,5));
      cond <= '0';
      wait for 20 ns;
      cond <= '1';
      wait for 20 ns;
    end loop;
    inst(23 downto 5) <= "0000101000000000000";
    for i in natural range 1 to 10 loop
      inst(4 downto 0) <= std_logic_vector(to_unsigned(i,5));
      cond <= '0';
      wait for 20 ns;
      cond <= '1';
      wait for 20 ns;
    end loop;
    inst(23 downto 16) <= "00000011";
    for i in natural range 1 to 10 loop
      inst(4 downto 0) <= std_logic_vector(to_unsigned(i,5));
      for j in natural range 0 to 1 loop
        lastinst <= not lastinst;
        cond <= '0';
        wait for 20 ns;
        cond <= '1';
        wait for 20 ns;
      end loop;
    end loop;
    endsim <= true;
    wait;
  end process;  
end next_address_selector_arch;
