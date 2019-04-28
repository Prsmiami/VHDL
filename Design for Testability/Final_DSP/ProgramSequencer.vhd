library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

Entity ProgramSequencer is
	Port ( 	DMD: inout std_logic_vector( 15 downto 0);
					Inst: in std_logic_vector(23 downto 0);
					ASTAT: in std_logic_vector(7 downto 0);
					Sel: in std_logic_vector(1 downto 0);
			    CLK: in std_logic;
			    
					Load: in std_logic_vector(2 downto 0);
					Reset: in std_logic;
					En : in std_logic;   
					TSB_Ctr: in std_logic_vector(2 downto 0);
					PMA: inout std_logic_vector(13 downto 0);
					PMD: in std_logic_vector(23 downto 0);
					CC: in std_logic_vector(3 downto 0);
					AddJump: in std_logic_vector(13 downto 0);
					AddTC: in std_logic_vector(17 downto 0);
					IRAddress: in std_logic_vector(13 downto 0)
		);
	end ProgramSequencer;

Architecture struct of ProgramSequencer is

Component Loop_Stack is
	port(   clk : in std_logic; --CLK for stack
        	data_in : in std_logic_vector(17 downto 0);  --Data being pushed.
        	data_out : out std_logic_vector(17 downto 0);  --Data being popped.
					push, pop : in std_logic;
					reset : in std_logic;
        	overflow : out std_logic;  --Equal to 1 when stack is full.
        	underflow : out std_logic  --Equal to 1 when stack is empty.
		);
	end Component Loop_Stack;


Component Count_Stack is
	port(   clk : in std_logic; --CLK for stack
        	data_in : in std_logic_vector(13 downto 0);  --Data being pushed.
        	data_out : out std_logic_vector(13 downto 0);  --Data being popped.
					push, pop : in std_logic;
					reset : in std_logic;
        	overflow : out std_logic;  --Equal to 1 when stack is full.
        	underflow : out std_logic  --Equal to 1 when stack is empty.
		);
	end Component Count_Stack;

Component PC_Stack is
	port(   clk : in std_logic; --CLK for stack
        	data_in : in std_logic_vector(13 downto 0);  --Data being pushed.
        	data_out : out std_logic_vector(13 downto 0);  --Data being popped.
					push, pop : in std_logic;
					reset : in std_logic;
        	overflow : out std_logic;  --Equal to 1 when stack is full.
        	underflow : out std_logic  --Equal to 1 when stack is empty.
        	);
	end Component PC_Stack;

Component Condition_Logic is
	port (	cond_code	: IN std_logic_vector(3 downto 0);
					loop_cond	: IN std_logic_vector(3 downto 0);
					CE		: IN std_logic;
					status		: IN std_logic_vector(7 downto 0);
					s       	: IN std_logic;	
					cond		: OUT std_logic
	);
	end Component Condition_Logic;

Component incremental is
	port (  
	clk : IN std_logic; -- main clk
   reset,En : IN std_logic;             --reset signal
   incr_out: OUT std_logic_vector(13 downto 0) -- Increment ouput (next address to mux)
    		);
	end Component incremental;

Component loop_comparator is
	port (  next_inst,last_inst: IN std_logic_vector(13 downto 0); 
		clk: IN std_logic; -- Clock
		isLast: OUT std_logic
		);
	end Component loop_comparator;

Component loop_counter is
	port( 	cntr_in: IN std_logic_vector(13 downto 0); --Data input
					clk,load: IN std_logic; --Clock
					CE: OUT std_logic ; --Counter Expired signal
      		cntr_out: OUT std_logic_vector(13 downto 0) --Data output     
 		);
	end Component loop_counter;

Component next_address_Selector is 
	port (	rs,cond		: IN std_logic ;
					Inst		: IN std_logic_vector(23 downto 0);
					LastInst	: IN std_logic;
					add_sel		: OUT std_logic_vector(1 downto 0)
		);
	end Component next_address_Selector;

Component program_counter is
	port(	clk,rs		: IN std_logic;
         input		: IN std_logic_vector(13 downto 0);
				output		: OUT std_logic_vector(13 downto 0)
		);
	end Component program_counter;

