library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity next_address_Selector is 
	port (rs,cond		: IN std_logic ;	      -- condition code in the instruction
					Inst		: IN std_logic_vector(23 downto 0);	-- 24 bits instruction
				LastInst	: IN std_logic;				-- loop_end condition from the loop comparator
					add_sel	: OUT std_logic_vector(1 downto 0)
);

end next_address_Selector ;

architecture behav of next_address_Selector is 
begin
		process (rs, Inst, cond, lastInst)		
		variable s	: std_logic_vector(1 downto 0) ;		
			begin
		   if (rs = '1') then
		      	s := "00"; 
			elsif (Inst(23 downto 19) = "00011") then 
					if (cond = '1') then
							s := "11" ; 	-- select the address from the IR
					else
							s := "10" ;	-- select from the pc incrementer
					end if;
						-- if the instruction is a conditional return
			elsif (Inst(23 downto 5) = "0000101000000000000") then
					if (cond = '1') then
								s := "01" ;	-- select from the pc stack
					else
								s := "10" ;	-- select from the pc incrementer						
					end if;
			-- if the instruction is call or jump on Flag In
			
			elsif (Inst(23 downto 16) = "00000011") then
			-- if the instruction is in end of the DO Util loop
			      if (LastInst = '1') then
			            if (cond = '1') then
							   s := "10" ;	-- select from the pc incrementer, end the loop
					      else
							s := "01" ;	-- select from the pc stack, start the loop again						
					      end if;
						-- other 
			  		  
					end if;
 					s := "10" ;		-- select from the pc incrementer
			end if;			-- output the result
					add_sel <= s;
end process;
end behav;