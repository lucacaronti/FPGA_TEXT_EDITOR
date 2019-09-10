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
    signal CLK100MHZ,CPU_RESETN,VGA_HS,VGA_VS,CLK_25,disp_en, disp_en_fut, horizontal_active_fut, vertical_active_fut : STD_LOGIC;
    signal column,row                       : INTEGER;
    signal VGA_R,VGA_G,VGA_B                : STD_LOGIC_VECTOR (3 DOWNTO 0);
    signal H_active, V_active, nV_active    : STD_LOGIC;
    signal data_FB_to_image_generator       : STD_LOGIC_VECTOR(7-1 DOWNTO 0);
    signal addr_IG_to_FB                    : STD_LOGIC_VECTOR(12-1 downto 0);
    signal address_for_fonts_rom_data       : STD_LOGIC_VECTOR(11-1 DOWNTO 0);
    signal data_from_fonts_rom              : STD_LOGIC_VECTOR(8-1 DOWNTO 0);
    signal cursor_rel_pos                   : INTEGER RANGE 0 TO 2400 - 1; -- position relative to the top left character of the frame
    signal cursor_blink_time                : STD_LOGIC;
    signal SW                               : std_logic := '0';
    
    signal input_char_value                 : std_logic_vector(BITS_ADDRESSING_ALPHABET - 1 downto 0);
    signal addr_to_stream_for_data          :     STD_LOGIC_VECTOR(STREAM_ADDRESS_WIDTH-1 DOWNTO 0);
    signal output_char_value                : std_logic_vector(BITS_ADDRESSING_ALPHABET - 1 downto 0);
    signal set_cursor_pos                   :  integer range 0 to STREAM_SIZE - 1;
    
    signal is_wrt                           : STD_LOGIC;
    
    component clk_wiz_0 is 
        port(
            clk_in                          : in STD_LOGIC;
            resetn                          : in STD_LOGIC;
            CLK_VGA                         : out STD_LOGIC
        );
    end component;
begin

    img_gen: entity work.image_generator(Behavioral) port map(
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
        VGA_B                           => VGA_B,
        SW                              => SW
        );
        
        clk_wiz: clk_wiz_0 port map(
            clk_in                          => CLK100MHZ,
            resetn                          => CPU_RESETN,
            CLK_VGA                         => CLK_25
        );
        
    cvga_c: entity work.vga_controller(Behavioral) port map(
        pixel_clk                       => CLK_25,
        res                             => CPU_RESETN,
        h_sync                          => VGA_HS,
        v_sync                          => VGA_VS,
        horizontal_active               => H_active,
        vertical_active                 => V_active,
        disp_en                         => disp_en,
        disp_en_fut                     => disp_en_fut,
        horizontal_active_fut           => horizontal_active_fut,
        vertical_active_fut             => vertical_active_fut
    );
    
    ST: entity work.stream(Behavioral) port map(
        sys_clk                         => CLK100MHZ,
        resetn                          => CPU_RESETN,
        input_char_value                => input_char_value,
        request_char_address            => addr_to_stream_for_data,
        set_cursor_pos                  => set_cursor_pos, 
        output_char_value               => output_char_value
    );
    
    FB: entity work.frame_buffer(Behavioral) port map (
        CLK                             => CLK100MHZ,  
        clk_vga                         => CLK_25,
        resetn                          => CPU_RESETN,  
        vertical_sync                   => VGA_VS,  
        stream_start_addr_for_scan      => 0,  
        output_data_from_stream         => output_char_value,  
        addr_to_stream_for_data         => addr_to_stream_for_data,  
                                           
        addr_request_char               => addr_IG_to_FB,  
        output_char_value               => data_FB_to_image_generator,  
             
        is_writing                      => is_wrt          
    );
    
    FS: entity work.fonts_ROM(Behavioral) port map(	
        clk                             => CLK_25,   
        addr                            => address_for_fonts_rom_data,		
        data_out                        => data_from_fonts_rom	
    );    
    
    
    CLK:process begin
        CLK100MHZ <= '0';
        wait for 5ns;
        CLK100MHZ <= '1';
        wait for 5ns;
    end process;
    
    process begin
        input_char_value <= std_logic_vector(to_unsigned(0,BITS_ADDRESSING_ALPHABET));
        cursor_blink_time <= '1';
        cursor_rel_pos <= 23;
        CPU_RESETN <= '1';
        wait for 15ns;
        --CPU_RESETN <= '1';
        --wait for 105 ns;
        set_cursor_pos <=1;
        wait for 10 ns;
        for row in 1 to 30 loop
            
                input_char_value <= std_logic_vector(to_unsigned(row,BITS_ADDRESSING_ALPHABET));
                set_cursor_pos <= set_cursor_pos + 1;
                wait for 20 ns;
            for col in 16 to 93 loop 
                
                input_char_value <= std_logic_vector(to_unsigned(col,BITS_ADDRESSING_ALPHABET));
                set_cursor_pos <= set_cursor_pos + 1;
                wait for 20 ns;
            end loop;
            
                input_char_value <= std_logic_vector(to_unsigned(30-row,BITS_ADDRESSING_ALPHABET));
                set_cursor_pos <= set_cursor_pos + 1;
                wait for 20 ns;
        end loop;
--        cursor_rel_pos <= 1;
--        cursor_blink_time <= '0';
--        for row in 65 to 125 loop
            
--                input_char_value <= std_logic_vector(to_unsigned(row,BITS_ADDRESSING_ALPHABET));
--                set_cursor_pos <= set_cursor_pos + 1;
--                wait for 20 ns;
--            for col in 15 to 93 loop 
                
--                input_char_value <= std_logic_vector(to_unsigned(col,BITS_ADDRESSING_ALPHABET));
--                set_cursor_pos <= set_cursor_pos + 1;
--                wait for 20 ns;
--            end loop;
            
--                input_char_value <= std_logic_vector(to_unsigned(127,BITS_ADDRESSING_ALPHABET));
--                set_cursor_pos <= set_cursor_pos + 1;
--                wait for 20 ns;
--        end loop;
        wait;
    end process;
end Behavioral;