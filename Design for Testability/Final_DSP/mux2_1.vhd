library ieee;
    use ieee.std_logic_1164.all;
    
    entity MUX2_1 is
        port( in0,in1: IN std_logic_vector(15 downto 0);
              s: IN std_logic;
              output: OUT std_logic_vector(15 downto 0));
              
          end MUX2_1;
          
          architecture behav of MUX2_1 is 
          begin
              process(in0,in1,s)
                  begin
                      if(s='0') then
                      output<=in0;
                      elsif(s='1') then
                      output<=in1;

                      end if;
                  end process;
              end behav; 

