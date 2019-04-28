library ieee;
    use ieee.std_logic_1164.all;
    
    entity inreg16 is
        port(clk, load: IN std_logic;
             input: IN std_logic_vector(15 downto 0);
             output: OUT std_logic_vector(15 downto 0));
             
         end inreg16;
         
         architecture behav of inreg16 is
             signal storage: std_logic_vector(15 downto 0);

             begin
                 process(clk,input, load)					 
   					                         
                    begin

                         if(clk='1') then
                            if(load='1') then
                            output<=input;
                            end if;
                    
					          end if; 
					      
                 end process;
               end behav;
                 
