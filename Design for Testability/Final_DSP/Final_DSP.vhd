
library ieee;
        use ieee.std_logic_1164.all;
        use ieee.std_logic_unsigned.all;
        
entity Final_DSP is
  
  port( clk: IN std_logic;
        rs: IN std_logic;
		 	
		 	alu_out : INOUT std_logic_vector(15 downto 0);
   	    mac_out: INOUT std_logic_vector(15 downto 0);
        SR_out : INOUT std_logic_vector(31 downto 0)
      );

end Final_DSP;


architecture struct of Final_DSP is

  component processing_unit is
     port( clk: IN std_logic;
        rs,En : IN std_logic;
        PMA : INOUT std_logic_vector(13 downto 0); -- the PMA bus
        DMA : INOUT std_logic_vector(13 downto 0); -- the DMA bus
        PMD : IN std_logic_vector(23 downto 0); -- the PMD bus
        DMD,R : INOUT std_logic_vector(15 downto 0);
       
                
        s_program_seq : IN std_logic_vector(1 downto 0); -- selection signal for program_control muxes
        s_alu : IN std_logic_vector(7 downto 0); -- selection signal for alu muxes
        s_mac : IN std_logic_vector(10 downto 0); -- selection signal for mac muxes
				s2_mac : IN std_logic_vector(1 downto 0); -- selection signal for 4into1 mac mux			
        s_shifter: IN std_logic_vector(3 downto 0); -- selection signal for shifter muxes
        
        load_program_seq : IN std_logic_vector(2 downto 0); -- load signal for program control registers
        load_alu : IN std_logic_vector(5 downto 0); -- load signal for alu registers
        load_mac : IN std_logic_vector(7 downto 0); -- load signal for mac registers
        load_shifter : IN std_logic_vector(2 downto 0); -- load signal for shifter registers
        
       
        bc_program_seq : IN std_logic_vector(2 downto 0); -- program_control tristate buffers control signal
        bc_alu : IN std_logic_vector(3 downto 0); -- alu tristate buffers control signal
				bc_mac : IN std_logic_vector(5 downto 0); -- mac tristate buffers control signal
 			 	bc_shifter : IN std_logic_vector(3 downto 0); -- shifter tristate buffers control signal
        
        control: in std_logic_vector(4 downto 0); -- control code signal for alu and mac
        carry: in std_logic; -- carry signal for alu
        
        pass: IN std_logic;     -- control bit for OR/PASS for shifter
	      x_in: IN std_logic;     -- extension bit to be filled in the left part of shifter array
	      HI_LO:IN std_logic;     -- control bit to indicate high/low position in shifter array
	      offset: IN std_logic_vector(7 downto 0);     -- bits to indicate the offset for the shifter
	      alu_out: INOUT std_logic_vector(15 downto 0);
	      mac_out : INOUT std_logic_vector(15 downto 0);
				SR_out : INOUT std_logic_vector(31 downto 0)
);
end component;
  
  component controller is
     port(clk: IN std_logic;
        En: OUT std_logic;
        PMA : IN std_logic_vector(13 downto 0); -- the PMA bus
        DMA : IN std_logic_vector(13 downto 0); -- the DMA bus
        PMD : IN std_logic_vector(23 downto 0); -- the PMD bus
        DMD : INOUT std_logic_vector(15 downto 0); -- the DMD bus
				s_shifter: OUT std_logic_vector(3 downto 0); -- selection signal for shifter muxes
 				s_alu : OUT std_logic_vector(7 downto 0); -- selection signal for alu muxes
				s_mac : OUT std_logic_vector(10 downto 0); -- selection signal for mac muxes
				s2_mac : OUT std_logic_vector(1 downto 0); -- selection signal for 4into1 mac mux			
				s_program_seq : OUT std_logic_vector(1 downto 0); -- selection signal for program_control muxes				
				load_alu : OUT std_logic_vector(5 downto 0); -- load signal for alu registers
           load_mac : OUT std_logic_vector(7 downto 0); -- load signal for mac registers
           load_shifter : OUT std_logic_vector(2 downto 0); -- load signal for shifter registers
				load_program_seq : OUT std_logic_vector(2 downto 0); -- load signal for program control registers
        
				bc_shifter : OUT std_logic_vector(3 downto 0); -- shifter tristate buffers control signal
				bc_alu : OUT std_logic_vector(3 downto 0); -- alu tristate buffers control signal
				bc_mac : OUT std_logic_vector(5 downto 0); -- mac tristate buffers control signal
 			 	bc_program_seq : OUT std_logic_vector(2 downto 0); -- program_control tristate buffers control signal
        
				pass: OUT std_logic;     -- control bit for OR/PASS for shifter
  	    x_in: OUT std_logic;     -- extension bit to be filled in the left part of shifter array
  	    HI_LO:OUT std_logic;     -- control bit to indicate high/low position in shifter array
  	    offset: OUT std_logic_vector(7 downto 0);     -- bits to indicate the offset for the shifter
				carry : OUT std_logic; -- carry out for ALU
				control: OUT std_logic_vector(4 downto 0); -- control code signal for alu and mac
				read : out std_logic);
