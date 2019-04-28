library ieee;                                               
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  

entity next_address_mux_tb is
end next_address_mux_tb;
architecture next_address_mux_arch of next_address_mux_tb is
  signal inp1 : std_logic_vector(13 downto 0);
  signal inp2 : std_logic_vector(13 downto 0);
  signal inp3 : std_logic_vector(13 downto 0);
  signal inp4 : std_logic_vector(13 downto 0);
  signal outp : std_logic_vector(13 downto 0);
  signal sel : std_logic_vector(1 downto 0);
  component next_address_mux
    port (
    inp1 : in std_logic_vector(13 downto 0);
    inp2 : in std_logic_vector(13 downto 0);
    inp3 : in std_logic_vector(13 downto 0);
    inp4 : in std_logic_vector(13 downto 0);
    outp : out std_logic_vector(13 downto 0);
    sel : in std_logic_vector(1 downto 0)
    );
  end component;
begin
	dut : next_address_mux
    port map (
    inp1 => inp1,
    inp2 => inp2,
    inp3 => inp3,
    inp4 => inp4,
    outp => outp,
    sel => sel
    );
  
  process begin
    inp1 <= std_logic_vector(to_unsigned(1,14));
    inp2 <= std_logic_vector(to_unsigned(2,14));
    inp3 <= std_logic_vector(to_unsigned(3,14));
    inp4 <= std_logic_vector(to_unsigned(4,14));
    for i in natural range 0 to 3 loop
      sel <= std_logic_vector(to_unsigned(i,2));
      wait for 20 ns;
    end loop;
    wait;
  end process;
end next_address_mux_arch;
