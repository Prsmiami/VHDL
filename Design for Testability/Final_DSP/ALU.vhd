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
  Component TriStateBuffer16 is
    Port(Data : in std_logic_vector(15 downto 0);
      En : in std_logic;
      Outp : out std_logic_vector(15 downto 0));
  end Component TriStateBuffer16;
  Component Register16 is
    Port(Inp : in std_logic_vector(15 downto 0);
      Load, Clk : in std_logic;
      Outp : out std_logic_vector(15 downto 0)); 
  end Component Register16;
  Component Multiplexer16 is
    port(Inp1, Inp2 : in std_logic_vector(15 downto 0);
      Sel : in std_logic;
      Outp : out std_logic_vector(15 downto 0));    
  end Component Multiplexer16;
  Component ALUkernel is
    Port(X,Y : in std_logic_vector(15 downto 0);
      CI : in std_logic;
      AMF : in std_logic_vector(4 downto 0);
      CLK: in std_logic;
      R: out std_logic_vector(15 downto 0);
      AZ, AN, AC, AV, AS: out std_logic);
  end Component ALUkernel;
  
  
  signal sx1,sx2,sx3,  sx4, sx5: std_logic_vector(15 downto 0);
  signal sy1, sy2, sy3, sy4, sy5, sy6: std_logic_vector(15 downto 0);
  signal sf1, sf2, sR: std_logic_vector(15 downto 0);
  
  
begin
  Ax0: Register16 port map(DMD,Load(0),CLK,sx1);
  Ax1: Register16 port map(DMD,Load(1),CLK,sx2);
  Axmux0: Multiplexer16 port map(sx1,sx2,Sel(0),sx3);
  Axmux1: Multiplexer16 port map(sx1,sx2,Sel(1),sx4);
  aluxmux: Multiplexer16 port map(sx4,R,Sel(3),sx5);
  T0: TriStateBuffer16 port map(sx3,En(0),DMD);
  
  Aymuxin: Multiplexer16 port map(PMD(23 downto 8),DMD,Sel(2),sy1);
  Ay0: Register16 port map(sy1,Load(2),CLK,sy2);
  Ay1: Register16 port map(sy1,Load(3),CLK,sy3);
  Aymux0: Multiplexer16 port map(sy2,sy3,Sel(4),sy4);
  Aymux1: Multiplexer16 port map(sy2,sy3,Sel(5),sy5);
  aluymux: Multiplexer16 port map(sy4,sf1,Sel(6),sy6);
  T2: TriStateBuffer16 port map(sy5,En(2),DMD);
  
  ALU: ALUkernel port map(sx5,sy6,CI,AMF,CLK,sR,AZ,AN,AC,AV,AS);
  AFregister: Register16 port map(sR,Load(5),CLK,sf1);
  
  Rmux: Multiplexer16 port map(sR,DMD,Sel(7),sf2);
  Rreg: Register16 port map(sf2,Load(4),CLK,alu_out);
  T1: TriStateBuffer16 port map(alu_out,En(1),R);
  T3: TriStateBuffer16 port map(alu_out,En(3),DMD);
end;
