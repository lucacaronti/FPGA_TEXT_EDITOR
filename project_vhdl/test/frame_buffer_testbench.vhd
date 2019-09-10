----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/05/2019 09:53:44 AM
-- Design Name: 
-- Module Name: frame_buffer_testbench - Behavioral
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

entity frame_buffer_testbench is
--  Port ( );
end frame_buffer_testbench;

architecture Behavioral of frame_buffer_testbench is
--    component clk_wiz_0 is 
--    port(
--        clk_in : in STD_LOGIC;
--        resetn  : in STD_LOGIC;
--        CLK_VGA : out STD_LOGIC
--    );
--    end component;
    
    signal CLK100HZ,CPU_RESETN,CLK_25: STD_LOGIC;
    signal set_cursor_pos: INTEGER;
    signal stream_start_addr_for_scan: INTEGER :=0;
    signal req_char_addr : STD_LOGIC_VECTOR(17 downto 0);
    signal output_char_value : std_logic_vector(BITS_ADDRESSING_ALPHABET - 1 downto 0);
    signal input_char:std_logic_vector(BITS_ADDRESSING_ALPHABET - 1 downto 0);
    

    signal vertical_sync : STD_LOGIC :='0';
    signal addr_req_char : STD_LOGIC_VECTOR (FRAME_BUFFER_ADDRESS_WIDTH-1 DOWNTO 0);
    signal output_char_ascii: STD_LOGIC_VECTOR(BITS_ADDRESSING_ALPHABET-1 DOWNTO 0);
    signal is_writing :STD_LOGIC;
begin
    
    process begin
        CLK100HZ <= '0';
        wait for 5 ns;
        CLK100HZ <= '1';
        wait for 5ns;
    end process;
    
--    CLK25: clk_wiz_0 port map(
--        clk_in => CLK100HZ,
--        resetn => CPU_RESETN,
--        CLK_VGA => CLK_25
--    );
    STREAM: entity work.stream(Behavioral) port map(
        sys_clk => CLK100HZ,               
        resetn => CPU_RESETN,                
        input_char_value => input_char,      
        request_char_address => req_char_addr,
        set_cursor_pos => set_cursor_pos,        
        output_char_value => output_char_value        
    );
    FRAME_BUFFER: entity work.frame_buffer(Behavioral) port map(
        CLK => CLK100HZ,              
        resetn => CPU_RESETN,                   
        vertical_sync => vertical_sync,           
        stream_start_addr_for_scan => stream_start_addr_for_scan,               
        output_data_from_stream => output_char_value,               
        addr_to_stream_for_data => req_char_addr,                          
        addr_request_char => addr_req_char,    
        output_char_value  => output_char_ascii,
        is_writing => is_writing       
    );
    test:process begin
        CPU_RESETN <='0';
        stream_start_addr_for_scan <= 0;
        set_cursor_pos <= 0;
        input_char <= (others => '0');
        addr_req_char <= (OTHERS => '0');
        wait for 20 ns;
        CPU_RESETN <= '1';
        wait for 100 ns;
--        for row in 65 to 125 loop
--            wait for 10 ns;
--                input_char <= std_logic_vector(to_unsigned(row,BITS_ADDRESSING_ALPHABET));
--            for col in 15 to 93 loop 
--                wait for 10 ns;
--                input_char <= std_logic_vector(to_unsigned(col,BITS_ADDRESSING_ALPHABET));
--            end loop;
--            wait for 10 ns;
--                input_char <= std_logic_vector(to_unsigned(127,BITS_ADDRESSING_ALPHABET));
--        end loop;
            for val in 1 to 4 loop 
                wait for 10 ns;
                input_char <= std_logic_vector(to_unsigned(val,BITS_ADDRESSING_ALPHABET));
                set_cursor_pos <= val-1;
            end loop;
        wait for 10ns;
        vertical_sync <= '1';
        wait for 10 ns;
        stream_start_addr_for_scan <= 1;
        wait for 20ns;
        stream_start_addr_for_scan <= 1;
        
        wait for 55 ns;
            for val in 0 to 3 loop 
                wait for 10 ns;
                addr_req_char <= std_logic_vector(to_unsigned(val,FRAME_BUFFER_ADDRESS_WIDTH));
            end loop;
        wait for 200 us;
            vertical_sync <='0';
        wait for 10ns;
            stream_start_addr_for_scan <= 0;
            vertical_sync <= '1';
        wait for 200 us;
            vertical_sync <='0';
        wait ;
    end process;
end Behavioral;
