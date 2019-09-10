----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.05.2019 12:11:04
-- Design Name: 
-- Module Name: fsm_keyboard - Behavioral
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

-------------------------------- description ---------------------------------------
-- In this file is implemented a finite state machine to manage keyboard
-- It could menage up to five digit at the same time


entity fsm_keyboard is
    port (
        clk          : in std_logic; 
        resetn       : in std_logic;
        button_out_1 : out std_logic_vector(7 downto 0);
        button_out_2 : out std_logic_vector(7 downto 0);
        button_out_3 : out std_logic_vector(7 downto 0);
        button_out_4 : out std_logic_vector(7 downto 0);
        button_out_5 : out std_logic_vector(7 downto 0);
        shift_out    : out std_logic;
        capsLock_en  : buffer std_logic;
        data_in      : in std_logic_vector(7 downto 0);
        new_data     : in std_logic 
    );
end fsm_keyboard;

architecture Behavioral of fsm_keyboard is
    type state_type is(
        wait_state,
        state_1
    );
    signal state : state_type := wait_state;
    constant left_shift : std_logic_vector(7 downto 0) := "00010010"; -- 0x12
    constant right_shift : std_logic_vector(7 downto 0) := "01011001"; -- 0x59
    constant extended_key : std_logic_vector(7 downto 0) := "11100000"; -- 0xE0
    constant key_release : std_logic_vector(7 downto 0) := "11110000"; -- 0xF0
    constant correct_init : std_logic_vector(7 downto 0) := "10101010"; -- 0xAA
    constant zero : std_logic_vector(7 downto 0) := "00000000"; --0x00
    constant button_capsLock : std_logic_vector(7 downto 0) := "01011000"; --0x58
    signal key_rel : integer;
    
    type queue_type is array (4 downto 0) of std_logic_vector(7 downto 0); 
    signal queue : queue_type;
begin

    fsm : process(clk,resetn) is
        variable queue_counter : integer;
    begin
        if resetn = '0' then
            -- reset instruction
            state <= wait_state;
            queue(0) <= (others => '0');
            queue(1) <= (others => '0');
            queue(2) <= (others => '0');
            queue(3) <= (others => '0');
            queue(4) <= (others => '0');
            shift_out <= '0';
            queue_counter := 0;
            key_rel <= 0;
        elsif rising_edge(clk) then
            case state is
                when wait_state =>
                    if new_data = '1' then -- if new data is available change state
                        state <= state_1;
                    end if;  
                when state_1 =>
                    state <= wait_state; -- nex state is wait_state
                    if data_in = key_release then -- check if data_in is equal to key_release code
                        key_rel <= 1; -- if key_release data is arrived -> set key_rel = 1
                    elsif data_in = left_shift or data_in = right_shift then -- check if data_in is equal to shift code
                        if key_rel = 1 then -- if key_rel = 1 and has arrived shift code -> shift was released
                            key_rel <= 0;
                            shift_out <= '0';
                        else
                            shift_out <= '1';
                        end if;
                    elsif data_in = extended_key then
                    -- to implement if extended_key arrived
                    elsif data_in = correct_init then
                    -- to implement if correct_init code arrived
                    elsif data_in = button_capsLock then -- check if data_in is equal to caps lock code
                        if key_rel = 1 then -- if key_rel = 1 and has arrived caps lock code -> caps lock was released
                            key_rel <= 0;
                            if capsLock_en = '0' then -- if caps lock = 0 means that was pressed to activate it, else to disactivate 
                                capsLock_en <= '1';
                            else
                                capsLock_en <= '0';
                             end if;
                        end if;       
                    else -- normal button code arrived
                        if key_rel = 1 then -- if key_rel = 1 -> delete data from queue and set it as 0
                            key_rel <= 0;
                            if data_in = queue(0) then
                                queue(0) <= (others => '0');
                                queue_counter := queue_counter - 1;
                            elsif data_in = queue(1) then
                                queue(1) <= (others => '0');
                                queue_counter := queue_counter - 1;
                            elsif data_in = queue(2) then
                                queue(2) <= (others => '0');
                                queue_counter := queue_counter - 1;
                            elsif data_in = queue(3) then
                                queue(3) <= (others => '0');
                                queue_counter := queue_counter - 1;
                            elsif data_in = queue(4) then
                                queue(4) <= (others => '0');
                                queue_counter := queue_counter - 1;
                            else
                            
                            end if;
                        else -- button pressed
                            if queue_counter <= 5 then -- check if there is space in queue
                                if data_in /= queue(0) and data_in /= queue(1) and data_in /= queue(2) and data_in /= queue(3) and data_in /= queue(4) then -- if it is already inside the queue -> don't save it
                                    if queue(0) = zero then
                                        queue(0) <= data_in;
                                        queue_counter := queue_counter + 1;
                                    elsif queue(1) = zero then
                                        queue(1) <= data_in;
                                        queue_counter := queue_counter + 1;
                                    elsif queue(2) = zero then
                                        queue(2) <= data_in;
                                        queue_counter := queue_counter + 1;
                                    elsif queue(3) = zero then
                                        queue(3) <= data_in;
                                        queue_counter := queue_counter + 1;
                                    elsif queue(4) = zero then
                                        queue(4) <= data_in;
                                        queue_counter := queue_counter + 1;
                                    end if;
                                end if;
                            end if;
                        end if;
                    end if;
            end case;
        end if;
    end process;

    -- connection of queue to button_out
    button_out_1 <= queue(0);
    button_out_2 <= queue(1);
    button_out_3 <= queue(2);
    button_out_4 <= queue(3);
    button_out_5 <= queue(4);

end Behavioral;

