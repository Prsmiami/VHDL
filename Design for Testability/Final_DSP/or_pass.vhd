library ieee;
use ieee.std_logic_1164.all;

entity OR_PASS is 

	port(SR, input : IN std_logic_vector(31 downto 0);	-- SR registers and the input from the Shifter Array
	     pass      : IN std_logic;				-- the control bit for or/pass
	     output    : OUT std_logic_vector(31 downto 0)
	);
end OR_PASS;


architecture behav of OR_PASS is 
	
begin
	process(SR, input, pass)
		variable result : std_logic_vector(31 downto 0) := "00000000000000000000000000000000" ;
		
		
	begin
		-- if the pass is 0, the SR and input is ORed and then output
		if (pass = '0') then
			for i in 31 downto 0 loop
				result(i) := SR(i) OR input(i) ;
			end loop;
			
			-- output the result
			output(31 downto 0) <= result(31 downto 0);			
		
		-- output the input from the Shifter Array directly
		else
			output(31 downto 0) <= input(31 downto 0);
			
		end if;
		
	end process;

end behav;
			