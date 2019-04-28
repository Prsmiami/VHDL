
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

Entity ALUkernel is
  Port(X,Y : in std_logic_vector(15 downto 0);
    CI : in std_logic;
    AMF : in std_logic_vector(4 downto 0);
    CLK: in std_logic;
    R: out std_logic_vector(15 downto 0);
    AZ, AN, AC, AV, AS: out std_logic);
  end ALUkernel;
  
Architecture arch of ALUkernel is
begin
  process(X,Y,AMF,CI,CLK)
  ----process(CLK)
  variable Rs,Xs,Ys: std_logic_vector(16 downto 0);
  begin
  if CLK = '0' then  
    AZ <= '0';
    AN <= '0';
    AC <= '0';
    AV <= '0';
    AS <= X(15);
    Xs(16) := '0';
    Xs(15 downto 0) := X;
    Ys(16) := '0';
    Ys(15 downto 0) := Y;
    case AMF is
        
    when "10011" => 
      Rs := Xs + Ys;
      AC <= Rs(16);
      AV <= ((NOT Xs(15)) AND (NOT Ys(15)) AND Rs(15)) OR
            (Xs(15) AND Ys(15) AND (NOT Rs(15)));
    when "10111" =>
      Rs := Xs - Ys;
      AV <= ((NOT Xs(15)) AND Ys(15) AND Rs(15)) OR
            (Xs(15) AND (NOT Ys(15)) AND (NOT Rs(15)));
    when "11101" =>
      Rs := Xs OR Ys;
    when "11001" =>
      Rs := Ys - Xs;
      AV <= (Xs(15) AND (NOT Ys(15)) AND Rs(15)) OR
            ((NOT Xs(15)) AND Ys(15) AND (NOT Rs(15)));
--    when "01101" =>
--     Rs := Xs;
--    when "01110" =>
--      Rs := Xs XOR Ys;
--    when "01111" =>
--      Rs := Ys - Xs + CI - "1";
--    when "10000" =>
--      Rs := Ys;
    when "11011" =>
      Rs := NOT Xs;
    when "10100" =>
      Rs := NOT Ys;
    when others =>
      Rs := "00000000000000000";
    end case;
    R <= Rs(15 downto 0);
    if Rs(15 downto 0) = "0000000000000000" then
      AZ <= '1';
    end if;
    AN <= Rs(15);
  end if;
  end process;
end;