end component;
  
  component program_memory is
    port(PMA: IN std_logic_vector(13 downto 0); -- address bus
         PMD: INOUT std_logic_vector(23 downto 0); --data bus
         read: IN std_logic
         );
  end component;
  
    
  signal PMA, DMA: std_logic_vector(13 downto 0);
  signal PMD: std_logic_vector(23 downto 0);
  signal DMD,R: std_logic_vector(15 downto 0);
  signal En: std_logic;      
  signal s_program_seq : std_logic_vector(1 downto 0); -- selection signal for program_sequencer muxes
  signal s_alu : std_logic_vector(7 downto 0); -- selection signal for alu muxes
  signal s_mac : std_logic_vector(10 downto 0); -- selection signal for mac muxes
  signal s2_mac :  std_logic_vector(1 downto 0); -- selection signal for 4into1 mac mux			
  signal s_shifter: std_logic_vector(3 downto 0); -- selection signal for shifter muxes
        
  signal load_program_seq : std_logic_vector(2 downto 0); -- load signal for program sequencer registers
  signal load_alu :  std_logic_vector(5 downto 0); -- load signal for alu registers
  signal load_mac :  std_logic_vector(7 downto 0); -- load signal for mac registers
  signal load_shifter :  std_logic_vector(2 downto 0); -- load signal for shifter registers
        
       
  signal bc_program_seq :  std_logic_vector(2 downto 0); -- program_control tristate buffers control signal
  signal bc_alu :  std_logic_vector(3 downto 0); -- alu tristate buffers control signal
	signal bc_mac :  std_logic_vector(5 downto 0); -- mac tristate buffers control signal
 	signal bc_shifter :  std_logic_vector(3 downto 0); -- shifter tristate buffers control signal
        
              
  
        
   signal control:  std_logic_vector(4 downto 0); -- control code signal for alu and mac
   signal carry: std_logic; -- carry signal for alu
        
    signal  pass: std_logic;     -- control bit for OR/PASS for shifter
	 signal  x_in:  std_logic;     -- extension bit to be filled in the left part of shifter array
	 signal  HI_LO: std_logic;     -- control bit to indicate high/low position in shifter array
	 signal  offset:  std_logic_vector(7 downto 0);     -- bits to indicate the offset for the shifter
	 signal read:  std_logic;   
	 
  

	
	begin
	
	   P1: processing_unit port map(clk,rs,En,PMA,DMA,PMD,DMD,R,s_program_seq ,s_alu ,s_mac,s2_mac,s_shifter,
					load_program_seq,load_alu,load_mac,load_shifter ,bc_program_seq,bc_alu,bc_mac,bc_shifter,control,carry,
		      pass,x_in,HI_LO,offset,alu_out,mac_out,SR_out );
		PM1: program_memory  port map(PMA,PMD,read);
	   C1: controller  port map(clk,En,PMA ,DMA ,PMD,DMD,s_shifter,s_alu,s_mac,s2_mac,s_program_seq,load_alu, load_mac ,
					load_shifter ,load_program_seq,bc_shifter ,bc_alu,bc_mac ,bc_program_seq ,pass,x_in ,HI_LO,
  	    		offset,carry ,control,read);
	        --PMD <=PMD_O;
		
                   
	 
end struct;   
	  
	      
	      