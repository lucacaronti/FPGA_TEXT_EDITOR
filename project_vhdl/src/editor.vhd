----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.06.2019 10:30:31
-- Design Name: 
-- Module Name: editor - Behavioral
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

entity editor is
    port (
        sys_clk : in std_logic;
        resetn : in std_logic;
        keyboard_digit_1 : in integer range 0 to 255;
        keyboard_digit_2 : in integer range 0 to 255;
        keyboard_digit_3 : in integer range 0 to 255;
        keyboard_digit_4 : in integer range 0 to 255;
        keyboard_digit_5 : in integer range 0 to 255;
        cursor_pos_abs   : buffer integer range 0 to MAX_CURSOR_VAL - 1;
        cursor_rel_pos   : buffer integer range 0 to NUMBER_OF_CHARS_IN_A_FRAME - 1;
        frame_start_addr : buffer integer range 0 to MAX_CURSOR_VAL - NUMBER_OF_CHARS_IN_A_FRAME;
        char_to_write    : out std_logic_vector(6 downto 0) := (others => '0');
        cursor_blink_time: out STD_LOGIC
     );
end editor;

architecture Behavioral of editor is
    signal button_1_pressed, button_2_pressed, button_3_pressed, button_4_pressed, button_5_pressed : std_logic := '0';
    signal button_1_saved_FF, button_2_saved_FF, button_3_saved_FF, button_4_saved_FF, button_5_saved_FF : std_logic := '0';
    signal save_button_1, save_button_2, save_button_3, save_button_4, save_button_5 : std_logic := '0';
    signal res_button_1_FF, res_button_2_FF, res_button_3_FF, res_button_4_FF, res_button_5_FF : std_logic := '0';
    type state is (
        wait_state,
        state_1,
        state_2,
        state_3,
        state_4,
        state_5,
        inc_cursor_state,
        dec_cursor_state,
        incRow_cursor_state,
        decRow_cursor_state,
        enter_cursor_state,
        DEL_cursor_state
    );
    signal present_state, future_state : state := wait_state;
    signal blink_counter : integer range 0 to 100000000 := 0;
    signal missing_characters_at_end_of_line : integer range 0 to 79 := 79;
