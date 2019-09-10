----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/20/2019 02:17:09 PM
-- Design Name: 
-- Module Name: image_generator_testbench - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
use work.commonPak.ALL;

entity image_generator_testbench is
--  Port ( );
end image_generator_testbench;

architecture Behavioral of image_generator_testbench is
--    component clk_wiz_0 is 
--    port(
--        clk_in                          : in STD_LOGIC;
--        resetn                          : in STD_LOGIC;
--        CLK_VGA                         : out STD_LOGIC
--    );
--    end component;
    
    component image_generator is 
    port(
       clk                              : in STD_LOGIC;
       pixel_clk                        : in STD_LOGIC;
       resetn                           : in STD_LOGIC;
       -- vga_controller    --
       disp_en                          : in STD_LOGIC;
       disp_en_fut                      : in STD_LOGIC;
       horizontal_active                : in STD_LOGIC;
       vertical_active                  : in STD_LOGIC;
       -- editor            --
       cursor_rel_pos                   : in INTEGER RANGE 0 TO NUMBER_OF_CHARS_IN_A_FRAME - 1; -- position relative to the top left character of the frame
       cursor_blink_time                : in STD_LOGIC;
       -- frame_buffer      --
       --is_FB_writing                    : in STD_LOGIC;
       data_from_frame_buffer           : in STD_LOGIC_VECTOR (BITS_ADDRESSING_ALPHABET-1 DOWNTO 0); --char value outputted from frame_buffer          
       address_for_frame_buffer_data    : out STD_LOGIC_VECTOR(FRAME_BUFFER_ADDRESS_WIDTH-1 downto 0); --adress of the request to frame_buffer
--       -- fonts_rom          --
       data_from_fonts_rom              : in STD_LOGIC_VECTOR(FONTS_ROM_DATA_WIDTH-1 DOWNTO 0);
       address_for_fonts_rom_data       : out STD_LOGIC_VECTOR(FONTS_ROM_ADDRESS_WIDTH-1 DOWNTO 0);
       -- hardware          --
       VGA_R                            : out STD_LOGIC_VECTOR(3 DOWNTO 0) := BACKGROUND_COLOR;
       VGA_G                            : out STD_LOGIC_VECTOR(3 DOWNTO 0) := BACKGROUND_COLOR;
       VGA_B                            : out STD_LOGIC_VECTOR(3 DOWNTO 0) := BACKGROUND_COLOR
    );
    end component;
    
--    component vga_controller is 
--    generic(
--		h_pulse 		: INTEGER 	:=96;		--horizontal sync pulse in pixels
--		h_bkprch		: INTEGER	:=48;		--horizontal back porch width in pixels
--		h_pixels		: INTEGER	:=HORIZONTAL_PIXELS;		--horizontal display width in pixels
--		h_frprch		: INTEGER	:=16;		--horizontal front porch width in pixels
--		h_pol			: STD_LOGIC	:='0';		--horizontal sync pulse polarity (1= positive, 0= negative)

--		v_pulse 		: INTEGER 	:=2;		--vertical sync pulse in pixels
--		v_bkprch		: INTEGER	:=33;		--vertical back porch width in pixels
--		v_pixels		: INTEGER	:=VERTICAL_PIXELS;		--vertical display width in pixels
--		v_frprch		: INTEGER	:=10;		--vertical front porch width in pixels
--		v_pol			: STD_LOGIC	:='0'		--vertical sync pulse polarity (1= positive, 0= negative)
--        );
--	port(
--		pixel_clk		    : IN	STD_LOGIC;		--pixel clock frequency in function of VGA mode used 
--		res			        : IN 	STD_LOGIC;		--active low async reset	
--		h_sync			    : OUT	STD_LOGIC;		--horizontal sync pulse
--		v_sync			    : OUT	STD_LOGIC;		--vertical sync pulse
--		horizontal_active	: OUT 	STD_LOGIC;
--		vertical_active		: OUT 	STD_LOGIC;
--		disp_en			    : OUT 	STD_LOGIC;		--display enable ('1'= display time, '0'= blanking time)
		
--		disp_en_fut         : OUT   STD_LOGIC;
--		vertical_active_fut : OUT   STD_LOGIC;
--		horizontal_active_fut : OUT   STD_LOGIC
--		--column			: OUT 	INTEGER RANGE 0 TO h_pixels-1;		--horizontal pixel coordinate
--		--row			    : OUT 	INTEGER RANGE 0 TO v_pixels-1		--vertical pixel coordinate
--    );
--    end component;
    
