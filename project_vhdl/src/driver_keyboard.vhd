----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2019 23:46:06
-- Design Name: 
-- Module Name: driver_keyboard - Behavioral
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

entity driver_keyboard is
    port(
        PS2_CLK : in std_logic; -- sipo initialization signal 
        PS2_DATA : in std_logic; -- connect to PS2 data
        clock : in std_logic; -- connect to main bus clock (100 MHz)
        global_reset : in std_logic; -- conect to global reset
        data_out : out std_logic_vector(7 downto 0); -- data out signals
        new_data : out std_logic -- new data available signal
        );
end driver_keyboard;

architecture Behavioral of driver_keyboard is
    -- The driver_keyboard files takes care of menaging the sipo
    -- For more information about the fsm see the own diagram
    type state_type is (wait_state, start_watchDog, load_data, reset_state); -- here are defined all states
    signal present_state : state_type := wait_state; -- here are defined the state and set as dafault in wait state
    signal init_sipo,data_in, data_ready, data_coming : std_logic;
    signal parallel_output : std_logic_vector(0 to 10);
    signal watch_dog : unsigned(24 downto 0) := (others => '0'); -- watchDog counter. It's necessary because sometimes data arrives wrong 

begin
    -- sipo instance
    sipo1 : entity work.sipo(Behavioral)
        port map(
            PS2_CLK => PS2_CLK,
            init_sipo => init_sipo,
            PS2_DATA => PS2_DATA,
            data_ready => data_ready,
            parallel_output => parallel_output,
            data_coming => data_coming
        );  
    process(clock, global_reset) begin
        if global_reset = '0' then
            -- reset operations
            present_state <= wait_state; -- set as default state -> wait_state
            init_sipo <= '0'; -- sipo initilization
            new_data <= '0'; -- reset new_data signal
        elsif rising_edge(clock) then
            present_state <= present_state; -- as default don't change the state
            case present_state is
                when wait_state => -- wait state
                    init_sipo <= '1'; -- end sipo initilization          
                    if data_coming = '1' then
                        present_state <= start_watchDog; -- if data is coming change state into start_watchDog
                    end if;
                when start_watchDog => -- start watchDog state
                    watch_dog <= watch_dog + 1; -- increase watchdog each clock cycle
                    if data_ready = '1' then
                        present_state <= load_data; -- if data is ready change state
                    elsif watch_dog >= "1001100010010110100000000" then -- 50 ms at 400MHz bus clock
                        -- too much time has passed since the data began to enter, so reset the sipo and wait for new data
                        watch_dog <= (others => '0'); -- reset watchDog counter
                        present_state <= reset_state; -- go to reset state
                    end if;
                when load_data => -- load data state
                    present_state <= reset_state; -- go directly to reset state
                    new_data <= '1'; -- set new data = '1' -> new data is available
                    -- invert the data, because parallel_output is defined as (x to n) and data_out is defined as (x downto n)
                    data_out(0) <= parallel_output(9);
                    data_out(1) <= parallel_output(8);
                    data_out(2) <= parallel_output(7);
                    data_out(3) <= parallel_output(6);
                    data_out(4) <= parallel_output(5);
                    data_out(5) <= parallel_output(4);
                    data_out(6) <= parallel_output(3);
                    data_out(7) <= parallel_output(2);
                    
                when reset_state => -- reset state
                    new_data <= '0'; -- remove new_data signal
                    present_state <= wait_state; -- go to wait state
                    init_sipo <= '0'; -- start sipo initilization 
                    watch_dog <= (others => '0'); -- reset watchDog counters
            end case;
        else
            present_state <= present_state;
        end if;
    end process;
end Behavioral;
