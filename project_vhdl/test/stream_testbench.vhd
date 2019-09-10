----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/28/2019 05:50:00 PM
-- Design Name: 
-- Module Name: stream_testbench - Behavioral
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

entity stream_testbench is
--  Port ( );
end stream_testbench;

architecture Behavioral of stream_testbench is

    
    signal CLK100MHZ,CPU_RESETN: STD_LOGIC;
    signal set_cursor_pos,cursor_rel_pos : INTEGER;
    signal req_char_addr : STD_LOGIC_VECTOR(17 downto 0);
    signal output_char_value : std_logic_vector(BITS_ADDRESSING_ALPHABET - 1 downto 0);
    signal input_char:std_logic_vector(BITS_ADDRESSING_ALPHABET - 1 downto 0);
    signal stream_start_addr: STD_LOGIC_VECTOR (STREAM_ADDRESS_WIDTH-1 DOWNTO 0):=(others => '0');
begin
    stream: entity work.stream(Behavioral) 
        port map(
            sys_clk => CLK100MHZ,                   
            resetn  => CPU_RESETN,                  
            input_char_value => input_char,         
            request_char_address => req_char_addr,  
            set_cursor_pos => set_cursor_pos,           
            output_char_value => output_char_value             
        );
        
    clk: process begin
        CLK100MHZ <= '0';
        wait for 5ns;
        CLK100MHZ <= '1';
        wait for 5ns;
    end process;
    
    test: process begin
        CPU_RESETN <= '0';
        set_cursor_pos <= 0;
        req_char_addr <= (others => '0');
        input_char <= (others => '0');
        wait for 30ns;
        CPU_RESETN <= '1';
        -- quando scrivi in bram cio' che viene salvato viene restituito in output dalla porta douta quindi per sapere se stai scrivendo basta guardare quella
        wait for 100 ns; -- se inizio a scrivere in sincro con il clk ossia con un wait di 105 ns 
                         -- non ho nessun risultato su douta
                         -- INVECE se metto un wait di 100 ns (in modo da inizire a scrivere sul falling_edge del clk) il dato viene scritto
                         -- come si puo' vedere osservando douta
        
        for row in 65 to 125 loop
            wait for 10 ns;
                input_char <= std_logic_vector(to_unsigned(row,BITS_ADDRESSING_ALPHABET));
                set_cursor_pos <= set_cursor_pos + 1;
            for col in 15 to 93 loop 
                wait for 10 ns;
                input_char <= std_logic_vector(to_unsigned(col,BITS_ADDRESSING_ALPHABET));
                set_cursor_pos <= set_cursor_pos + 1;
            end loop;
            wait for 10 ns;
                input_char <= std_logic_vector(to_unsigned(127,BITS_ADDRESSING_ALPHABET));
                set_cursor_pos <= set_cursor_pos + 1;
        end loop;
        
        --letture della bram--
        wait for 55 ns;
        
        req_char_addr <= std_logic_vector(to_unsigned(1,STREAM_ADDRESS_WIDTH));
        wait for 50 ns;
        
        wait for 12 ns;
        
        req_char_addr <= std_logic_vector(to_unsigned(2,STREAM_ADDRESS_WIDTH));
        wait for 48ns;
        
        wait for 18 ns;
        
        req_char_addr <= std_logic_vector(to_unsigned(3,STREAM_ADDRESS_WIDTH));
        wait for 42 ns;
        
        wait for 20 ns;
        
        req_char_addr <= std_logic_vector(to_unsigned(1,STREAM_ADDRESS_WIDTH));
--        wait for 20 ns;
--        req_char_addr_en <= '0';
        wait for 10 ns;
--        req_char_addr_en <= '1';
        req_char_addr <= std_logic_vector(to_unsigned(2,STREAM_ADDRESS_WIDTH));
        wait for 10 ns;
        req_char_addr <= std_logic_vector(to_unsigned(3,STREAM_ADDRESS_WIDTH));
        wait for 10 ns;
        req_char_addr <= std_logic_vector(to_unsigned(4,STREAM_ADDRESS_WIDTH));
        wait;
    end process;
end Behavioral;

