----------------------------------------------------------------------------------
-----------------------------------------------------------------------
--                     Instrunction for use                          --
-----------------------------------------------------------------------
-- if you want:
------------------------- write into BRAM -----------------------------
-- You need to set port "input_char_value" with the value you want to save
-- It's a synchronous process, so the value will be saved at the clk rising edge
-- If you want to save another equal value you need to set "input_char_value" as 0 for one (or more) clocks cycle and then set another value
-- If you want to increase the cursor after have saved the data, you can set set_cursor_pos after one or more clock cycles

-------------------------- read from BRAM -----------------------------
-- You need to set "request_char_address_en" and "request_char_address" if you want to read a cell
-- After 2 clock cycles data is available on "output_char_value" port
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

entity stream is
    port(
        sys_clk                   : in std_logic;
        resetn                    : in std_logic;
        input_char_value          : in std_logic_vector(BITS_ADDRESSING_ALPHABET - 1 downto 0);
        request_char_address      : in std_logic_vector(STREAM_ADDRESS_WIDTH - 1 downto 0);
        set_cursor_pos            : in integer range 0 to STREAM_SIZE - 1; 
        output_char_value         : out std_logic_vector(BITS_ADDRESSING_ALPHABET - 1 downto 0)
    );
end stream;

architecture Behavioral of stream is
    component blk_mem_gen_0
        PORT (
            clka      : in std_logic;
            rsta      : in std_logic;
            ena       : in std_logic;
            wea       : in std_logic_vector(0 downto 0);
            addra     : in std_logic_vector(STREAM_ADDRESS_WIDTH - 1 downto 0);
            dina      : in std_logic_vector(6 downto 0);
            douta     : out std_logic_vector(6 downto 0);
            clkb      : in std_logic;
            rstb      : in std_logic;
            enb       : in std_logic;
            web       : in std_logic_vector(0 downto 0);
            addrb     : in std_logic_vector(STREAM_ADDRESS_WIDTH - 1 downto 0);
            dinb      : in std_logic_vector(6 downto 0);
            doutb     : out std_logic_vector(6 downto 0);
            rsta_busy : out std_logic;
            rstb_busy : out std_logic
        );
    end component;
    -----------------------------------------------------------------------
    --                  Signals for blk_mem_gen_0                        --
    -----------------------------------------------------------------------
    signal rsta          : std_logic;
    signal ena           : std_logic := '0'; -- enable BRAM A port
    signal wea           : std_logic_vector(0 downto 0) := (others => '0'); -- BRAM A write enable
    signal addra         : std_logic_vector(STREAM_ADDRESS_WIDTH - 1 downto 0):= (others => '0'); -- BRAM A address
    signal dina          : std_logic_vector(6 downto 0) := (others => '0'); -- BRAM A data input
    signal douta         : std_logic_vector(6 downto 0) := (others => '0'); -- BRAM A darta output
    signal rsta_busy     : std_logic;
 
    signal rstb          : std_logic;
    signal enb           : std_logic := '0'; -- enable BRAM B port
    signal web           : std_logic_vector(0 downto 0)  := (others => '0'); -- BRAM B write enable
    signal addrb         : std_logic_vector(STREAM_ADDRESS_WIDTH - 1 downto 0) := (others => '0'); -- BRAM B address
    signal dinb          : std_logic_vector(6 downto 0)  := (others => '0'); -- BRAM B data input
    signal doutb         : std_logic_vector(6 downto 0)  := (others => '0'); -- BRAM B darta output
    signal rstb_busy     : std_logic;
    
    -----------------------------------------------------------------------
    --                     Signals for keyboard                          --
    -----------------------------------------------------------------------
    signal input_char_value_last    : std_logic_vector(6 downto 0) := (others => '0');
    signal input_char_value_last_FF : std_logic_vector(6 downto 0) := (others => '0');
    
    -----------------------------------------------------------------------
    --                         Other signals                             --
    -----------------------------------------------------------------------

    -----------------------------------------------------------------------
begin
    BRAM : blk_mem_gen_0
        port map (
            clka => sys_clk,
            rsta => rsta,
            ena => ena,
            wea => wea,
            addra => addra,
            dina => dina,
            douta => douta,
            clkb => sys_clk,
            rstb => rstb,
            enb => enb,
            web => web,
            addrb => addrb,
            dinb => dinb,
            doutb => doutb,
            rsta_busy => rsta_busy,
            rstb_busy => rstb_busy
        );
        
    rsta <= not resetn; -- BRAM A reset (positive)
    rstb <= not resetn; -- BRAM B reset (positive)

    output_char_value <= doutb;
    enb <= '1';
    addrb <= request_char_address;
         
    writing_into_BRAM : process(input_char_value, set_cursor_pos) begin
        -- set default values
        ena <= '0';
        wea <= "0";
        addra <= (others => '0');
        dina <= (others => '0');
        input_char_value_last <= input_char_value; -- save keyboard_digit as last digit
        if input_char_value /= input_char_value_last_FF and input_char_value /= "0000000" then -- if there is a new input_char_value and it's different from 0 -> send data to BRAM
            ena <= '1'; -- enable BRAM A
            wea <= "1"; -- write enable A
            addra <= std_logic_vector(to_unsigned(set_cursor_pos, STREAM_ADDRESS_WIDTH)); -- set the BRAM address
            dina <= std_logic_vector(input_char_value); -- save keyboard_digit into the BRAM
        end if;
    end process;
    
    save_char_val : process(sys_clk, resetn) begin -- PROCESS
        if resetn = '0' then
            input_char_value_last_FF <= (others => '0');
        elsif rising_edge(sys_clk) then
            input_char_value_last_FF <= input_char_value;
        end if;
    end process;
    
end Behavioral;