begin
    
    button_1_pressed_process : process(keyboard_digit_1) begin
        if keyboard_digit_1 /= 0 then
            button_1_pressed <= '1';
        else 
            button_1_pressed <= '0';
        end if;
    end process;
    button_2_pressed_process : process(keyboard_digit_2) begin
        if keyboard_digit_2 /= 0 then
            button_2_pressed <= '1';
        else 
            button_2_pressed <= '0';  
        end if;
    end process;
    button_3_pressed_process : process(keyboard_digit_3) begin
        if keyboard_digit_3 /= 0 then
            button_3_pressed <= '1';
        else 
            button_3_pressed <= '0';
        end if;
    end process;
    button_4_pressed_process : process(keyboard_digit_4) begin
        if keyboard_digit_4 /= 0 then
            button_4_pressed <= '1';
        else
            button_4_pressed <= '0';
        end if;
    end process;
    button_5_pressed_process : process(keyboard_digit_5) begin
        if keyboard_digit_5 /= 0 then
            button_5_pressed <= '1';
        else 
            button_5_pressed <= '0';
        end if;
    end process;
    
    fsm_seq : process(sys_clk, resetn) begin
        -- dafault operations
        present_state <= present_state;
        if resetn = '0' then
            -- reset operations
            present_state <= wait_state;
        elsif rising_edge(sys_clk) then 
            present_state <= future_state;
        end if;
    end process;
    
    fsm_future_state : process(present_state, button_1_pressed, button_2_pressed, button_3_pressed, button_4_pressed, button_5_pressed,
                        button_1_saved_FF, button_2_saved_FF, button_3_saved_FF, button_4_saved_FF, button_5_saved_FF) begin
        future_state <= present_state;
        case present_state is
            when wait_state =>
                if button_1_pressed = '1' then
                    if  button_1_saved_FF = '0' then
                        future_state <= state_1;
                    end if;
                end if;
                if button_2_pressed = '1' then
                    if button_2_saved_FF = '0' then
                        future_state <= state_2;
                    end if;
                end if;
                if button_3_pressed = '1' then
                    if button_3_saved_FF = '0' then
                        future_state <= state_3;
                    end if;
                end if;
                if button_4_pressed = '1' then
                    if button_4_saved_FF = '0' then
                        future_state <= state_4;
                    end if;
                end if;
                if button_5_pressed = '1' then
                    if button_5_saved_FF = '0' then
                        future_state <= state_5;
                    end if;
                end if;
            when state_1 => 
                if keyboard_digit_1 = 17 then -- upArrow
                    future_state <= decRow_cursor_state;
                elsif keyboard_digit_1 = 18 then -- downArrow
                    future_state <= incRow_cursor_state;
                elsif keyboard_digit_1 = 19 then -- leftArrow
                    future_state <= dec_cursor_state;
                elsif keyboard_digit_1 = 20 then -- rightArrow
                    future_state <= inc_cursor_state;
                elsif keyboard_digit_1 = 127 then -- delete
                    future_state <= DEL_cursor_state;
                elsif keyboard_digit_1 = 10 then -- enter
                    future_state <= enter_cursor_state;
                else
                    future_state <= inc_cursor_state;
                end if;
            when state_2 =>
                if keyboard_digit_2 = 17 then -- upArrow
                    future_state <= decRow_cursor_state;
                elsif keyboard_digit_2 = 18 then -- downArrow
                    future_state <= incRow_cursor_state;
                elsif keyboard_digit_2 = 19 then -- leftArrow
                    future_state <= dec_cursor_state;
                elsif keyboard_digit_2 = 20 then -- rightArrow
                    future_state <= inc_cursor_state;
                elsif keyboard_digit_2 = 127 then -- delete
                    future_state <= DEL_cursor_state;
                elsif keyboard_digit_2 = 10 then -- enter
                    future_state <= enter_cursor_state;
                else
                    future_state <= inc_cursor_state;
                end if;
            when state_3 =>
                if keyboard_digit_3 = 17 then -- upArrow
                    future_state <= decRow_cursor_state;
                elsif keyboard_digit_3 = 18 then -- downArrow
                    future_state <= incRow_cursor_state;
                elsif keyboard_digit_3 = 19 then -- leftArrow
                    future_state <= dec_cursor_state;
                elsif keyboard_digit_3 = 20 then -- rightArrow
                     future_state <= inc_cursor_state;
                elsif keyboard_digit_3 = 127 then -- delete
                    future_state <= DEL_cursor_state;
                elsif keyboard_digit_3 = 10 then -- enter
                    future_state <= enter_cursor_state;
                else
                    future_state <= inc_cursor_state;
                end if;
            when state_4 =>
                if keyboard_digit_4 = 17 then -- upArrow
                    future_state <= decRow_cursor_state;
                elsif keyboard_digit_4 = 18 then -- downArrow
                    future_state <= incRow_cursor_state;
                elsif keyboard_digit_4 = 19 then -- leftArrow
                    future_state <= dec_cursor_state;
                elsif keyboard_digit_4 = 20 then -- rightArrow
                    future_state <= inc_cursor_state;
                elsif keyboard_digit_4 = 127 then -- delete
                     future_state <= DEL_cursor_state;
                elsif keyboard_digit_4 = 10 then -- enter
                    future_state <= enter_cursor_state;
                else
                    future_state <= inc_cursor_state;
                end if;
            when state_5 =>
                if keyboard_digit_5 = 17 then -- upArrow
                    future_state <= decRow_cursor_state;
                elsif keyboard_digit_5 = 18 then -- downArrow
                    future_state <= incRow_cursor_state;
                elsif keyboard_digit_5 = 19 then -- leftArrow
                    future_state <= dec_cursor_state;
                elsif keyboard_digit_5 = 20 then -- rightArrow
                    future_state <= inc_cursor_state;
                elsif keyboard_digit_5 = 127 then -- delete
                    future_state <= DEL_cursor_state;
                elsif keyboard_digit_5 = 10 then -- enter
                    future_state <= enter_cursor_state;
                else
                    future_state <= inc_cursor_state;
                end if;
            when inc_cursor_state =>
                future_state <= wait_state;
            when dec_cursor_state =>
                future_state <= wait_state;
            when incRow_cursor_state =>
                future_state <= wait_state;
            when decRow_cursor_state =>
                future_state <= wait_state;
            when enter_cursor_state =>
                future_state <= wait_state;
            when DEL_cursor_state =>
                future_state <= wait_state;
        end case;
    end process;
    
    fsm_output : process(present_state) begin
        char_to_write <= (others => '0');
        button_1_saved_FF <= button_1_saved_FF;
        button_2_saved_FF <= button_2_saved_FF;
        button_3_saved_FF <= button_3_saved_FF;
        button_4_saved_FF <= button_4_saved_FF;
        button_5_saved_FF <= button_5_saved_FF;
        cursor_rel_pos <= cursor_rel_pos;
        frame_start_addr <= frame_start_addr;
        missing_characters_at_end_of_line <= missing_characters_at_end_of_line;
        
        if rising_edge(sys_clk) then
            if resetn = '0' then
                cursor_rel_pos <= 0;
                frame_start_addr <= 0;
            else
                case present_state is
                    when wait_state =>
                        if button_1_pressed = '0' then button_1_saved_FF <= '0'; end if;
                        if button_2_pressed = '0' then button_2_saved_FF <= '0'; end if;
                        if button_3_pressed = '0' then button_3_saved_FF <= '0'; end if;
                        if button_4_pressed = '0' then button_4_saved_FF <= '0'; end if;
                        if button_5_pressed = '0' then button_5_saved_FF <= '0'; end if;
                        
                    when state_1 =>
                        button_1_saved_FF <= '1';
                        if keyboard_digit_1 /= 17 and keyboard_digit_1 /= 18 and keyboard_digit_1 /= 19 and keyboard_digit_1 /= 20 and keyboard_digit_1 /= 127 and keyboard_digit_1 /= 10 then
                            char_to_write <= std_logic_vector(to_unsigned(keyboard_digit_1,7));
                        end if;
                        
                    when state_2 =>
                        button_2_saved_FF <= '1';
                        if keyboard_digit_2 /= 17 and keyboard_digit_2 /= 18 and keyboard_digit_2 /= 19 and keyboard_digit_2 /= 20 and keyboard_digit_2 /= 127 and keyboard_digit_2 /= 10 then
                            char_to_write <= std_logic_vector(to_unsigned(keyboard_digit_2,7));
                        end if;
                        
                    when state_3 =>
                        button_3_saved_FF <= '1';
                        if keyboard_digit_3 /= 17 and keyboard_digit_3 /= 18 and keyboard_digit_3 /= 19 and keyboard_digit_3 /= 20 and keyboard_digit_3 /= 127 and keyboard_digit_3 /= 10 then
                            char_to_write <= std_logic_vector(to_unsigned(keyboard_digit_3,7));
                        end if;
                        
                    when state_4 =>
                        button_4_saved_FF <= '1';
                        if keyboard_digit_4 /= 17 and keyboard_digit_4 /= 18 and keyboard_digit_4 /= 19 and keyboard_digit_4 /= 20 and keyboard_digit_4 /= 127 and keyboard_digit_4 /= 10 then
                            char_to_write <= std_logic_vector(to_unsigned(keyboard_digit_4,7));
                        end if;
                        
                    when state_5 =>
                        button_5_saved_FF <= '1';
                        if keyboard_digit_5 /= 17 and keyboard_digit_5 /= 18 and keyboard_digit_5 /= 19 and keyboard_digit_5 /= 20 and keyboard_digit_5 /= 127 and keyboard_digit_5 /= 10 then
                            char_to_write <= std_logic_vector(to_unsigned(keyboard_digit_5,7));
                        end if;
                        
                    when inc_cursor_state =>
                        if cursor_rel_pos = NUMBER_OF_CHARS_IN_A_FRAME - 1 then
                            if cursor_pos_abs /= MAX_CURSOR_VAL - 1 then
                                frame_start_addr <= frame_start_addr + HORIZONTAL_CHARS;
                                cursor_rel_pos <= NUMBER_OF_CHARS_IN_A_FRAME - HORIZONTAL_CHARS;
                                missing_characters_at_end_of_line <= 79;
                            end if;
                        else
                            cursor_rel_pos <= cursor_rel_pos + 1;  
                            missing_characters_at_end_of_line <= missing_characters_at_end_of_line - 1;
                            if missing_characters_at_end_of_line = 0 then
                                missing_characters_at_end_of_line <= 79;
                            end if;
                        end if;
                        
                    when dec_cursor_state =>
                        if cursor_rel_pos = 0 then
                            if frame_start_addr /= 0 then
                                frame_start_addr <= frame_start_addr - HORIZONTAL_CHARS;
                                cursor_rel_pos <= HORIZONTAL_CHARS - 1;
                                missing_characters_at_end_of_line <= 0;
                            end if;                 
                        else
                            cursor_rel_pos <= cursor_rel_pos - 1;
                            missing_characters_at_end_of_line <= missing_characters_at_end_of_line + 1;
                            if missing_characters_at_end_of_line = 79 then
                                missing_characters_at_end_of_line <= 0;
                            end if;
                        end if;
                        
                    when incRow_cursor_state =>
                        if cursor_rel_pos >= NUMBER_OF_CHARS_IN_A_FRAME - HORIZONTAL_CHARS then
                            if cursor_pos_abs < MAX_CURSOR_VAL - HORIZONTAL_CHARS then
                                frame_start_addr <= frame_start_addr + HORIZONTAL_CHARS;
                            end if;
                        else
                            cursor_rel_pos <= cursor_rel_pos + HORIZONTAL_CHARS;
                        end if;
                        
                    when decRow_cursor_state =>
                        if cursor_rel_pos < HORIZONTAL_CHARS then
                            if frame_start_addr /= 0 then
                                frame_start_addr <= frame_start_addr - HORIZONTAL_CHARS;
                            end if;
                        else
                            cursor_rel_pos <= cursor_rel_pos - HORIZONTAL_CHARS;
                        end if;
                    
                    when enter_cursor_state =>
                        missing_characters_at_end_of_line <= 79;
                        if cursor_rel_pos >= NUMBER_OF_CHARS_IN_A_FRAME - HORIZONTAL_CHARS then
                            if cursor_pos_abs < MAX_CURSOR_VAL - HORIZONTAL_CHARS then
                                cursor_rel_pos <= NUMBER_OF_CHARS_IN_A_FRAME - HORIZONTAL_CHARS;
                                frame_start_addr <= frame_start_addr + HORIZONTAL_CHARS;
                            end if;
                        else
                            cursor_rel_pos <= cursor_rel_pos + missing_characters_at_end_of_line + 1;
                        end if;
                    when DEL_cursor_state =>
                        if cursor_rel_pos = 0 then
                            if frame_start_addr /= 0 then
                                frame_start_addr <= frame_start_addr - HORIZONTAL_CHARS;
                                cursor_rel_pos <= HORIZONTAL_CHARS - 1;
                                missing_characters_at_end_of_line <= 0;
                            end if;                 
                        else
                            cursor_rel_pos <= cursor_rel_pos - 1;
                            missing_characters_at_end_of_line <= missing_characters_at_end_of_line + 1;
                            if missing_characters_at_end_of_line = 79 then
                                missing_characters_at_end_of_line <= 0;
                            end if;
                        end if;
                        char_to_write <= std_logic_vector(to_unsigned(32,7));
                end case;
            end if;
        end if;
    end process;
   
    
    blink_counter_proc : process(resetn) begin
        cursor_blink_time <= cursor_blink_time;
        if rising_edge(sys_clk) then
            if resetn = '0' then
                cursor_blink_time <= '1';
                blink_counter <= 0;
            else
                blink_counter <= blink_counter + 1;
                if blink_counter = 14999999 then
                    cursor_blink_time <= '1';
                elsif blink_counter = 29999999 then
                    cursor_blink_time <= '0';
                    blink_counter <= 0;
                end if;
            end if;
        end if;
    end process;
    
    cursor_pos_abs <= frame_start_addr + cursor_rel_pos;
     

end Behavioral;