--    component stream is
--    port(
--        sys_clk                         : in std_logic;
--        resetn                          : in std_logic;
--        input_char_value                : in std_logic_vector(BITS_ADDRESSING_ALPHABET - 1 downto 0);
--        request_char_address            : in std_logic_vector(STREAM_ADDRESS_WIDTH - 1 downto 0);
--        set_cursor_pos                  : in integer range 0 to STREAM_SIZE - 1; 
--        output_char_value               : out std_logic_vector(BITS_ADDRESSING_ALPHABET - 1 downto 0)
--    );
--    end component stream;

--    component frame_buffer is
--    port(
--       CLK                              : in STD_LOGIC;
--       clk_vga                          : in std_logic;
--       resetn                           : in STD_LOGIC;
--       vertical_sync                   : in STD_LOGIC;
--       stream_start_addr_for_scan       : in INTEGER RANGE 0 TO STREAM_SIZE-1; --the start position from witch the frame buffer will start scanning the stream --NB must be latched otherwise during scan it could change
--       output_data_from_stream          : in STD_LOGIC_VECTOR(BITS_ADDRESSING_ALPHABET-1 DOWNTO 0);
--       addr_to_stream_for_data          : out STD_LOGIC_VECTOR(STREAM_ADDRESS_WIDTH-1 DOWNTO 0); --request_addr for data
       
--       addr_request_char                : in STD_LOGIC_VECTOR(FRAME_BUFFER_ADDRESS_WIDTH-1 downto 0);
--       output_char_value                : out STD_LOGIC_VECTOR(BITS_ADDRESSING_ALPHABET-1 DOWNTO 0);
    
--       is_writing                       : out STD_LOGIC --says if frame buffer is in writing mode so reads are not accessible
--    );
--    end component frame_buffer;
    
--    component fonts_ROM is 
--	port(	
--	   	clk		                        : in STD_LOGIC;
--		addr		                    : in STD_LOGIC_VECTOR(FONTS_ROM_ADDRESS_WIDTH-1 downto 0);		-- input address
--		data_out	                    : out STD_LOGIC_VECTOR(FONTS_ROM_DATA_WIDTH-1 downto 0)		-- value of the address
--	    );
--    end component fonts_ROM;
    
    signal CLK100MHZ,CPU_RESETN,VGA_HS,VGA_VS,CLK_25,disp_en, disp_en_fut, horizontal_active_fut, vertical_active_fut : STD_LOGIC;
    signal column,row                       : INTEGER;
    signal VGA_R,VGA_G,VGA_B                : STD_LOGIC_VECTOR (3 DOWNTO 0);
    signal H_active, V_active, nV_active    : STD_LOGIC;
    signal data_FB_to_image_generator       : STD_LOGIC_VECTOR(BITS_ADDRESSING_ALPHABET-1 DOWNTO 0);
    signal addr_IG_to_FB                    : STD_LOGIC_VECTOR(FRAME_BUFFER_ADDRESS_WIDTH-1 downto 0);
    signal is_wrt                           : STD_LOGIC;
    signal input_char_value                 : std_logic_vector(BITS_ADDRESSING_ALPHABET - 1 downto 0);
    signal addr_to_stream_for_data          :     STD_LOGIC_VECTOR(STREAM_ADDRESS_WIDTH-1 DOWNTO 0);
    signal output_char_value                : std_logic_vector(BITS_ADDRESSING_ALPHABET - 1 downto 0);
    signal set_cursor_pos                   :  integer range 0 to STREAM_SIZE - 1;
    signal address_for_fonts_rom_data       : STD_LOGIC_VECTOR(FONTS_ROM_ADDRESS_WIDTH-1 DOWNTO 0);
    signal data_from_fonts_rom              : STD_LOGIC_VECTOR(FONTS_ROM_DATA_WIDTH-1 DOWNTO 0);
    signal cursor_rel_pos                   : INTEGER RANGE 0 TO NUMBER_OF_CHARS_IN_A_FRAME - 1; -- position relative to the top left character of the frame
    signal cursor_blink_time                : STD_LOGIC;
