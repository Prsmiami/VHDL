library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

Entity ALU is
  Port( CLK: in std_logic;
	Load: in std_logic_vector(5 downto 0);
	Sel: in std_logic_vector(7 downto 0);
	DMD, R: inout std_logic_vector(15 downto 0);
				
        PMD: in std_logic_vector(23 downto 0);
        AMF: in std_logic_vector(4 downto 0);
	CI: in std_logic;
  	En: in std_logic_vector(3 downto 0);
   	AZ, AN, AC, AV, AS: out std_logic;
	alu_out: inout std_logic_vector(15 downto 0)
);
end ALU;

Architecture arch of ALU is
  Component TriState4Bit is
    Port(TriIn : in std_logic_vector(15 downto 0);
      TriEnable : in std_logic;
      TriOut : out std_logic_vector(15 downto 0));
  end Component TriState4Bit;
  Component Register16Bit is
    Port(RegIn : in std_logic_vector(15 downto 0);
      RegLoad, RegClk : in std_logic;
      RegOut : out std_logic_vector(15 downto 0)); 
  end Component Register16Bit;
  Component MUX21_16bit is
    port(MUX21In0, MUX21In1 : in std_logic_vector(15 downto 0);
      MUX21Sel : in std_logic;
      MUX21Outp : out std_logic_vector(15 downto 0));    
  end Component MUX21_16bit;
  Component ALUKernel is
    Port(X,Y : in std_logic_vector(15 downto 0);
      CI : in std_logic;
      AMF : in std_logic_vector(4 downto 0);
      CLK: in std_logic;
      R: out std_logic_vector(15 downto 0);
      AZ, AN, AC, AV, AS: out std_logic);
  end Component ALUKernel;
  
  Signal S1: std_logic_vector (15 downto 0);
  Signal S2: std_logic_vector (15 downto 0);
  Signal S3: std_logic_vector (15 downto 0);
  Signal S4: std_logic_vector (15 downto 0);
  Signal S5: std_logic_vector (15 downto 0);
  Signal S6: std_logic_vector (15 downto 0);
  Signal S7: std_logic_vector (15 downto 0);
  Signal S8: std_logic_vector (15 downto 0);
  Signal S9: std_logic_vector (15 downto 0);
  Signal S10: std_logic_vector (15 downto 0);
  Signal S11: std_logic_vector (15 downto 0);
  Signal S12: std_logic_vector (15 downto 0);
  Signal S13: std_logic_vector (15 downto 0);
  Signal S14: std_logic_vector (15 downto 0);
  
  
begin
  AX0: Register16Bit port map (DMD, Load(0), CLK, S1);
  AX1: Register16Bit port map (DMD, Load (1), CLK, S2);
  MX0: MUX21_16bit port map (DMD, PMD (15 downto 0), Sel (0), S5);   
  AY0: Register16Bit port map (S5, Load(2), CLK,S6);
  AY1: Register16Bit port map (S5, Load(3), CLK, S7);
  MX1: MUX21_16bit port map (S1, S2, Sel(1), S3);  
  MX2: MUX21_16bit port map (R, S3, Sel(2), S4);
  MX3: MUX21_16bit port map (S6,S7,Sel(3), S8);
  MX4: MUX21_16bit port map (S8,S9, Sel(4), S10);
  TSBE0: TriState4Bit port map (S3, En(0), DMD);
  TSBE1: TriState4Bit port map (S8, En(1), DMD);
  TSBE2: TriState4Bit port map (S14, En(2), DMD);
  TSBE3: TriState4Bit port map (S14, En(3), R);    
  AF: Register16Bit port map(S11, Load(4), CLK, S9);
  AR: Register16Bit port map (S13, Load(5), CLK, S14);
  MX5: MUX21_16bit port map (S12, DMD, Sel(5), S13);
  
  ALUK: ALUKernel port map (S4, S10, CI, AMF, CLK, S12, AZ,AN, AC, AV, AS);


end;