Component Multiplexer14 is
    	port(	Inp1, Inp2 : in std_logic_vector(13 downto 0);
      		Sel : in std_logic;
      		Outp : out std_logic_vector(13 downto 0)
		);    
  	end Component Multiplexer14;

Component next_address_Mux is
  	port(	Inp1, Inp2, Inp3, Inp4 : in std_logic_vector(13 downto 0);
        	Sel : in std_logic_vector(1 downto 0);
        	Outp : out std_logic_vector(13 downto 0)
		);
  	end component next_address_Mux;

Component TriStateBuffer14 is
	Port(	Data : in std_logic_vector(13 downto 0);
      		En : in std_logic;
      		Outp : out std_logic_vector(13 downto 0)
		);
  	end Component TriStateBuffer14;


Component Register14 is
    	Port(	Inp : in std_logic_vector(13 downto 0);
      		Load, Clk,reset : in std_logic;
     		Outp : out std_logic_vector(13 downto 0)
		); 
  	end Component Register14;

component Tristatebuffer14to16 is
		
port( input : in std_logic_vector(13 downto 0);
	
	      enable : in std_logic;
	
	      output : out std_logic_vector(15 downto 0)
		
     ); 
end component;    

Component Stack_Controller is
port( clk,reset: IN std_logic;
       PMD: IN std_logic_vector(23 downto 0);
       CE, cond: IN std_logic;         -- counter expired and loop condition tested 
       add_sel: IN std_logic_vector(1 downto 0); -- next address selector 
       push, pop: OUT std_logic_vector(2 downto 0); -- Push or pop signals for stacks: Count, Status, PC and Loop 
       rs: OUT std_logic_vector(2 downto 0); -- Reset signals for stacks: Count, Status, PC and Loop
       overflow: IN std_logic_vector(2 downto 0);
       underflow: IN std_logic_vector(2 downto 0)
   );
end Component Stack_Controller;
 

signal ps1,ps2, ps3,ps4, ps9, ps10, ps11, ps12,ps13,ps15: std_logic_vector(13 downto 0);
signal ps5: std_logic_vector(17 downto 0);
signal CE, ps6, ps7: std_logic;
signal ps8: std_logic_vector(1 downto 0);
signal push, pop, rs, Over, Under: std_logic_vector(2 downto 0);
signal t_pma : std_logic_vector(13 downto 0) := "00000000000000";

begin
	PSreg0: Register14 port map(DMD (13 downto 0), Load(0), CLK,Reset, ps1);
	PSmux0: Multiplexer14 port map(ps1,ps2,Sel(0),ps3);
	CNTRCounter: loop_counter port map(ps3, CLK, Load(1), CE, ps4);
	
	
	StackControl: Stack_Controller port map(CLK, Reset, PMD, CE, ps7, ps8, push, pop, rs, Over, Under);
	CountStack: Count_Stack port map(CLK, ps4, ps2, push(0), pop(0), rs(0), Over(0), Under(0));
	LoopStack: Loop_Stack port map(CLK, AddTC, ps5, push(1), pop(1), rs(1), Over(1), Under(1));
	PCStack: PC_Stack port map(CLK, ps11, ps12, push(2), pop(2), rs(2), Over(2), Under(2));
	
	
	
	T0: Tristatebuffer14to16 port map(ps4,TSB_Ctr(0),DMD);
	ConditionLogic: Condition_Logic port map(CC, PS5(17 downto 14), CE, ASTAT(7 downto 0), ASTAT(7), ps6);
	LoopComparator: loop_comparator port map(ps5(13 downto 0), ps9, clk, ps7);
	ProgramCounter: program_counter port map(CLK,Reset, ps9, ps10);
	Increment1: incremental port map(CLK,Reset,En,ps11);
	NextADDSS: next_address_Selector port map(Reset, ps6, Inst, ps7, ps8);
	NADDMux: next_address_Mux port map(AddJump, ps11, ps12, IRAddress, ps8, ps13);
	PSreg1: Register14 port map(PMA, Load(2),CLK,Reset, ps15);
	PSmux1: Multiplexer14 port map(ps15,ps13,Sel(1),ps9);
	T1: TriStateBuffer14 port map(ps13,TSB_Ctr(1),PMA);
   --t_pma <= PMA;
end struct;