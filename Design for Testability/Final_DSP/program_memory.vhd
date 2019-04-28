library ieee;
        use ieee.std_logic_1164.all;
        use ieee.std_logic_unsigned.all;
        
entity program_memory is
        port(PMA: IN std_logic_vector(13 downto 0);
             PMD: INOUT std_logic_vector(23 downto 0);
             read: IN std_logic
            );
end program_memory;

architecture behav of program_memory is

      type data is array(0 to 19) of std_logic_vector(23 downto 0);
      
      begin
        process(read, PMA)
          
          variable memory: data;
          variable index: integer;
          
          begin
            memory(1) := "010000000000000000100000";   -- 0. AX0 = 2 
            memory(2) := "010000000000000000110101";   -- 1. AY1 = 3
            memory(3) := "010000000000000001000010";   -- 2. MX0 = 4; 400042
		      memory(4) := "010000000000000000100111";   -- 3. MY1 = 2; 400027
			   memory(5) := "010010110110101000111000";	 -- 4. SI = B6A3 4B6A38
						
				memory(6) := "001010100110100010100000";   -- 4. AR = AX0 + AY1; 2A68A0
            memory(7) := "001010000010100010110000";   -- 5. MR0 = MX0 * MY1 2828B0
            
            memory(8) := "000011110000000011111011";   -- 6. SR = Lshift (-5) 0f00fB
            memory(9) := "000000101000000000000000";   -- Idle
                                  
            
              index:=conv_integer(PMA);
              if (read = '1') then
                PMD<=memory(index);
              end if;
         end process;           
end behav;