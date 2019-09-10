----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.05.2019 20:06:33
-- Design Name: 
-- Module Name: top_level - Behavioral
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

entity top_level_project is
    Port (
        CLK100MHZ   : in STD_LOGIC;
        CPU_RESETN  : in STD_LOGIC;
        PS2_CLK     : in STD_LOGIC;
        PS2_DATA    : in STD_LOGIC;
        CA          : out STD_LOGIC;
        CB          : out STD_LOGIC;
        CC          : out STD_LOGIC;
        CD          : out STD_LOGIC;
        CE          : out STD_LOGIC;
        CF          : out STD_LOGIC;
        CG          : out STD_LOGIC;
        DP          : out STD_LOGIC;
        AN          : out STD_LOGIC_VECTOR(7 DOWNTO 0 );
        VGA_HS      : out STD_LOGIC;
        VGA_VS      : out STD_LOGIC;
        SW          : in std_logic_vector(11 downto 0);
        VGA_R       : out STD_LOGIC_VECTOR(3 DOWNTO 0) ; -- for red color
        VGA_G       : out STD_LOGIC_VECTOR(3 DOWNTO 0) ; -- for green color
        VGA_B       : out STD_LOGIC_VECTOR(3 DOWNTO 0)  -- for blue color
    );
end top_level_project;


architecture Behavioral of top_level_project is

    -- Clock wizard IP instantiation
    component clk_wiz_0
        port(
            -- Clock out ports
            clk_vga          : out    STD_LOGIC; 
            -- Status and control signals
            resetn           : in     STD_LOGIC;
            -- Clock in ports
            clk_in           : in     STD_LOGIC
        );
    end component;
    
    -----------------------------------------------------------------------
    --                   Signals for clock wizard                        --
    -----------------------------------------------------------------------
    signal clk_vga       : STD_LOGIC; -- clock connection between clock wizard and pixel clock for VGA
    
    -----------------------------------------------------------------------
    --                   Signals for image_generator                     --
    -----------------------------------------------------------------------
    signal address_image_generator_TO_frame_buffer  : STD_LOGIC_VECTOR(FRAME_BUFFER_ADDRESS_WIDTH-1 DOWNTO 0);
    signal address_image_generator_TO_fonts_rom     : STD_LOGIC_VECTOR(FONTS_ROM_ADDRESS_WIDTH-1 DOWNTO 0);
    
    -----------------------------------------------------------------------
    --                   Signals for stream                              --
    -----------------------------------------------------------------------
    signal output_char_value    : STD_LOGIC_VECTOR(BITS_ADDRESSING_ALPHABET - 1 DOWNTO 0);
    
    -----------------------------------------------------------------------
    --                   Signals for frame_buffer                        --
    -----------------------------------------------------------------------
    signal address_frame_buffer_TO_stream       : STD_LOGIC_VECTOR(STREAM_ADDRESS_WIDTH-1 DOWNTO 0);
    signal data_frame_buffer_TO_image_generator : STD_LOGIC_VECTOR(BITS_ADDRESSING_ALPHABET-1 DOWNTO 0);
    signal is_writing                           : STD_LOGIC;
    
    -----------------------------------------------------------------------
    --                   Signals for fonts_rom                           --
    -----------------------------------------------------------------------
    signal data_fonts_rom_TO_image_generator    : STD_LOGIC_VECTOR(FONTS_ROM_DATA_WIDTH-1 DOWNTO 0);
    
    -----------------------------------------------------------------------
    --                     Signals for top_level_keyboard                --
    -----------------------------------------------------------------------
    signal keyboard_digit_1 : INTEGER RANGE 0 TO 255;
    signal keyboard_digit_2 : INTEGER RANGE 0 TO 255;
    signal keyboard_digit_3 : INTEGER RANGE 0 TO 255;
    signal keyboard_digit_4 : INTEGER RANGE 0 TO 255;
    signal keyboard_digit_5 : INTEGER RANGE 0 TO 255;
        
    -----------------------------------------------------------------------
    --                  Signals for editor                               --
    -----------------------------------------------------------------------
    signal cursor_pos_abs   : INTEGER RANGE 0 TO MAX_CURSOR_VAL - 1;
    signal cursor_rel_pos   : INTEGER RANGE 0 TO NUMBER_OF_CHARS_IN_A_FRAME - 1;
    signal frame_start_addr : INTEGER RANGE 0 TO MAX_CURSOR_VAL - NUMBER_OF_CHARS_IN_A_FRAME;
    signal cursor_blink_time: STD_LOGIC;
    signal input_char_value : STD_LOGIC_VECTOR(BITS_ADDRESSING_ALPHABET - 1 DOWNTO 0);
    
    -----------------------------------------------------------------------
    --                  Signals for vga_controller                       --
    -----------------------------------------------------------------------
    signal VGA_horizontal_sync  : STD_LOGIC;
    signal VGA_vertical_sync    : STD_LOGIC;
    signal H_active             : STD_LOGIC;
    signal V_active             : STD_LOGIC;
    signal display_en           : STD_LOGIC; -- '1': you can print on the screen, '0': you can't print on the screen
    
    -----------------------------------------------------------------------
    --                     Signals for keyboard                          --
    -----------------------------------------------------------------------
  
    signal stream_start_addr : STD_LOGIC_VECTOR (STREAM_ADDRESS_WIDTH-1 DOWNTO 0);
    

