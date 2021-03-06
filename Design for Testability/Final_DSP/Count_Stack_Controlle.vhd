library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Count_Stack_Controller is
port(  clk : in std_logic;
       data_in : in std_logic_vector(13 downto 0);
       CE: in std_logic;
       -- OwtCntr: in std_logic;
       push, pop: out std_logic
       );
end Count_Stack_Controller;

architecture Behav of Count_Stack_Controller is
signal data_old : std_logic_vector(13 downto 0);

begin
    data_old <= "00000000000010";
    
process( clk, data_in, data_old, CE)
    begin
        
        if (data_in > "00000000000000" and data_old > "00000000000001") then
            push <= '1';

        --elsif (OwtCntr <= '1') then
        --    push <= '0';
        
        else
            push <= '0';
        end if;
        
        if (CE <= '1') then
            pop <= '1';
        else
            pop <= '0';
       end if;
        data_old <= data_in;
        
end process;
end behav;
        
    