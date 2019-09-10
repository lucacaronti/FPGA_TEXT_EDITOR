----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/04/2019 10:31:56 AM
-- Design Name: 
-- Module Name: frame_buffer - Behavioral
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
--TODOD's
-- -define INTEGER SIZES 
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
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/04/2019 10:31:56 AM
-- Design Name: 
-- Module Name: frame_buffer - Behavioral
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
--TODOD's
-- -define INTEGER SIZES 
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

entity frame_buffer is
    port(
       CLK                          : in     STD_LOGIC;
       clk_vga                      : in     STD_LOGIC;
       resetn                       : in     STD_LOGIC;
       vertical_sync                : in     STD_LOGIC;
       stream_start_addr_for_scan   : in     INTEGER RANGE 0 TO MAX_CURSOR_VAL - NUMBER_OF_CHARS_IN_A_FRAME; --the start position from witch the frame buffer will start scanning the stream --NB must be latched otherwise during scan it could change
       output_data_from_stream      : in     STD_LOGIC_VECTOR(BITS_ADDRESSING_ALPHABET-1 DOWNTO 0);
       addr_to_stream_for_data      : out    STD_LOGIC_VECTOR(STREAM_ADDRESS_WIDTH-1 DOWNTO 0); --request_addr for data
       
       addr_request_char            : in    STD_LOGIC_VECTOR(FRAME_BUFFER_ADDRESS_WIDTH-1 downto 0);
       output_char_value            : out   STD_LOGIC_VECTOR(BITS_ADDRESSING_ALPHABET-1 DOWNTO 0);
    
       is_writing                   : out    STD_LOGIC --says if frame buffer is in writing mode so reads are not accessible
    
    );
end frame_buffer;

architecture Behavioral of frame_buffer is
    component blk_mem_gen_1 is port(
        clka        : in STD_LOGIC;
        ena         : in STD_LOGIC;
        wea         : in STD_LOGIC_VECTOR(0 DOWNTO 0);
        addra       : in STD_LOGIC_VECTOR(FRAME_BUFFER_ADDRESS_WIDTH-1 DOWNTO 0);
        dina        : in STD_LOGIC_VECTOR(BITS_ADDRESSING_ALPHABET-1 DOWNTO 0);
        clkb        : IN STD_LOGIC;
        enb         : IN STD_LOGIC;
        addrb       : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
        doutb       : OUT STD_LOGIC_VECTOR(BITS_ADDRESSING_ALPHABET-1 DOWNTO 0)
    );
    end component blk_mem_gen_1;
    
    component blk_mem_gen_2
        PORT (
            clka        : IN STD_LOGIC;
            ena         : IN STD_LOGIC;
            wea         : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            addra       : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            dina        : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            clkb        : IN STD_LOGIC;
            enb         : IN STD_LOGIC;
            addrb       : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            doutb       : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
        );
    end component;
    
    
    -----------------------------------------------------------------------
    --                  Signals for blk_mem_gen_1                        --
    -----------------------------------------------------------------------
    signal ena          : std_logic := '0'; -- enable BRAM A port
    signal wea          : std_logic_vector(0 downto 0) := (others => '0'); -- BRAM A write enable
    signal addra        : std_logic_vector(FRAME_BUFFER_ADDRESS_WIDTH-1 downto 0):= (others => '0'); -- BRAM A address
    signal dina         : std_logic_vector(BITS_ADDRESSING_ALPHABET-1 downto 0) := (others => '0'); -- BRAM A data input
    
    signal enb          : std_logic := '0';
    signal addrb        : std_logic_vector(FRAME_BUFFER_ADDRESS_WIDTH-1 downto 0) := (others => '0');
    signal doutb        : std_logic_vector(BITS_ADDRESSING_ALPHABET-1 downto 0) := (others => '0'); -- BRAM A data output
    
    -----------------------------------------------------------------------
    --                  Signals for blk_mem_gen_2                        --
    -----------------------------------------------------------------------
    signal ena2          : std_logic := '1';
    signal wea2          : std_logic_vector(0 downto 0) := (others => '1');  
    signal addra2        : std_logic_vector(0 downto 0) := (others => '0');
    signal dina2         : std_logic_vector(0 downto 0) := (others => '0');
    signal enb2          : std_logic := '1';
    signal addrb2        : std_logic_vector(0 downto 0) := (others => '0');
    signal doutb2        : std_logic_vector(0 downto 0) := (others => '0');
               
    -----------------------------------------------------------------------
    --                         Management signals                        --
    -----------------------------------------------------------------------
    signal start        : STD_LOGIC := '0'; -- signal that tells frame_buffer to start scanning the stream
    signal start_pulse  : STD_LOGIC := '0';
    signal vertical_sync_MEM : STD_LOGIC := '0';
    signal vertical_sync_MEM_1 : STD_LOGIC := '0';
    signal stream_start_addr_for_scan_MEM   : INTEGER RANGE 0 TO STREAM_SIZE-1; --since stream_start_addr_for_scan could change during scan a copy of it is made to keep consistency
    signal addr_where_save_stream_data      : std_logic_vector(FRAME_BUFFER_ADDRESS_WIDTH-1 downto 0); --when in writng_mode (reading from stream and writing frame_buffer) addresses where to save data are saved here
                                                                                                         --this signal is needed for multiplexing addra when in writing or reading mode of frame_buffer
    -----------------------------------------------------------------------
    --                         Counter    signals                        --
    -----------------------------------------------------------------------
    signal MAX_VALUE    : INTEGER := NUMBER_OF_CHARS_IN_A_FRAME + 1; -- +2 is the delay of the stream  
    signal value        : INTEGER RANGE 0 TO NUMBER_OF_CHARS_IN_A_FRAME + 1; 
    signal CE           : STD_LOGIC; --count enable
    signal INIT         : STD_LOGIC; --init
    signal TC           : STD_LOGIC; --terminal count
    
    -----------------------------------------------------------------------
    --                 FSM states                                        --
    -----------------------------------------------------------------------
    type STATE is (wait_state,start_state);
    signal present_state    : STATE;
    signal next_state       : STATE;
    
      