begin 
    
    -----------------------------------------------------------------------
    --                     Constraints                                   --
    -----------------------------------------------------------------------
    
    VGA_HS <= VGA_horizontal_sync;
    VGA_VS <= VGA_vertical_sync;
    -----------------------------------------------------------------------
    
    
    clock_divider : clk_wiz_0 
    port map ( 
        clk_vga                         => clk_vga,               
        resetn                          => CPU_RESETN,
        clk_in                          => CLK100MHZ
    );
    
    img_gen: entity work.image_generator(Behavioral) port map(
        pixel_clk                       => clk_vga,
        resetn                          => CPU_RESETN,
        disp_en                         => display_en,
        horizontal_active               => H_active,
        vertical_active                 => V_active,
        cursor_rel_pos                  => cursor_rel_pos,
        cursor_blink_time               => cursor_blink_time,
        data_from_frame_buffer          => data_frame_buffer_TO_image_generator,
        address_for_frame_buffer_data   => address_image_generator_TO_frame_buffer,
        data_from_fonts_rom             => data_fonts_rom_TO_image_generator,            
        address_for_fonts_rom_data      => address_image_generator_TO_fonts_rom,      
        VGA_R                           => VGA_R,
        VGA_G                           => VGA_G,
        VGA_B                           => VGA_B,
        SW                              => SW
    );
    
    stream : entity work.stream 
    port map(
        sys_clk                         => CLK100MHZ,
        resetn                          => CPU_RESETN,
        input_char_value                => input_char_value,
        request_char_address            => address_frame_buffer_TO_stream,
        set_cursor_pos                  => cursor_pos_abs,
        output_char_value               => output_char_value
    );
    
    frame_buffer: entity work.frame_buffer(Behavioral) port map (
        CLK                             => CLK100MHZ,  
        clk_vga                         => clk_vga,
        resetn                          => CPU_RESETN,  
        vertical_sync                   => VGA_vertical_sync,  
        stream_start_addr_for_scan      => frame_start_addr,  
        output_data_from_stream         => output_char_value,  
        addr_to_stream_for_data         => address_frame_buffer_TO_stream,  
                                           
        addr_request_char               => address_image_generator_TO_frame_buffer,  
        output_char_value               => data_frame_buffer_TO_image_generator,  
             
        is_writing                      => is_writing
    );
    
    fonts_rom: entity work.fonts_ROM(Behavioral) 
    port map(	
        clk                             => clk_vga,   
        addr                            => address_image_generator_TO_fonts_rom,		
        data_out                        => data_fonts_rom_TO_image_generator	
    );   
    
    TL_keyboard : entity work.top_level_keyboard(Behavioral) 
    port map(
        PS2_CLK                         => PS2_CLK,
        PS2_DATA                        => PS2_DATA,
        clock                           => CLK100MHZ,
        resetn                          => CPU_RESETN,
        CA                              => CA,
        CB                              => CB,
        CC                              => CC,
        CD                              => CD, 
        CE                              => CE,
        CF                              => CF,
        CG                              => CG,
        DP                              => DP,
        AN                              => AN,
        keyboard_digit_1                => keyboard_digit_1,
        keyboard_digit_2                => keyboard_digit_2,
        keyboard_digit_3                => keyboard_digit_3,
        keyboard_digit_4                => keyboard_digit_4,
        keyboard_digit_5                => keyboard_digit_5
    );
    
    editor1 : entity work.editor(Behavioral) 
    port map(
        sys_clk                         => CLK100MHZ,
        resetn                          => CPU_RESETN,
        keyboard_digit_1                => keyboard_digit_1,
        keyboard_digit_2                => keyboard_digit_2,
        keyboard_digit_3                => keyboard_digit_3,
        keyboard_digit_4                => keyboard_digit_4,
        keyboard_digit_5                => keyboard_digit_5,
        cursor_pos_abs                  => cursor_pos_abs,
        cursor_rel_pos                  => cursor_rel_pos,
        frame_start_addr                => frame_start_addr,
        char_to_write                   => input_char_value,
        cursor_blink_time               => cursor_blink_time
    );

    vga_controller : entity work.vga_controller(Behavioral)
    generic map (    
        h_pulse 		                => 96,
        h_bkprch		                => 48,
        h_pixels		                => 640,
        h_frprch		                => 16,
        h_pol			                => '0',
        
        v_pulse 		                => 2,
        v_bkprch		                => 33,
        v_pixels		                => 480,
        v_frprch		                => 10,
        v_pol			                => '0'
    )              
    port map(
        pixel_clk                       => clk_vga,
        res                             => CPU_RESETN,
        h_sync                          => VGA_horizontal_sync,
        v_sync                          => VGA_vertical_sync,
        horizontal_active               => H_active,
        vertical_active                 => V_active,
        disp_en                         => display_en
    );
    
end Behavioral;
