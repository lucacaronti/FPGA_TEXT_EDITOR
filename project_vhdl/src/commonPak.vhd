library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.MATH_REAL.all;

package commonPak is
    constant HORIZONTAL_PIXELS          : INTEGER := 640;
    constant VERTICAL_PIXELS            : INTEGER := 480;
    constant CHAR_WIDTH                 : INTEGER := 8;
    constant CHAR_HEIGHT                : INTEGER := 16;
    
    constant FONTS_ROM_ADDRESS_WIDTH    : INTEGER := 11; -- address width 2^11-1 = addressable memory --change in FONT_ROM_ADDR_WIDTH                  
    constant FONTS_ROM_DATA_WIDTH       : INTEGER := CHAR_WIDTH;  -- data width no of pixel reperesenting the character width
      
    constant CHAR_IN_ALPHABET           : INTEGER := 127;
    constant BITS_ADDRESSING_ALPHABET   : INTEGER := 7; --ln(CHAR_IN_ALPHABET)
    constant BITS_ADDRESSING_CHAR_HEIGHT: INTEGER := 4; --ln(CHAR_HEIGHT)
    
    constant HORIZONTAL_CHARS           : INTEGER := HORIZONTAL_PIXELS/CHAR_WIDTH;
    constant VERTICAL_CHARS             : INTEGER := VERTICAL_PIXELS/CHAR_HEIGHT;
    constant NUMBER_OF_CHARS_IN_A_FRAME : INTEGER := HORIZONTAL_CHARS * VERTICAL_CHARS;
    
    constant FRAME_BUFFER_ADDRESS_WIDTH : INTEGER := 12; --LOG(2,NUMBER_OF_CHARS_IN_A_FRAME)
    constant STREAM_ADDRESS_WIDTH       : INTEGER := 15; -- change this to a lower value to make sinthesis quicker
    constant STREAM_SIZE                : INTEGER := 2**STREAM_ADDRESS_WIDTH;
    constant MAX_CURSOR_VAL             : INTEGER := STREAM_SIZE;
    
    --constant BACKGROUND_COLOR           : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0'); -----BLACK = 0, WHITE = 1
    --constant TEXT_COLOR                 : STD_LOGIC_VECTOR(3 DOWNTO 0) := NOT BACKGROUND_COLOR;
end package;