begin
    BRAM : blk_mem_gen_1
        port map (
            clka => clk,
            ena => ena,
            wea => wea,
            addra => addra,
            dina => dina,
            clkb => clk_vga,
            enb => enb,
            addrb => addrb,
            doutb => doutb
        );
        
    BRAM2 : blk_mem_gen_2
        port map (
            clka => clk_vga,
            ena => ena2,
            wea => wea2,
            addra => addra2,
            dina => dina2,
            clkb => clk,
            enb => enb2,
            addrb => addrb2,
            doutb => doutb2
        );
        
    -----------------------------------------------------------------------
    --                         Constraints                               --
    -----------------------------------------------------------------------    
    ena <= '1';
    enb <= '1';
    
    ena2 <= '1';
    enb2 <= '1';
    wea2 <= "1";
    addra2 <= "0";
    addrb2 <= "0";
    dina2(0) <= vertical_sync;
    vertical_sync_MEM <= doutb2(0);
    is_writing <= start;
    output_char_value <= doutb;      
    dina <= output_data_from_stream;  --the input of the frame buffer is the output of the stream
    addra <= addr_where_save_stream_data;
    addrb <= addr_request_char;

    
    FSM_STARTER : process(clk) begin
        if rising_edge(clk) then
            if (resetn = '0') then
                start_pulse <= '0';
                vertical_sync_MEM_1 <= '0';
            else
                vertical_sync_MEM_1 <= vertical_sync_MEM_1;
                start_pulse <= '0';
                if vertical_sync_MEM = '1' then
                    if vertical_sync_MEM_1 = '0' then
                        start_pulse <= '1';
                        vertical_sync_MEM_1 <= '1';
                    end if;
                else
                    vertical_sync_MEM_1 <= '0';
                end if;
            end if;
        end if;
    end process FSM_STARTER;
    
    --*******************************************************************--
    --                 FSM of frame buffer                               --
    --*******************************************************************--
    SEQUENTIAL: process(resetn,clk)is
    begin
        if (resetn = '0') then
            present_state <= wait_state;
        elsif rising_edge(clk) then
            present_state <= next_state;
        end if;
    end process SEQUENTIAL;
    
    FUT_CALC: process (present_state,start_pulse,TC) is 
    begin
        ----------------------------Default Values-----------------------------
        next_state <= present_state;
        -----------------------------------------------------------------------
        
        case present_state is
        when wait_state =>
            if (start_pulse = '1') then
                next_state <= start_state;
            end if;
        when start_state =>
            if ( TC = '1') then
                next_state <= wait_state;
            end if;
        end case;
    end process FUT_CALC;
    
    OUTPUTS: process (present_state) is --moore machine
    begin
        ----------------------------Default Values-----------------------------
        start <= '0';
        if( present_state = wait_state) then 
            stream_start_addr_for_scan_MEM <= stream_start_addr_for_scan; --inferenced latch    
        elsif (present_state = start_state) then
            start <= '1';
        end if;
    end process OUTPUTS;
    
    --*******************************************************************--
    
    -----------------------------------------------------------------------
    --                 Process for data request to stream                --
    -----------------------------------------------------------------------    
    MANAGE_EN_SIGNALS:process(clk,resetn) is -- add start? 
    begin 
        if(resetn = '0') then
            CE <= '0';
            INIT <= '0';
            wea <= "0"; -- write enable for BRAM_A disable
            
        elsif rising_edge(clk) then
            
            -----------------------------------------------------------------------
            --                          Default Values                           --
            -----------------------------------------------------------------------            
            CE <= '0';
            INIT <= '1'; --initialize if in no working state
            wea <= "0";
            
            
            if(start = '1') then
                CE <= '1';  --start counting if in working state, such that value 0 is used to
                INIT <= '0'; --stop initialization if in working state
                if value > 0 then
                    wea <= "1"; --enable write enable for BRAM                  
                end if;
                if(TC = '1') then
                    CE <= '0';
                    INIT <= '1';
                    wea <= "0";
                end if;
            end if;
        end if;   
    end process;
    
    -----------------------------------------------------------------------
    --                 Process for addresses calculation                 --
    -----------------------------------------------------------------------
    
    ADDR_CALC:process (value,TC,stream_start_addr_for_scan_MEM) is
    begin
        addr_where_save_stream_data <= (OTHERS => '0');
        addr_to_stream_for_data <= STD_LOGIC_VECTOR(to_unsigned(stream_start_addr_for_scan_MEM,STREAM_ADDRESS_WIDTH)); --the requested data is from the start of the stream to MAX_CHAR_COL*MAX_CHAR_ROW
        
        if value < NUMBER_OF_CHARS_IN_A_FRAME then           
            addr_to_stream_for_data <= STD_LOGIC_VECTOR(value + to_unsigned(stream_start_addr_for_scan_MEM,STREAM_ADDRESS_WIDTH)); --the requested data is from the start of the stream to MAX_CHAR_COL*MAX_CHAR_ROW  
        end if;
        if value > 1 then                    
            addr_where_save_stream_data <= std_logic_vector(to_unsigned(value-2,FRAME_BUFFER_ADDRESS_WIDTH)); -- TODO WATCH FOR ERRORS: ned\gative values in addra
        end if;
    end process;

    -----------------------------------------------------------------------
    --                 Process for counter implementation                --
    -----------------------------------------------------------------------
    
    COUNTER:process(clk,resetn) is
    begin
        if resetn = '0' then
            value <= 0;
            TC <= '0';
        elsif rising_edge(clk) then
            TC <= '0';
            if INIT = '1' then
                value <= 0;
            elsif CE = '1' then
                if( value = MAX_VALUE - 1 ) then 
                    TC <= '1';
                end if;
                if(value = MAX_VALUE ) then
                    value <= 0;
                else
                    value <= value + 1;
                end if;
            end if;
        end if;
    end process;
       
end Behavioral;

