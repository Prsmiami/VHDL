LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;

ENTITY toplevel IS
   PORT ( CLOCK_50, CLOCK2_50, AUD_DACLRCK   	: IN    STD_LOGIC;
          AUD_ADCLRCK, AUD_BCLK, AUD_ADCDAT  	: IN    STD_LOGIC;
			 AUD_DACDAT										: OUT   STD_LOGIC;
          KEY                                	: IN    STD_LOGIC;
			 FPGA_AUD_XCK									: OUT   STD_LOGIC;
			 FPGA_I2C_SCLK									: OUT   STD_LOGIC;
          FPGA_I2C_SDAT                      	: INOUT STD_LOGIC
			);
END toplevel;

ARCHITECTURE Behavior OF toplevel IS
   COMPONENT clock_generator
      PORT( CLOCK_27 : IN STD_LOGIC;
            reset    : IN STD_LOGIC;
            AUD_XCK  : OUT STD_LOGIC);
   END COMPONENT;

   COMPONENT audio_and_video_config
      PORT( CLOCK_50 : IN STD_LOGIC;
            reset    : IN STD_LOGIC;
            I2C_SDAT : INOUT STD_LOGIC;
            I2C_SCLK : OUT STD_LOGIC);
   END COMPONENT;   

   COMPONENT audio_codec
      PORT( CLOCK_50 			: IN STD_LOGIC;
            reset    			: IN STD_LOGIC;
				read_s 				: IN STD_LOGIC;
            write_s  			: IN STD_LOGIC;
				writedata_left 	: IN STD_LOGIC_VECTOR(23 downto 0);
            writedata_right 	: IN STD_LOGIC_VECTOR(23 downto 0);
				AUD_ADCDAT 			: IN STD_LOGIC;
            AUD_BCLK 			: IN STD_LOGIC;
				AUD_ADCLRCK 		: IN STD_LOGIC;
				AUD_DACLRCK 		: IN STD_LOGIC;
            read_ready 			: OUT STD_LOGIC;
            write_ready 		: OUT STD_LOGIC;
				readdata_left		: OUT STD_LOGIC_VECTOR(23 downto 0);q2
				readdata_right		: OUT STD_LOGIC_VECTOR(23 downto 0);
				AUD_DACDAT			: OUT STD_LOGIC);
   END COMPONENT;

   SIGNAL read_ready, write_ready, read_s, write_s 		: STD_LOGIC;
   SIGNAL readdata_left, readdata_right            		: STD_LOGIC_VECTOR(23 DOWNTO 0);
   SIGNAL writedata_left, writedata_right          		: STD_LOGIC_VECTOR(23 DOWNTO 0);   
   SIGNAL reset                                    		: STD_LOGIC;
 
BEGIN
	reset <= NOT(KEY);
	
	write_s <= write_ready;
	read_s <= read_ready;
	writedata_right <= readdata_right;
	writedata_left <= readdata_left;

   my_clock_gen: clock_generator PORT MAP (CLOCK2_50, reset, FPGA_AUD_XCK);
   cfg: audio_and_video_config PORT MAP (CLOCK_50, reset, FPGA_I2C_SDAT, FPGA_I2C_SCLK);
   codec: audio_codec PORT MAP (CLOCK_50, reset, read_s, write_s, writedata_left, 
	                             writedata_right, AUD_ADCDAT, AUD_BCLK, AUD_ADCLRCK,
										  AUD_DACLRCK, read_ready, write_ready, readdata_left, 
										  readdata_right, AUD_DACDAT);
  
END Behavior;