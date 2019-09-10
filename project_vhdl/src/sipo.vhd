----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2019 23:18:06
-- Design Name: 
-- Module Name: sipo - Behavioral
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

entity sipo is
    port(
        PS2_DATA : in std_logic; -- connect to PS2 data
        init_sipo : in std_logic; -- sipo initialization signal 
        PS2_CLK : in std_logic; -- connect to PS2 clock
        data_coming : out std_logic := '0'; -- if = '1' -> data is coming
        data_ready : out std_logic; -- set when data is ready and you can read from parallel_output
        parallel_output : buffer std_logic_vector(0 to 10) := (others => '1')); -- output of sipo
end sipo;

architecture Behavioral of sipo is
    -- This sipo register (Serial Input - Parallel Output) takes the incoming data from PS2_DATA
    -- Keyboard PS2 protocol use 11-bit words that include a start bit (0), data byte (LSB first), odd parity, and stop bit (1)
    -- When all data arrives data_ready signal in set and you can read data from parallel_output signals, then you must reset sipo
    -- Sipo doesn't check if data is arrived correctly
    signal sipo_counter : unsigned(3 downto 0) := (others => '0'); -- counter for shift register 
begin

    process(PS2_CLK ,init_sipo) is begin
        if init_sipo = '0' then
            -- register initialization 
            data_coming <= '0'; -- reset data_coming
            sipo_counter <= (others => '0'); -- reset sipo_counter
            data_ready <= '0'; -- reset data_ready
            
        elsif falling_edge(PS2_CLK) then
            if sipo_counter = 10 then data_ready <= '1'; -- if sipo_counter is equal to 10 -> all data is arrived -> set data_ready
            else sipo_counter <= sipo_counter + 1; -- increases counter -> new bit arrived 
            end if;
            data_coming <= '1'; -- means the data are coming in register
            parallel_output <= PS2_DATA & parallel_output(0 to 9); -- data shift
        end if;
    end process;
end Behavioral;
