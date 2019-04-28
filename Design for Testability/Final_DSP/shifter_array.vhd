library ieee;
use ieee.std_logic_1164.all;
 
use ieee.std_logic_unsigned.all;

use ieee.std_logic_arith.all;


	
entity Shifter_Array is
 
	
	port(input : IN std_logic_vector(15 downto 0);
	     
		     x     : IN std_logic;
	    
		     HI_LO : IN std_logic;
	    
		     c     : IN std_logic_vector (7 downto 0);
	     
	     
		     output: OUT std_logic_vector(31 downto 0)	
	);
	
	
end Shifter_Array;
	
	

architecture behav of Shifter_Array is 
	
	
		
begin 
	process(input, x, HI_LO, c)
		
				variable init_pos : integer := 0;		-- init position of the input in shifter array
	
				variable new_pos  : integer := 0;		-- new position of the input after shifting
	
				variable offset	  : integer := 0;		-- the value of the offset
		
				variable shifter  : std_logic_vector(31 downto 0) ;     -- the shifter array
		
				variable temp     : signed(7 downto 0);
			

	begin
		
		--initiate the shifter array firstly
		
	shifter := "00000000000000000000000000000000" ;
		
		-- initiate the start position in the shifter array

		if (HI_LO = '1') then
			
		init_pos := 16;
		
		else
		init_pos := 0;
		
		end if;
	
		temp(7 downto 0) := (signed(c));
		
		offset := conv_integer(temp);
		
				
for i in 0 to 15 loop
	
	new_pos := init_pos + offset + i;         -- test whether the new position is within the range
			
	if ((new_pos>=0) and (new_pos<=31)) then

				shifter(new_pos) := input(i);
			
	end if;
		
end loop;
					
	new_pos := new_pos + 1;
	--	
if ((new_pos>=0) and (new_pos<=31)) then

		
for j in 31 downto 0 loop
	--			
	if (j >= new_pos) then
	
	shifter(j) := x ;
	
		else
		
end if;
	--	
	end loop;
	--
	end if;

		-- output the result
		
		output(31 downto 0) <= shifter(31 downto 0);
			
	
	end process;

		
		

end behav;

