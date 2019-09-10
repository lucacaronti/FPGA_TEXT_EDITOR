----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/17/2019 01:40:35 PM
-- Design Name: 
-- Module Name: pixel_controller - Behavioral
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

entity pixel_controller is
    Port ( 
           clk                      : in STD_LOGIC;
           resetn                   : in STD_LOGIC;
           -- vga_controller    --
           disp_en                  : in STD_LOGIC;
           pixel_col                : in INTEGER RANGE 0 TO HORIZONTAL_PIXELS-1;
           pixel_row                : in INTEGER RANGE 0 TO VERTICAL_PIXELS-1;
           -- editor            --
           cursor_rel_pos           : in INTEGER RANGE 0 TO NUMBER_OF_CHARS_IN_A_FRAME - 1; -- position relative to the top left character of the frame
           -- frame_buffer      --
           is_FB_writing            : in STD_LOGIC;
           data_from_FB             : in STD_LOGIC_VECTOR (BITS_ADDRESSING_ALPHABET-1 DOWNTO 0); --char value outputted from frame_buffer          
           addr_for_data_from_FB    : out STD_LOGIC_VECTOR(FRAME_BUFFER_ADDRESS_WIDTH-1 downto 0); --adress of the request to frame_buffer
           -- fonts_rom          --
           data_from_FR             : in STD_LOGIC_VECTOR(FONTS_ROM_DATA_WIDTH-1 DOWNTO 0);
           request_for_FR           : out STD_LOGIC_VECTOR(FONTS_ROM_ADDRESS_WIDTH-1 DOWNTO 0);
           -- hardware          --
           VGA_R            : out STD_LOGIC_VECTOR(3 DOWNTO 0);
           VGA_G            : out STD_LOGIC_VECTOR(3 DOWNTO 0);
           VGA_B            : out STD_LOGIC_VECTOR(3 DOWNTO 0)
     );
end pixel_controller;

architecture Behavioral of pixel_controller is
begin

end architecture Behavioral;

    
--architecture Behavioral of pixel_controller is
--    -----------------------------------------------------------------------
--    --                   Signals monitor management                      --
--    -----------------------------------------------------------------------
--    signal char_max_col 		    : INTEGER := HORIZONTAL_PIXELS/FONTS_ROM_DATA_WIDTH; --max number of characters IN A row printable
--    signal char_max_row 		    : INTEGER := VERTICAL_PIXELS/CHAR_HEIGHT; --max number of text rows printable   
--    signal char_VGA_col			    : INTEGER RANGE 0 TO (HORIZONTAL_PIXELS/FONTS_ROM_DATA_WIDTH)-1; -- since we think in characters it's usefull to know in witch character column we are
--    signal char_VGA_col_LAST_VALUE 	: INTEGER RANGE 0 TO (HORIZONTAL_PIXELS/FONTS_ROM_DATA_WIDTH)-1 := 0; 			-- a random value from which a change in char_vga_col can be noticed
--    signal char_VGA_row             : INTEGER RANGE 0 TO (VERTICAL_PIXELS/CHAR_HEIGHT)-1; -- since we think in characters it's usefull to know in witch character row we are
    
    
--    -----------------------------------------------------------------------
--    --                   Signals for font management                     --
--    -----------------------------------------------------------------------
--    signal fonts_ROM_addr_req		: STD_LOGIC_VECTOR(FONTS_ROM_ADDRESS_WIDTH-1 DOWNTO 0) := (others => '0'); --fonts rom address request, a connection signal between the logic and fonts rom
--    signal fonts_ROM_data_out		: STD_LOGIC_VECTOR(FONTS_ROM_DATA_WIDTH-1 DOWNTO 0); 		      --fonts rom output data vector, "						     "
----    signal fonts_ROM_data_out_mem	: STD_LOGIC_VECTOR(FONTS_ROM_DATA_WIDTH-1 DOWNTO 0) := (OTHERS => '0'); --a memory for the last fonts rom output data vector, "			     "
 
    
--begin --start of pixel controller logic
   
--    f_rom: entity work.fonts_rom(Behavioral)
--    port map(
--        clk =>clk,
--        addr=>fonts_ROM_addr_req,
--        data_out => fonts_ROM_data_out
--    );
                  
--    char_VGA_col <= pixel_col/CHAR_WIDTH; --with this we know in witch character colum we are
--    char_VGA_row <= pixel_row/CHAR_HEIGHT; --with this we know on which line of text we are  
        
