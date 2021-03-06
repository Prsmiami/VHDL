library ieee;
	use ieee.std_logic_1164.all;
	

entity Shifter is

	port(clk : IN std_logic;     -- the clock
	     pass: IN std_logic;     -- control bit for OR/PASS
	     x_in: IN std_logic;     -- extension bit to be filled in the left part of shifter array
	     HI_LO:IN std_logic;     -- control bit to indicate high/low position in shifter array
	     rl  : IN std_logic_vector(2 downto 0);	-- register loading enable bits
	     s_in: IN std_logic_vector(3 downto 0);	-- selecting bits for mux
	     c_in: IN std_logic_vector(7 downto 0);     -- bits to indicate the offset
	     bc  : IN std_logic_vector(3 downto 0);	-- tristate enable bits
	     
			SR_out :inout std_logic_vector(31 downto 0);
	     DMD : IN std_logic_vector(15 downto 0); -- the DMD bus
	     R	 : INOUT std_logic_vector(15 downto 0)  -- the R bus
	);

end Shifter;


architecture struct of Shifter is
	
	component Shifter_Array is 
		port(input : IN std_logic_vector(15 downto 0);
		     x     : IN std_logic;
		     HI_LO : IN std_logic;
		     c     : IN std_logic_vector(7 downto 0);
			     
		     output: OUT std_logic_vector(31 downto 0)	
		);
	end component;
	
	
	component OR_PASS is 
		port(SR, input : IN std_logic_vector(31 downto 0);	
		     pass      : IN std_logic;				
		     output    : OUT std_logic_vector(31 downto 0)
		);
	end component;
	
	
	component mux2_1 is
	      	port(in0, in1: in std_logic_vector(15 downto 0);
	      	     S: in std_logic;
		     output: out std_logic_vector(15 downto 0));
    	end component;
    	
    	
    	component inreg16 is
		port(clk : in std_logic;
		    load  : in std_logic;
		    input : in std_logic_vector(15 downto 0);
		    output: out std_logic_vector(15 downto 0));
	end component;
		 
		 
	component outreg16 is
		port(clk : in std_logic;
		    load  : in std_logic;
		    input : in std_logic_vector(15 downto 0);
		    output : out std_logic_vector(15 downto 0));
	end component;
		 
		 
	component tristate_buffer16 is
		port(input : in std_logic_vector(15 downto 0);
		     enable : in std_logic;
		     output : out std_logic_vector(15 downto 0));
    	end component;
    	
    	
    	
    	-- define the internal signals for the connection
    	
    	signal mux0_out, mux1_out, mux2_out, mux3_out : std_logic_vector(15 downto 0);
    	signal SR1_out, SR2_out : std_logic_vector(15 downto 0);
   		signal buffer0_out, buffer1_out, buffer2_out, buffer3_out : std_logic_vector(15 downto 0);
    	signal shifter_array_out, or_pass_out : std_logic_vector(31 downto 0);
    	signal SI_out : std_logic_vector(15 downto 0);
    	signal t_DMD : std_logic_vector(15 downto 0);
    	
    	
begin

    	-- connect all these components
    	
    	SI      	  :	inreg16		port map(clk, rl(0), DMD, SI_out);
    	SR1		  :	outreg16	  port map(clk, rl(1), mux1_out, SR1_out);
    	SR2		  : 	outreg16	  port map(clk, rl(2), mux2_out, SR2_out);    	
    	
    	shifter_array_chip:	Shifter_Array 	  port map(mux0_out, x_in, HI_LO, c_in, shifter_array_out);
    	or_pass_chip	  :	OR_PASS		  port map(SR_out, shifter_array_out, pass, or_pass_out);
    	
    	mux0   		  :	mux2_1		port map(SI_out, R, s_in(0), mux0_out);
    	mux1		  :	mux2_1		  port map(or_pass_out(31 downto 16), DMD, s_in(1), mux1_out);
    	mux2		  :	mux2_1		  port map(or_pass_out(15 downto 0), DMD, s_in(2), mux2_out);
    	mux3		  :	mux2_1		  port map(SR1_out, SR2_out, s_in(3), mux3_out);
    	
    	buffer0		  :	tristate_buffer16 port map(SI_out, bc(0), t_DMD);
    	buffer1		  : 	tristate_buffer16 port map(SR1_out, bc(1), R);
    	buffer2		  :	tristate_buffer16 port map(SR2_out, bc(2), R); 
    	buffer3		  :	tristate_buffer16 port map(mux3_out, bc(3), t_DMD);
    	
    	SR_out <= SR1_out & SR2_out ;
    	
 end struct;