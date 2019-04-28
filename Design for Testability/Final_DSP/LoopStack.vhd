library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Loop_Stack is
port(   clk : in std_logic; --CLK for stack
        data_in : in std_logic_vector(17 downto 0);  --Data being pushed.
        data_out : out std_logic_vector(17 downto 0);  --Data being popped.
		push, pop : in std_logic;
		reset : in std_logic;
        overflow : out std_logic;  --Equal to 1 when stack is full.
        underflow : out std_logic  --Equal to 1 when stack is empty.
        );
end Loop_Stack;

architecture Behav of Loop_Stack is

type memory_type is array (3 downto 0) of std_logic_vector(17 downto 0);
signal stack_memory : memory_type := (others => (others => '0'));
signal stack_pointer : integer := 3;
signal full : std_logic := '0';
signal empty : std_logic := '1';

begin

overflow <= full;
underflow <= empty;

process(clk)
begin
	if(rising_edge(clk) and reset = '0') then
		if (push = '1' and full = '0' and pop = '0') then
			stack_memory(stack_pointer) <= data_in;
			empty <= '0';
			if(stack_pointer /= 0) then
				stack_pointer <= stack_pointer - 1;
			end if;
		end if;
		if (pop = '1' and push = '0') then
			if(empty = '1') then
				data_out <= "ZZZZZZZZZZZZZZZZZZ";
			else
				data_out <= stack_memory(stack_pointer + 1);
				stack_pointer <= stack_pointer + 1;
			end if;
		end if;
	end if;
	if (reset = '1') then
		stack_memory(0) <= "ZZZZZZZZZZZZZZZZZZ";
		stack_memory(1) <= "ZZZZZZZZZZZZZZZZZZ";
		stack_memory(2) <= "ZZZZZZZZZZZZZZZZZZ";
		stack_memory(3) <= "ZZZZZZZZZZZZZZZZZZ";
		stack_pointer <= 3;
		full <= '0';
		empty <= '1';
	end if;
	if(stack_pointer = 0) then
		full <= '1';
		empty <= '0';
	elsif(stack_pointer = 3) then
		full <= '0';
		empty <= '1';
	else
		full <= '0';
		empty <= '0';
	end if;
end process;
end Behav;

