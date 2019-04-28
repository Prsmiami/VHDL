library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

Entity MAC is
	Port ( DMD, R: inout std_logic_vector( 15 downto 0);
		PMD: in std_logic_vector(23 downto 0);
		Load: in std_logic_vector(7 downto 0);
		Sel: in std_logic_vector(10 downto 0);
		Sel2: in std_logic_vector(1 downto 0);
       En: in std_logic_vector(5 downto 0);
       AMF: in std_logic_vector(4 downto 0);
       CLk: in std_logic;
		MV : out std_logic;
		mac_out : inout std_logic_vector(15 downto 0));
	end MAC;

Architecture struct of MAC is

Component TriStateBuffer16 is
	Port(Data : in std_logic_vector(15 downto 0);
      		En : in std_logic;
      		Outp : out std_logic_vector(15 downto 0));
  	end Component TriStateBuffer16;

Component TriStateBuffer8 is
	Port(Data : in std_logic_vector(7 downto 0);
      		En : in std_logic;
      		Outp1 : out std_logic_vector(15 downto 0));
  	end Component TriStateBuffer8;

Component Register16 is
    	Port(Inp : in std_logic_vector(15 downto 0);
      		Load, Clk : in std_logic;
     		Outp : out std_logic_vector(15 downto 0)); 
  	end Component Register16;

Component Register8 is
    	Port(Inp : in std_logic_vector(7 downto 0);
      		Load, Clk : in std_logic;
     		Outp : out std_logic_vector(7 downto 0)); 
  	end Component Register8;

Component Multiplexer16 is
    	port(Inp1, Inp2 : in std_logic_vector(15 downto 0);
      		Sel : in std_logic;
      		Outp : out std_logic_vector(15 downto 0));    
  	end Component Multiplexer16;

Component Multiplexer8 is
    	port(Inp1, Inp2 : in std_logic_vector(7 downto 0);
      		Sel : in std_logic;
      		Outp : out std_logic_vector(7 downto 0));    
  	end Component Multiplexer8;

Component Multiplexer4to1 is
  	port(Inp1: in std_logic_vector(7 downto 0);
		Inp2, Inp3, Inp4 : in std_logic_vector(15 downto 0);
        	Sel : in std_logic_vector(1 downto 0);
        	Outp : out std_logic_vector(15 downto 0));
  	end Component Multiplexer4to1;

Component Multiplier16bit is
	port(X,Y : in std_logic_vector(15 downto 0);
		P : out std_logic_vector(31 downto 0));
	end Component Multiplier16bit;

Component AddSubtract16 is
   	 port(MR : in std_logic_vector(39 downto 0);
        		P : in std_logic_vector(31 downto 0);
        		AMF : in std_logic_vector(4 downto 0);
        		R2 : out std_logic_vector(7 downto 0);
        		R1,R0 : out std_logic_vector(15 downto 0);
        		MV : out std_logic);
        		
    	end Component AddSubtract16;

signal sx1, sx2, sx3, sx4, sx5: std_logic_vector(15 downto 0);
signal sy1, sy2, sy3, sy4, sy5, sy6: std_logic_vector(15 downto 0);
signal sf2, sf5, sR2: std_logic_vector(7 downto 0);
signal sf1, sf3, sf4, sf6, sf8, sR0, sR1: std_logic_vector(15 downto 0);
signal sP: std_logic_vector(31 downto 0);
signal SR_all : std_logic_vector(39 downto 0);

begin
	Mx0: Register16 port map(DMD, Load(0), CLK, sx1);
	Mx1: register16 port map(DMD, Load(1), CLK, sx2);
	Mxmux0: Multiplexer16 port map(sx1,sx2,Sel(0),sx3);
	Mxmux1: Multiplexer16 port map(sx1,sx2,Sel(1),sx4);
	Mulxmux: Multiplexer16 port map(sx4,R,Sel(3),sx5);
	T0: TriStateBuffer16 port map(sx3,En(0),DMD);

	Mymuxin: Multiplexer16 port map(PMD(23 downto 8),DMD,Sel(2),sy1);
	My0: Register16 port map(sy1,Load(2),CLK,sy2);
	My1: Register16 port map(sy1,Load(3),CLK,sy3);
	Mymux0: Multiplexer16 port map(sy2,sy3,Sel(4),sy4);
	Mymux1: Multiplexer16 port map(sy2,sy3,Sel(5),sy5);
	Mulymux: Multiplexer16 port map(sy5,sf1,Sel(6),sy6);
	T1: TriStateBuffer16 port map(sy4,En(1),DMD);

	Multiplier: Multiplier16bit port map(sx5, sy6, sP);
	AddSubtract: AddSubtract16 port map(SR_all, sP, AMF, sR2, sR1, sR0, MV); 
	MFregister: Register16 port map(sR1,Load(4),CLK,sf1);
	
	Rmux2: Multiplexer8 port map(sR2,DMD(7 downto 0),Sel(7),sf2);
	Rmux1: Multiplexer16 port map(sR1,DMD,Sel(8),sf3);
	Rmux0: Multiplexer16 port map(sR0,DMD,Sel(9),sf4);
	
	MRregister2: Register8 port map(sf2,Load(5),CLK,sf5);
	MRregister1: Register16 port map(sf3,Load(6),CLK,sf6);
	MRregister0: Register16 port map(sf4,Load(7),CLK,mac_out);
	
	MRmux: Multiplexer4to1 port map(sf5, sf6, mac_out, mac_out, Sel2, sf8);
	T2: TriStateBuffer16 port map(sf8,En(2),DMD);
	T3: TriStateBuffer8 port map(sf5,En(3),R);
	T4: TriStateBuffer16 port map(sf6,En(4),R);
	T5: TriStateBuffer16 port map(mac_out,En(5),R);

	SR_all <= sR2 & sR1 & sR0;

end struct;
