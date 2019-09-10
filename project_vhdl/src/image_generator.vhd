----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/17/2019 01:40:35 PM
-- Design Name: 
-- Module Name: image_generator - Behavioral
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

entity image_generator is
    Port (
       pixel_clk                        : in STD_LOGIC;
       resetn                           : in STD_LOGIC;
       -- vga_controller    --
       disp_en                          : in STD_LOGIC;
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
       VGA_R                            : out STD_LOGIC_VECTOR(3 DOWNTO 0);
       VGA_G                            : out STD_LOGIC_VECTOR(3 DOWNTO 0);
       VGA_B                            : out STD_LOGIC_VECTOR(3 DOWNTO 0);
       SW                               : in std_logic_vector(11 downto 0)
     );
end image_generator;

architecture Behavioral of image_generator is

    -----------------------------------------------------------------------
    --                            CONSTANTS                              --
    -----------------------------------------------------------------------
    constant MAX_VAL_A : INTEGER := CHAR_WIDTH -1;
    constant MAX_VAL_AA : INTEGER := HORIZONTAL_PIXELS/CHAR_WIDTH-1;
    constant MAX_VAL_B : INTEGER := CHAR_HEIGHT-1;
    constant MAX_VAL_BB : INTEGER := NUMBER_OF_CHARS_IN_A_FRAME - HORIZONTAL_PIXELS/CHAR_WIDTH;--VERTICAL_PIXELS/CHAR_HEIGHT-1;

    -----------------------------------------------------------------------
    --                     Counters Signals                              --
    -----------------------------------------------------------------------
    signal counter_A    : INTEGER RANGE 0 TO MAX_VAL_A; --this limits must ber converted in constants at the top of image_generator
    signal CE_A,INIT_A,TC_A : STD_LOGIC := '0';
    signal counter_AA   : INTEGER RANGE 0 TO MAX_VAL_AA;
    signal CE_AA,INIT_AA,TC_AA : STD_LOGIC := '0';
    signal counter_B    : INTEGER RANGE 0 TO MAX_VAL_B;
    signal CE_B,INIT_B,TC_B : STD_LOGIC := '0';
    signal counter_BB   : INTEGER RANGE 0 TO MAX_VAL_BB;
    signal CE_BB,INIT_BB,TC_BB : STD_LOGIC := '0';

    -----------------------------------------------------------------------
    --                     Frame_Buffer Signals                          --
    -----------------------------------------------------------------------
    signal addr_for_FB      : INTEGER RANGE 0 TO NUMBER_OF_CHARS_IN_A_FRAME -1;

    -----------------------------------------------------------------------
    --                          Editor Signals                           --
    -----------------------------------------------------------------------
    signal cursor_rel_pos_MEM       : INTEGER RANGE 0 TO NUMBER_OF_CHARS_IN_A_FRAME - 1;
    signal cursor_blink_time_MEM    : STD_LOGIC;
    -----------------------------------------------------------------------
    --                     Image_generator Signals                       --
    -----------------------------------------------------------------------
    signal pixels_value_to_VGA  : STD_LOGIC_VECTOR(0 TO FONTS_ROM_DATA_WIDTH-1);
    signal invert_colors        : STD_LOGIC;
    signal invert_colors_MEM    : STD_LOGIC;
    