begin
--    nV_active <= not V_active;
--    clk_wiz: clk_wiz_0 port map(
--        clk_in                          => CLK100MHZ,
--        resetn                          => CPU_RESETN,
--        CLK_VGA                         =>CLK_25
--    );
--    vga_c: vga_controller port map(
--        pixel_clk                       => CLK_25,
--        res                             => CPU_RESETN,
--        h_sync                          => VGA_HS,
--        v_sync                          => VGA_VS,
--        horizontal_active               => H_active,
--        vertical_active                 => V_active,
--        disp_en                         => disp_en,
--        disp_en_fut                     => disp_en_fut,
--        horizontal_active_fut           => horizontal_active_fut,
--        vertical_active_fut             => vertical_active_fut
--    );
    img_gen: image_generator port map(
        clk                             => CLK100MHZ,
        pixel_clk                       => clk_25,
        resetn                          => CPU_RESETN,
        disp_en                         => disp_en,
        disp_en_fut                     => disp_en_fut,
        horizontal_active               => H_active,
        vertical_active                 => V_active,
        cursor_rel_pos                  => cursor_rel_pos,
        cursor_blink_time               => cursor_blink_time,
        data_from_frame_buffer          => data_FB_to_image_generator,
        address_for_frame_buffer_data   => addr_IG_to_FB,
        data_from_fonts_rom             => data_from_fonts_rom,            
        address_for_fonts_rom_data      => address_for_fonts_rom_data,      
        VGA_R                           => VGA_R,
        VGA_G                           => VGA_G,
        VGA_B                           => VGA_B
    );
--    ST: stream port map(
--        sys_clk                         => CLK100MHZ,
--        resetn                          => CPU_RESETN,
--        input_char_value                => input_char_value,
--        request_char_address            => addr_to_stream_for_data,
--        set_cursor_pos                  => set_cursor_pos, 
--        output_char_value               => output_char_value
--    );
    
--    FB: frame_buffer port map (
--        CLK                             => CLK100MHZ,  
--        clk_vga                         => CLK_25,
--        resetn                          => CPU_RESETN,  
--        vertical_sync                  => VGA_VS,  
--        stream_start_addr_for_scan      => 0,  
--        output_data_from_stream         => output_char_value,  
--        addr_to_stream_for_data         => addr_to_stream_for_data,  
                                           
--        addr_request_char               => addr_IG_to_FB,  
--        output_char_value               => data_FB_to_image_generator,  
             
--        is_writing                      => is_wrt          
--    );
--    FS: fonts_ROM port map(	
--        clk                             => CLK_25,   
--        addr                            => address_for_fonts_rom_data,		
--        data_out                        => data_from_fonts_rom	
--    );                   
    
--    CLK:process begin
--        CLK100MHZ <= '0';
--        wait for 5ns;
--        CLK100MHZ <= '1';
--        wait for 5ns;
--    end process;
    
    
--    process begin
--        input_char_value <= std_logic_vector(to_unsigned(0,BITS_ADDRESSING_ALPHABET));
--        cursor_blink_time <= '1';
--        cursor_rel_pos <= 23;
--        CPU_RESETN <= '0';
--        wait for 15ns;
--        CPU_RESETN <= '1';
--        wait for 105 ns;
--        set_cursor_pos <=1;
--        wait for 10 ns;
--        for row in 1 to 30 loop
            
--                input_char_value <= std_logic_vector(to_unsigned(row,BITS_ADDRESSING_ALPHABET));
--                set_cursor_pos <= set_cursor_pos + 1;
--                wait for 20 ns;
--            for col in 16 to 93 loop 
                
--                input_char_value <= std_logic_vector(to_unsigned(col,BITS_ADDRESSING_ALPHABET));
--                set_cursor_pos <= set_cursor_pos + 1;
--                wait for 20 ns;
--            end loop;
            
--                input_char_value <= std_logic_vector(to_unsigned(30-row,BITS_ADDRESSING_ALPHABET));
--                set_cursor_pos <= set_cursor_pos + 1;
--                wait for 20 ns;
--        end loop;
----        cursor_rel_pos <= 1;
----        cursor_blink_time <= '0';
----        for row in 65 to 125 loop
            
----                input_char_value <= std_logic_vector(to_unsigned(row,BITS_ADDRESSING_ALPHABET));
----                set_cursor_pos <= set_cursor_pos + 1;
----                wait for 20 ns;
----            for col in 15 to 93 loop 
                
----                input_char_value <= std_logic_vector(to_unsigned(col,BITS_ADDRESSING_ALPHABET));
----                set_cursor_pos <= set_cursor_pos + 1;
----                wait for 20 ns;
----            end loop;
            
----                input_char_value <= std_logic_vector(to_unsigned(127,BITS_ADDRESSING_ALPHABET));
----                set_cursor_pos <= set_cursor_pos + 1;
----                wait for 20 ns;
----        end loop;
--        wait;
--    end process;
end Behavioral;
