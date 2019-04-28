library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my.all;

ENTITY SYNC IS
PORT(
CLK: IN STD_LOGIC;
SHIFTL1, SHIFTR1, SHIFTL2, SHIFTR2: IN STD_LOGIC;
HSYNC: OUT STD_LOGIC;
VSYNC: OUT STD_LOGIC;
R: OUT STD_LOGIC_VECTOR(7 downto 0);
G: OUT STD_LOGIC_VECTOR(7 downto 0);
B: OUT STD_LOGIC_VECTOR(7 downto 0)
);
END SYNC;


ARCHITECTURE MAIN OF SYNC IS
SIGNAL RGB: STD_LOGIC_VECTOR(3 downto 0);
SIGNAL DRAW1: STD_LOGIC;
SIGNAL DRAW2: STD_LOGIC;
SIGNAL square1_x_axis,square1_y_axis: INTEGER RANGE 0 TO 1688:=0;
SIGNAL square2_x_axis,square2_y_axis: INTEGER RANGE 0 TO 1688:=0;
SIGNAL HPOS: INTEGER RANGE 0 TO 1688:=0;
SIGNAL VPOS: INTEGER RANGE 0 TO 1066:=0;
SIGNAL OFFSET1, OFFSET2: INTEGER RANGE 0 TO 1280:=0;

BEGIN
square(HPOS,VPOS,square1_x_axis,square1_y_axis,RGB,DRAW1);
square(HPOS,VPOS,square2_x_axis,square2_y_axis,RGB,DRAW2);
 PROCESS(CLK)
 BEGIN
IF(CLK'EVENT AND CLK='1')THEN
	R<=(others=>'1');
	G<=(others=>'1');
	B<=(others=>'0');
	
	--Frame control code
	if(HPOS<1688) then HPOS <= HPOS + 1;
	else HPOS <= 0;
		if(VPOS<1066) then VPOS <= VPOS + 1;
		else VPOS <= 0;
		if(SHIFTR1 = '1') then 
		if(OFFSET1 = 1280) then OFFSET1 <= 0;
		else OFFSET1 <= OFFSET1 + 1;
		end if;
	end if;
	if(SHIFTL1 = '1') then 
		if(OFFSET1 = 0) then OFFSET1 <= 1280;
		else OFFSET1 <= OFFSET1 - 1;
		end if;
	end if;
	if(SHIFTR2 = '1') then 
		if(OFFSET2 = 1280) then OFFSET2 <= 0;
		else OFFSET2 <= OFFSET2 + 1;
		end if;
	end if;
	if(SHIFTL2 = '1') then 
		if(OFFSET2 = 0) then OFFSET2 <= 1280;
		else OFFSET2 <= OFFSET2 - 1;
		end if;
	end if;
	square1_x_axis <= 408+OFFSET1;
	square1_y_axis <= 500;
	square2_x_axis <= 408+OFFSET2;
	square2_y_axis	<= 700;
		end if;
	end if;
	
	--Porch control code
	if(HPOS<408) or (VPOS<42) then 
		R <= "00000000";
		G <= "00000000";
		B <= "00000000";
	end if;
			
	--Synch control code
	if(HPOS>48) then
		if(HPOS<160) then HSYNC <= '0';
		else HSYNC <= '1';
		end if;
	else HSYNC <= '1';
	end if;

	if(VPOS>0) then
		if(VPOS<4) then VSYNC <= '1';
		else VSYNC <= '0';
		end if;
	else VSYNC <= '1';
	end if;	
	
	--Square signal control

	
	if(DRAW1 = '1') or (DRAW2 = '1') then 
		R <= "11111111";
		G <= "00000000";
		B <= "00000000";
	end if;
	

 END IF;
 END PROCESS;
 END MAIN;