begin

    --------------------------------------------------------------------
    --                          Constraints                              --
    -----------------------------------------------------------------------
    CE_AA   <= TC_A;
    CE_B    <= TC_A AND TC_AA;
    CE_BB   <= TC_A AND TC_AA AND TC_B;
    
    addr_for_FB <= counter_BB + counter_AA;
     
    address_for_frame_buffer_data <= std_logic_vector(to_unsigned(addr_for_FB,FRAME_BUFFER_ADDRESS_WIDTH));

    address_for_fonts_rom_data <= data_from_frame_buffer & std_logic_vector(to_unsigned(counter_B,BITS_ADDRESSING_CHAR_HEIGHT));
    
   
    ------------------------------------------------------------------------
    
    COUNTERS_MNGMNT: process(disp_en,vertical_active) is
    begin
        -----------------------------------------------------------------------
        --                          Default Values                           --
        -----------------------------------------------------------------------
        CE_A    <= '0';
        INIT_A  <= '1';
        INIT_AA <= '1';
        INIT_B  <= '0';
        INIT_BB <= '1';
        -----------------------------------------------------------------------
        
        if(disp_en = '1') then
            CE_A <= '1';
            INIT_A <= '0';
            INIT_AA <= '0';
        end if;
        if(vertical_active = '1') then
            INIT_BB <= '0';
        end if;
    end process COUNTERS_MNGMNT;
    
    SAVE_FONTS_ROM_DATA : process (resetn,pixel_clk) is
    begin
        if (resetn = '0' ) then
            pixels_value_to_VGA <= (OTHERS => '0');   
        elsif rising_edge(pixel_clk) then
            if (disp_en = '1' AND TC_A = '1') then
                pixels_value_to_VGA <= data_from_fonts_rom; --save the data to be displayed
            end if;
        end if;
    end process SAVE_FONTS_ROM_DATA;
    
    MEM_EDITOR_SIGNALS: process (resetn,vertical_active) is --to mantain consistency during DISPLAY_TIME variable inputs values are stored
    begin 
        if (resetn = '0' ) then
            cursor_rel_pos_MEM<= 0;
            cursor_blink_time_MEM <= '0';
        elsif rising_edge(vertical_active) then
            cursor_rel_pos_MEM <= cursor_rel_pos;  
            cursor_blink_time_MEM <= cursor_blink_time;
        end if;
    end process MEM_EDITOR_SIGNALS;
    
    INV_COL: process (resetn,pixel_clk) is
    begin
        if (resetn = '0') then
            invert_colors <= '0';
            invert_colors_MEM <= '0';
        elsif rising_edge(pixel_clk) then
                -----------------------------------------------------------------------
                --                          Default Values                           --
                -----------------------------------------------------------------------
                invert_colors <= '0';
            if(counter_BB + counter_AA = cursor_rel_pos_MEM AND cursor_blink_time_MEM = '1') then
                invert_colors <= '1';
            end if;
            if(TC_A = '1') then
                invert_colors_MEM <= invert_colors;
            end if;
        end if;
    end process INV_COL;
    
    IMAGE_GEN: process (pixel_clk) is --if the sum of counter_BB and counter_AA is too slow worng values could be detected
    begin
 
        if rising_edge(pixel_clk) then
            -----------------------------------------------------------------------
            --                          Default Values                           --
            -----------------------------------------------------------------------
            VGA_R <= (others => '0');
            VGA_G <= (others => '0');
            VGA_B <= (others => '0');
            
            if (disp_en = '1') then
                if(pixels_value_to_VGA(counter_A) = invert_colors_MEM) then --invert_colors_MEM) then
                    VGA_R <= SW(11 downto 8);
                    VGA_G <= SW(7 downto 4);
                    VGA_B <= SW(3 downto 0);
                else
                    VGA_R <= not SW(11 downto 8);
                    VGA_G <= not SW(7 downto 4);
                    VGA_B <= not SW(3 downto 0);
                end if;
            end if;
        end if;
    end process IMAGE_GEN;
    
    COUNT_A: entity work.counter(Behavioral)
    generic map(
        MAX         => MAX_VAL_A,
        INIT_VALUE  => 0,
        INCREASE_BY => 1
    )
    port map(
        clk         => pixel_clk,
        resetn      => resetn,
        INIT        => INIT_A,
        CE          => CE_A,
        TC          => TC_A,
        value       => counter_A
    );
    
    COUNT_AA: entity work.counter(Behavioral)
    generic map(
        MAX         => MAX_VAL_AA,
        INIT_VALUE  => 1,
        INCREASE_BY => 1
    )
    port map(
        clk         => pixel_clk,
        resetn      => resetn,
        INIT        => INIT_AA,
        CE          => CE_AA, 
        TC          => TC_AA,
        value       => counter_AA
    );
    
    COUNT_B: entity work.counter(Behavioral)
    generic map(
        MAX         => MAX_VAL_B,
        INIT_VALUE  => 0,
        INCREASE_BY => 1
    )
    port map(
        clk         => pixel_clk,
        resetn      => resetn,
        INIT        => INIT_B,
        CE          => CE_B,
        TC          => TC_B,
        value       => counter_B
    );
    
    COUNT_BB: entity work.counter(Behavioral)
    generic map(
        MAX         => MAX_VAL_BB,
        INIT_VALUE  => 0,
        INCREASE_BY => HORIZONTAL_PIXELS/CHAR_WIDTH
    )
    port map(
        clk         => pixel_clk,
        resetn      => resetn,
        INIT        => INIT_BB,
        CE          => CE_BB,
        TC          => TC_BB,
        value       => counter_BB
    );
    
    
end architecture Behavioral;
