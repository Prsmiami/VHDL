-- pll.vhd

-- Generated using ACDS version 16.1 196

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pll is
	port (
		clk_clk         : in  std_logic := '0'; --     clk.clk
		clk_in_clk      : in  std_logic := '0'; --  clk_in.clk
		clk_out_clk     : out std_logic;        -- clk_out.clk
		reset_reset     : in  std_logic := '0'; --   reset.reset
		reset_1_reset_n : in  std_logic := '0'  -- reset_1.reset_n
	);
end entity pll;

architecture rtl of pll is
	component pll_pll_0 is
		port (
			refclk   : in  std_logic := 'X'; -- clk
			rst      : in  std_logic := 'X'; -- reset
			outclk_0 : out std_logic;        -- clk
			locked   : out std_logic         -- export
		);
	end component pll_pll_0;

begin

	pll_0 : component pll_pll_0
		port map (
			refclk   => clk_in_clk,  --  refclk.clk
			rst      => reset_reset, --   reset.reset
			outclk_0 => clk_out_clk, -- outclk0.clk
			locked   => open         --  locked.export
		);

end architecture rtl; -- of pll