--    GET_FUT_PIX_VAL: process (resetn,clk) is    -- at clock N get the pixel value for process N+1
--                                                    -- the process depends on the char_VGA_Col since 
--                                                    -- char_VGA_row cannot change previously to it    
--    variable stream_address_number : INTEGER RANGE 0 TO 2**STREAM_ADDR_WIDTH := 0;  -- address that will be requested to stream 
--    variable charactor_line : INTEGER RANGE 0 TO CHAR_HEIGHT := 0; -- which line of pixels of a specific characer is requested
     
--    begin
--        if resetn = '0' then   -- async reset
--            fonts_ROM_addr_req <= (others => '0'); 
--            char_VGA_col_LAST_VALUE <= 73; -- a random value
--            stream_address_number := 0;
--            charactor_line := 0;
--         elsif rising_edge(clk) then --instead of clk VGA_clk could be used in case the enable signal should be on for more time
--            if char_VGA_col /= char_VGA_col_LAST_VALUE then -- if actual value is different then the previous one
--                                                              -- process starts every CHAR_WIDTH pixel printed
----                if(char_VGA_col + char_max_col*char_VGA_row < cursor_rel_pos-1) then -- not lesseq because column/rows are from 0 to N-1
----                                                                                 -- if char_VGA_col + char_max_col*char_VGA_row = cursor_rel_pos - 1 then we are on the cursor
--                    stream_address_number := (char_VGA_row * char_max_col)+(char_VGA_col + 1) MOD char_max_col; -- note the +1 since we want the next character instead  of the one we are in
--                    if(char_VGA_col = (char_max_col- 1)) then
--                        charactor_line := (pixel_row + 1) MOD CHAR_HEIGHT;
--                        if((pixel_row mod CHAR_HEIGHT)=(CHAR_HEIGHT-1)) then     -- if we are at the end of a char_line and we are printing the last charactor
--                            stream_address_number := (char_VGA_row + 1 )* char_max_col; -- we want to restart at a new column
--                            if(char_VGA_row = char_max_row-1)then
--                                stream_address_number := 0;
--                            end if;       
--                        end if;  
--                    end if;                                                                           
----                end if;     -- NB values will be requested even during the back porch pulse and front porch of v_sync
--                char_VGA_col_LAST_VALUE <= char_VGA_col; -- update last cvalue of char_VGA_col
--                req_char_addr_en <= '1';                  -- request the data from the stream
--            elsif pixel_col MOD CHAR_WIDTH > 0 then -- if we are in the process of printing a new character
--                req_char_addr_en <= '0';                       --then disable the signal for the
--            end if;

--            req_char_addr <= std_logic_vector(unsigned(stream_start_addr) + to_unsigned(stream_address_number,STREAM_ADDR_WIDTH)); -- this is always true, but the process will decide when to enable this signal
--            fonts_ROM_addr_req <=  data_from_frame_buffer & std_logic_vector(to_unsigned(charactor_line,BITS_ADDRESSING_CHAR_HEIGHT));     --this is always true we are constantl listening for a
--        end if;                                                                                                                     -- char value from the stream
--                                                                                                                                    -- process FONT_PIXEL will sample its value 
--    end process;   

--    TODO : ricontrollare e migliorare questo processo
--   CHARACTOR_MEM: process(pixel_col) begin
----        if change_pixel = '1' then
----            change_pixel <= '0';
----        else
----            change_pixel <= '1';
----        end if;
--        if pixel_col MOD CHAR_WIDTH = CHAR_WIDTH - 2 then
--            fonts_ROM_data_out_mem <= fonts_ROM_data_out;
--        end if;
----        else 
----            font_out_mem <= font_out_mem;
----        end if;
--    end process;
    
--    PRINT_PIXEL: process (pixel_col) is
--        variable pointer : INTEGER RANGE 0 TO CHAR_WIDTH-1 := 0; 
--        variable font_mem : std_logic_vector (CHAR_WIDTH-1 DOWNTO 0);
--    begin
    
--        if(pixel_col MOD CHAR_WIDTH = 0) then
--            font_mem :=fonts_ROM_data_out;
--        end if;
--        pointer := CHAR_WIDTH - ((pixel_col)  MOD CHAR_WIDTH) -1;
--        if (font_mem( pointer ) = '0' AND disp_en = '1') then -- HERE COULD BE PRINTED ALL IN REVERS ORDER LOOK AT HOW FONT_OUT IS DEFINED
--            VGA_R <= (others => '1'); -- inverse coloring: white on black
--            VGA_G <= (others => '1');
--            VGA_B <= (others => '1');
--        else 
--            VGA_R <= (others => '0');
--            VGA_G <= (others => '0');
--            VGA_B <= (others => '0');
--        end if;
--   end process;
--end Behavioral;
