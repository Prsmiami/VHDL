library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


Entity ALUKernel is
  Port(X,Y : in std_logic_vector(15 downto 0);
    CI : in std_logic;
    AMF : in std_logic_vector(4 downto 0);
    CLK: in std_logic;
    R: out std_logic_vector(15 downto 0);
    AZ, AN, AC, AV, AS: out std_logic);
  end ALUkernel;
  
Architecture arch of ALUKernel is
  signal tempout: std_logic_vector(15 downto 0);
begin
  P1: process(X,Y,AMF,CI,CLK)
 begin
  if(CLK'event and CLK = '1') then
    if(AMF = "10000") then tempout <= Y;
    elsif(AMF = "10001") then R <= Y+'1';
    elsif(AMF = "10010") then R <= X + Y + CI;
    elsif(AMF = "10011") then R <= X + Y;
    elsif(AMF = "10100") then R <= NOT Y;
    elsif(AMF = "10101") then R <= "-1" * Y;
    elsif(AMF = "10110") then R <= X - Y + CI - '1';
    elsif(AMF = "10111") then R <= X - Y;
    elsif(AMF = "11000") then R <= Y - '1';
    elsif(AMF = "11001") then R <= Y - X;
    elsif(AMF = "11010") then R <= Y - X + CI - '1';
    elsif(AMF = "11011") then R <= NOT X;        
    elsif(AMF = "11100") then R <= X AND Y;
    elsif(AMF = "11101") then R <= X OR Y;
    elsif(AMF = "11110") then R <= X XOR Y;
    elsif(AMF = "11111") then R <= X;
                              R(15)<='0'; 
    end if;
else R <= "ZZZZZZZZZZZZZZZZZ";
end if;
end process P1;

P2: process (X,Y,tempout,CLK,CI)
begin
if(tempout="0000000000000000") then AZ<='1';
end if; 
if(tempout(15)= '1') then AN <='1';
if((X(14) or Y(14)) ='1' AND tempout(14)='0') then AC<='1';
if(X(15)='1' and Y(15)='1' and tempout(15)='0') then AV<='1';
if(X(15)='0' and Y(15)='0' and tempout(15)='1') then AV<='1';
if(X(15)='1') then AS<='1';

end if;
end process P2;
end;

