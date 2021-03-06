library ieee;
use ieee.std_logic_1164.all;

entity next_address_Mux is
  	port(	Inp1, Inp2, Inp3, Inp4 : in std_logic_vector(13 downto 0);
        	Sel : in std_logic_vector(1 downto 0);
        	Outp : out std_logic_vector(13 downto 0)
		);
  	end next_address_Mux;
  
  
architecture behav of next_address_Mux is
  begin
    process(Inp1, Inp2, Inp3, Inp4, Sel)
      begin
       if (Sel = "00") then
         Outp <= Inp1;
       elsif (Sel = "10") then
         Outp <= Inp2; -- select from the pc incrementer
	elsif (Sel = "01") then
         Outp <= Inp3; -- select from the pc stack
	elsif (Sel = "11") then
         Outp <= Inp4;
       else
         null;
       end if;
 end process;
end behav;