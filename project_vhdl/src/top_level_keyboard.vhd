----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.05.2019 16:26:27
-- Design Name: 
-- Module Name: top_level - Behavioral
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

entity top_level_keyboard is
    port (
        PS2_CLK : in std_logic;
        PS2_DATA : in std_logic;
        clock : in std_logic;
        resetn : in std_logic;
        CA, CB, CC, CD, CE, CF, CG, DP : out std_logic;
        AN : out std_logic_vector( 7 downto 0 );
        keyboard_digit_1, keyboard_digit_2, keyboard_digit_3, keyboard_digit_4, keyboard_digit_5 : buffer integer range 0 to 255
    );
end top_level_keyboard;

architecture Behavioral of top_level_keyboard is
    signal digit0, digit1,digit2, digit3, digit4, digit5, digit6, digit7 : std_logic_vector(3 downto 0);
    signal arrived_data : std_logic_vector(7 downto 0);
    signal button_out_1, button_out_2, button_out_3, button_out_4, button_out_5 : std_logic_vector(7 downto 0);
    signal new_data, shift_out, capsLock_en : std_logic;
    signal button1_ascii, button2_ascii, button3_ascii, button4_ascii, button5_ascii : integer range 0 to 255 ;
    signal button1_ascii_bit, button2_ascii_bit, button3_ascii_bit, button4_ascii_bit, button5_ascii_bit : std_logic_vector(7 downto 0);
    
    constant button_a : std_logic_vector(7 downto 0) := "00011100";
    constant button_b : std_logic_vector(7 downto 0) := "00110010";
    constant button_c : std_logic_vector(7 downto 0) := "00100001";
    constant button_d : std_logic_vector(7 downto 0) := "00100011";
    constant button_e : std_logic_vector(7 downto 0) := "00100100";
    constant button_f : std_logic_vector(7 downto 0) := "00101011";
    constant button_g : std_logic_vector(7 downto 0) := "00110100";    
    constant button_h : std_logic_vector(7 downto 0) := "00110011";    
    constant button_i : std_logic_vector(7 downto 0) := "01000011";    
    constant button_j : std_logic_vector(7 downto 0) := "00111011";    
    constant button_k : std_logic_vector(7 downto 0) := "01000010";    
    constant button_l : std_logic_vector(7 downto 0) := "01001011";    
    constant button_m : std_logic_vector(7 downto 0) := "00111010";    
    constant button_n : std_logic_vector(7 downto 0) := "00110001";    
    constant button_o : std_logic_vector(7 downto 0) := "01000100";    
    constant button_p : std_logic_vector(7 downto 0) := "01001101";    
    constant button_q : std_logic_vector(7 downto 0) := "00010101";    
    constant button_r : std_logic_vector(7 downto 0) := "00101101";    
    constant button_s : std_logic_vector(7 downto 0) := "00011011";    
    constant button_t : std_logic_vector(7 downto 0) := "00101100";    
    constant button_u : std_logic_vector(7 downto 0) := "00111100";    
    constant button_v : std_logic_vector(7 downto 0) := "00101010";    
    constant button_w : std_logic_vector(7 downto 0) := "00011101";    
    constant button_x : std_logic_vector(7 downto 0) := "00100010";    
    constant button_y : std_logic_vector(7 downto 0) := "00110101";    
    constant button_z : std_logic_vector(7 downto 0) := "00011010";  
      
    constant button_0 : std_logic_vector(7 downto 0) := "01000101";    
    constant button_1 : std_logic_vector(7 downto 0) := "00010110";  
    constant button_2 : std_logic_vector(7 downto 0) := "00011110";    
    constant button_3 : std_logic_vector(7 downto 0) := "00100110";    
    constant button_4 : std_logic_vector(7 downto 0) := "00100101";    
    constant button_5 : std_logic_vector(7 downto 0) := "00101110";    
    constant button_6 : std_logic_vector(7 downto 0) := "00110110";    
    constant button_7 : std_logic_vector(7 downto 0) := "00111101";    
    constant button_8 : std_logic_vector(7 downto 0) := "00111110";    
    constant button_9 : std_logic_vector(7 downto 0) := "01000110";   
    
    constant button_space : std_logic_vector(7 downto 0) := "00101001";   
    constant button_tab : std_logic_vector(7 downto 0) := "00001101";   
    constant button_ctrl : std_logic_vector(7 downto 0) := "00010100";   
    constant button_alt : std_logic_vector(7 downto 0) := "00010001";   
    constant button_capsLock : std_logic_vector(7 downto 0) := "01011000";   
    constant button_enter : std_logic_vector(7 downto 0) := "01011010";   
    constant button_backSpace : std_logic_vector(7 downto 0) := "01100110";   
    
    constant button_special0 : std_logic_vector(7 downto 0) := "00001110";   -- `~
    constant button_special1 : std_logic_vector(7 downto 0) := "01001110";   -- -_
    constant button_special2 : std_logic_vector(7 downto 0) := "01010101";   -- =+
    constant button_special3 : std_logic_vector(7 downto 0) := "01010100";   -- [{
    constant button_special4 : std_logic_vector(7 downto 0) := "01011011";   -- ]}
    constant button_special5 : std_logic_vector(7 downto 0) := "01001100";   -- ;:
    constant button_special6 : std_logic_vector(7 downto 0) := "01010010";   -- '"
    constant button_special7 : std_logic_vector(7 downto 0) := "01000001";   --,<
    constant button_special8 : std_logic_vector(7 downto 0) := "01001001";   -- .>
    constant button_special9 : std_logic_vector(7 downto 0) := "01001010";   -- /?
    
    constant button_leftArrow   : std_logic_vector(7 downto 0) := "01101011"; 
    constant button_rightArrow  : std_logic_vector(7 downto 0) := "01110100"; 
    constant button_upArrow     : std_logic_vector(7 downto 0) := "01110101"; 
    constant button_downArrow   : std_logic_vector(7 downto 0) := "01110010"; 
     
     
    
    
begin
    displayDriver : entity work.seven_segment_driver(Behavioral) 
    generic map( size => 21)
    port map(
        clock => clock,
        reset => resetn,
        digit0 => digit0, 
        digit1 => digit1, 
        digit2 => digit2, 
        digit3 => digit3, 
        digit4 => digit4, 
        digit5 => digit5, 
        digit6 => digit6,
        digit7 => digit7,  
        CA => CA, CB => CB, CC => CC, CD => CD, CE => CE, CF => CF, CG => CG, DP => DP,
        AN => AN
    );

    driverKeyboard : entity work.driver_keyboard(Behavioral)
    port map(
        PS2_CLK => PS2_CLK,
        PS2_DATA => PS2_DATA,
        clock => clock,
        data_out => arrived_data,
        new_data => new_data,
        global_reset => resetn
    );
    
    fsmKeyboard : entity work.fsm_keyboard(Behavioral)
    port map(
        clk => clock,
        button_out_1 => button_out_1,
        button_out_2 => button_out_2,
        button_out_3 => button_out_3,
        button_out_4 => button_out_4,
        button_out_5 => button_out_5,
        shift_out => shift_out,
        capsLock_en => capsLock_en,
        data_in => arrived_data,
        new_data => new_data,
        resetn => resetn
    );
    
     new_button_1_pressed : process(button_out_1)
        variable shift_offset : integer := 0;
     begin
        if shift_out = '1' or capsLock_en = '1' then
            shift_offset := 32;
        else
            shift_offset := 0;
        end if;
       
        case button_out_1 is
            when button_a =>
                button1_ascii <= 97 - shift_offset;
            when button_b =>
                button1_ascii <= 98 - shift_offset;
            when button_c =>
                button1_ascii <= 99 - shift_offset;
            when button_d =>
                button1_ascii <= 100 - shift_offset;
            when button_e =>
                button1_ascii <= 101 - shift_offset;
            when button_f =>
                button1_ascii <= 102 - shift_offset;
            when button_g =>
                button1_ascii <= 103 - shift_offset;
            when button_h =>
                button1_ascii <= 104 - shift_offset;
            when button_i =>
                button1_ascii <= 105 - shift_offset;
            when button_j =>
                button1_ascii <= 106 - shift_offset;
            when button_k =>
                button1_ascii <= 107 - shift_offset;
            when button_l =>
                button1_ascii <= 108 - shift_offset;
            when button_m =>
                button1_ascii <= 109 - shift_offset;
            when button_n =>
                button1_ascii <= 110 - shift_offset;
            when button_o =>
                button1_ascii <= 111 - shift_offset;
            when button_p =>
                button1_ascii <= 112 - shift_offset;
            when button_q =>
                button1_ascii <= 113 - shift_offset;
            when button_r =>
                button1_ascii <= 114 - shift_offset;
            when button_s =>
                button1_ascii <= 115 - shift_offset;
            when button_t =>
                button1_ascii <= 116 - shift_offset;
            when button_u =>
                button1_ascii <= 117 - shift_offset;
            when button_v =>
                button1_ascii <= 118 - shift_offset;
            when button_w =>
                button1_ascii <= 119 - shift_offset;
            when button_x =>
                button1_ascii <= 120 - shift_offset;
            when button_y =>
                button1_ascii <= 121 - shift_offset;
            when button_z =>
                button1_ascii <= 122 - shift_offset;
            when button_0 =>
                if shift_out = '0' then button1_ascii <= 48;
                else button1_ascii <= 41; -- )
                end if;                
            when button_1 =>
                if shift_out = '0' then button1_ascii <= 49;
                else button1_ascii <= 33; -- !
                end if;  
            when button_2 =>
                if shift_out = '0' then button1_ascii <= 50;
                else button1_ascii <= 64; -- @
                end if;  
            when button_3 =>
                if shift_out = '0' then button1_ascii <= 51;
                else button1_ascii <= 35; -- # 
                end if;  
            when button_4 =>
                if shift_out = '0' then button1_ascii <= 52;
                else button1_ascii <= 36; -- $
                end if;  
            when button_5 =>
                if shift_out = '0' then button1_ascii <= 53;
                else button1_ascii <= 37; -- %
                end if;  
            when button_6 =>
                if shift_out = '0' then button1_ascii <= 54;
                else button1_ascii <= 94; -- ^
                end if;  
            when button_7 =>
                if shift_out = '0' then button1_ascii <= 55;
                else button1_ascii <= 38; -- &
                end if;  
            when button_8 =>
                if shift_out = '0' then button1_ascii <= 56;
                else button1_ascii <= 42; -- *
                end if;  
            when button_9 =>
                if shift_out = '0' then button1_ascii <= 57;
                else button1_ascii <= 40; -- (
                end if;  
            when button_space =>
                button1_ascii <= 32;
            when button_tab =>
                button1_ascii <= 9; -- set as /t
            when button_ctrl =>
                button1_ascii <= 0;
            when button_alt =>
                button1_ascii <= 0;
            when button_enter =>
                button1_ascii <= 10; -- set as /n
            when button_backSpace =>
                button1_ascii <= 127;
            when button_special0 =>
                if shift_out = '1' then button1_ascii <= 126; -- `
                else button1_ascii <= 96; -- ~
                end if;
            when button_special1 =>
                if shift_out = '1' then button1_ascii <= 95; -- _
                else button1_ascii <= 45; -- -
                end if;
            when button_special2 =>
                if shift_out = '1' then button1_ascii <= 43; -- +
                else button1_ascii <= 61; -- =
                end if;
            when button_special3 =>
                if shift_out = '1' then button1_ascii <= 123; -- {
                else button1_ascii <= 91; -- [
                end if;
            when button_special4 =>
                if shift_out = '1' then button1_ascii <= 125; -- {
                else button1_ascii <= 93; -- ]
                end if;
            when button_special5 =>
                if shift_out = '1' then button1_ascii <= 58; -- :
                else button1_ascii <= 59; -- ;
                end if;
            when button_special6 =>
                if shift_out = '1' then button1_ascii <= 34; -- "
                else button1_ascii <= 39; -- '
                end if;
            when button_special7 =>
                if shift_out = '1' then button1_ascii <= 60; -- <
                else button1_ascii <= 44; -- ,
                end if;
            when button_special8 =>
                if shift_out = '1' then button1_ascii <= 62; -- >
                else button1_ascii <= 46; -- .
                end if;
            when button_special9 =>
                if shift_out = '1' then button1_ascii <= 63; -- ?
                else button1_ascii <= 47; -- /
                end if;
            when button_upArrow =>        
                button1_ascii <= 17; -- ascii 17 -> "Device Control 1" -> decrease cursor by 80
            when button_downArrow =>
                button1_ascii <= 18; -- ascii 18 -> "Device Control 2" -> increase cursor by 80
            when button_leftArrow =>
                button1_ascii <= 19; -- ascii 19 -> "Device Control 3" -> decrease cursor by 1
            when button_rightArrow =>
                button1_ascii <= 20; -- ascii 20 -> "Device Control 4" -> increase cursor by 1
            when others =>
                
                button1_ascii <= 0;
        end case;
     end process; 
     
     new_button_2_pressed : process(button_out_2)
        variable shift_offset : integer := 0;
     begin
        if shift_out = '1' or capsLock_en = '1' then
            shift_offset := 32;
        else
            shift_offset := 0;
        end if;
        
        case button_out_2 is
            when button_a =>
                button2_ascii <= 97 - shift_offset;
            when button_b =>
                button2_ascii <= 98 - shift_offset;
            when button_c =>
                button2_ascii <= 99 - shift_offset;
            when button_d =>
                button2_ascii <= 100 - shift_offset;
            when button_e =>
                button2_ascii <= 101 - shift_offset;
            when button_f =>
                button2_ascii <= 102 - shift_offset;
            when button_g =>
                button2_ascii <= 103 - shift_offset;
            when button_h =>
                button2_ascii <= 104 - shift_offset;
            when button_i =>
                button2_ascii <= 105 - shift_offset;
            when button_j =>
                button2_ascii <= 106 - shift_offset;
            when button_k =>
                button2_ascii <= 107 - shift_offset;
            when button_l =>
                button2_ascii <= 108 - shift_offset;
            when button_m =>
                button2_ascii <= 109 - shift_offset;
            when button_n =>
                button2_ascii <= 110 - shift_offset;
            when button_o =>
                button2_ascii <= 111 - shift_offset;
            when button_p =>
                button2_ascii <= 112 - shift_offset;
            when button_q =>
                button2_ascii <= 113 - shift_offset;
            when button_r =>
                button2_ascii <= 114 - shift_offset;
            when button_s =>
                button2_ascii <= 115 - shift_offset;
            when button_t =>
                button2_ascii <= 116 - shift_offset;
            when button_u =>
                button2_ascii <= 117 - shift_offset;
            when button_v =>
                button2_ascii <= 118 - shift_offset;
            when button_w =>
                button2_ascii <= 119 - shift_offset;
            when button_x =>
                button2_ascii <= 120 - shift_offset;
            when button_y =>
                button2_ascii <= 121 - shift_offset;
            when button_z =>
                button2_ascii <= 122 - shift_offset;
            when button_0 =>
                if shift_out = '0' then button2_ascii <= 48;
                else button2_ascii <= 41; -- )
                end if;                
            when button_1 =>
                if shift_out = '0' then button2_ascii <= 49;
                else button2_ascii <= 33; -- !
                end if;  
            when button_2 =>
                if shift_out = '0' then button2_ascii <= 50;
                else button2_ascii <= 64; -- @
                end if;  
            when button_3 =>
                if shift_out = '0' then button2_ascii <= 51;
                else button2_ascii <= 35; -- # 
                end if;  
            when button_4 =>
                if shift_out = '0' then button2_ascii <= 52;
                else button2_ascii <= 36; -- $
                end if;  
            when button_5 =>
                if shift_out = '0' then button2_ascii <= 53;
                else button2_ascii <= 37; -- %
                end if;  
            when button_6 =>
                if shift_out = '0' then button2_ascii <= 54;
                else button2_ascii <= 94; -- ^
                end if;  
            when button_7 =>
                if shift_out = '0' then button2_ascii <= 55;
                else button2_ascii <= 38; -- &
                end if;  
            when button_8 =>
                if shift_out = '0' then button2_ascii <= 56;
                else button2_ascii <= 42; -- *
                end if;  
            when button_9 =>
                if shift_out = '0' then button2_ascii <= 57;
                else button2_ascii <= 40; -- (
                end if;  
            when button_space =>
                button2_ascii <= 32;
            when button_tab =>
                button2_ascii <= 9; -- set as /t
            when button_ctrl =>
                button2_ascii <= 0;
            when button_alt =>
                button2_ascii <= 0;
            when button_enter =>
                button2_ascii <= 10; -- set as /n
            when button_backSpace =>
                button2_ascii <= 127;
            when button_special0 =>
                if shift_out = '1' then button2_ascii <= 126; -- `
                else button2_ascii <= 96; -- ~
                end if;
            when button_special1 =>
                if shift_out = '1' then button2_ascii <= 95; -- _
                else button2_ascii <= 45; -- -
                end if;
            when button_special2 =>
                if shift_out = '1' then button2_ascii <= 43; -- +
                else button2_ascii <= 61; -- =
                end if;
            when button_special3 =>
                if shift_out = '1' then button2_ascii <= 123; -- {
                else button2_ascii <= 91; -- [
                end if;
            when button_special4 =>
                if shift_out = '1' then button2_ascii <= 125; -- {
                else button2_ascii <= 93; -- ]
                end if;
            when button_special5 =>
                if shift_out = '1' then button2_ascii <= 58; -- :
                else button2_ascii <= 59; -- ;
                end if;
            when button_special6 =>
                if shift_out = '1' then button2_ascii <= 34; -- "
                else button2_ascii <= 39; -- '
                end if;
            when button_special7 =>
                if shift_out = '1' then button2_ascii <= 60; -- <
                else button2_ascii <= 44; -- ,
                end if;
            when button_special8 =>
                if shift_out = '1' then button2_ascii <= 62; -- >
                else button2_ascii <= 46; -- .
                end if;
            when button_special9 =>
                if shift_out = '1' then button2_ascii <= 63; -- ?
                else button2_ascii <= 47; -- /
                end if;
            when button_upArrow =>        
                button2_ascii <= 17; -- ascii 17 -> "Device Control 1" -> decrease cursor by 60
            when button_downArrow =>
                button2_ascii <= 18; -- ascii 18 -> "Device Control 2" -> increase cursor by 60
            when button_leftArrow =>
                button2_ascii <= 19; -- ascii 19 -> "Device Control 3" -> decrease cursor by 1
            when button_rightArrow =>
                button2_ascii <= 20; -- ascii 20 -> "Device Control 4" -> increase cursor by 1
            when others =>
                button2_ascii <= 0;
        end case;
     end process; 
     
     new_button_3_pressed : process(button_out_3)
        variable shift_offset : integer := 0;
     begin
        if shift_out = '1' or capsLock_en = '1' then
            shift_offset := 32;
        else
            shift_offset := 0;
        end if;
        
        case button_out_3 is
            when button_a =>
                button3_ascii <= 97 - shift_offset;
            when button_b =>
                button3_ascii <= 98 - shift_offset;
            when button_c =>
                button3_ascii <= 99 - shift_offset;
            when button_d =>
                button3_ascii <= 100 - shift_offset;
            when button_e =>
                button3_ascii <= 101 - shift_offset;
            when button_f =>
                button3_ascii <= 102 - shift_offset;
            when button_g =>
                button3_ascii <= 103 - shift_offset;
            when button_h =>
                button3_ascii <= 104 - shift_offset;
            when button_i =>
                button3_ascii <= 105 - shift_offset;
            when button_j =>
                button3_ascii <= 106 - shift_offset;
            when button_k =>
                button3_ascii <= 107 - shift_offset;
            when button_l =>
                button3_ascii <= 108 - shift_offset;
            when button_m =>
                button3_ascii <= 109 - shift_offset;
            when button_n =>
                button3_ascii <= 110 - shift_offset;
            when button_o =>
                button3_ascii <= 111 - shift_offset;
            when button_p =>
                button3_ascii <= 112 - shift_offset;
            when button_q =>
                button3_ascii <= 113 - shift_offset;
            when button_r =>
                button3_ascii <= 114 - shift_offset;
            when button_s =>
                button3_ascii <= 115 - shift_offset;
            when button_t =>
                button3_ascii <= 116 - shift_offset;
            when button_u =>
                button3_ascii <= 117 - shift_offset;
            when button_v =>
                button3_ascii <= 118 - shift_offset;
            when button_w =>
                button3_ascii <= 119 - shift_offset;
            when button_x =>
                button3_ascii <= 120 - shift_offset;
            when button_y =>
                button3_ascii <= 121 - shift_offset;
            when button_z =>
                button3_ascii <= 122 - shift_offset;
            when button_0 =>
                if shift_out = '0' then button3_ascii <= 48;
                else button3_ascii <= 41; -- )
                end if;                
            when button_1 =>
                if shift_out = '0' then button3_ascii <= 49;
                else button3_ascii <= 33; -- !
                end if;  
            when button_2 =>
                if shift_out = '0' then button3_ascii <= 50;
                else button3_ascii <= 64; -- @
                end if;  
            when button_3 =>
                if shift_out = '0' then button3_ascii <= 51;
                else button3_ascii <= 35; -- # 
                end if;  
            when button_4 =>
                if shift_out = '0' then button3_ascii <= 52;
                else button3_ascii <= 36; -- $
                end if;  
            when button_5 =>
                if shift_out = '0' then button3_ascii <= 53;
                else button3_ascii <= 37; -- %
                end if;  
            when button_6 =>
                if shift_out = '0' then button3_ascii <= 54;
                else button3_ascii <= 94; -- ^
                end if;  
            when button_7 =>
                if shift_out = '0' then button3_ascii <= 55;
                else button3_ascii <= 38; -- &
                end if;  
            when button_8 =>
                if shift_out = '0' then button3_ascii <= 56;
                else button3_ascii <= 42; -- *
                end if;  
            when button_9 =>
                if shift_out = '0' then button3_ascii <= 57;
                else button3_ascii <= 40; -- (
                end if;  
            when button_space =>
                button3_ascii <= 32;
            when button_tab =>
                button3_ascii <= 9; -- set as /t
            when button_ctrl =>
                button3_ascii <= 0;
            when button_alt =>
                button3_ascii <= 0;
            when button_enter =>
                button3_ascii <= 10; -- set as /n
            when button_backSpace =>
                button3_ascii <= 127;
            when button_special0 =>
                if shift_out = '1' then button3_ascii <= 126; -- `
                else button3_ascii <= 96; -- ~
                end if;
            when button_special1 =>
                if shift_out = '1' then button3_ascii <= 95; -- _
                else button3_ascii <= 45; -- -
                end if;
            when button_special2 =>
                if shift_out = '1' then button3_ascii <= 43; -- +
                else button3_ascii <= 61; -- =
                end if;
            when button_special3 =>
                if shift_out = '1' then button3_ascii <= 123; -- {
                else button3_ascii <= 91; -- [
                end if;
            when button_special4 =>
                if shift_out = '1' then button3_ascii <= 125; -- {
                else button3_ascii <= 93; -- ]
                end if;
            when button_special5 =>
                if shift_out = '1' then button3_ascii <= 58; -- :
                else button3_ascii <= 59; -- ;
                end if;
            when button_special6 =>
                if shift_out = '1' then button3_ascii <= 34; -- "
                else button3_ascii <= 39; -- '
                end if;
            when button_special7 =>
                if shift_out = '1' then button3_ascii <= 60; -- <
                else button3_ascii <= 44; -- ,
                end if;
            when button_special8 =>
                if shift_out = '1' then button3_ascii <= 62; -- >
                else button3_ascii <= 46; -- .
                end if;
            when button_special9 =>
                if shift_out = '1' then button3_ascii <= 63; -- ?
                else button3_ascii <= 47; -- /
                end if;
            when button_upArrow =>        
                button3_ascii <= 17; -- ascii 17 -> "Device Control 1" -> decrease cursor by 60
            when button_downArrow =>
                button3_ascii <= 18; -- ascii 18 -> "Device Control 2" -> increase cursor by 60
            when button_leftArrow =>
                button3_ascii <= 19; -- ascii 19 -> "Device Control 3" -> decrease cursor by 1
            when button_rightArrow =>
                button3_ascii <= 20; -- ascii 20 -> "Device Control 4" -> increase cursor by 1
            when others =>
                button3_ascii <= 0;
        end case;
     end process; 
    
     new_button_4_pressed : process(button_out_4)
        variable shift_offset : integer := 0;
     begin
        if shift_out = '1' or capsLock_en = '1' then
            shift_offset := 32;
        else
            shift_offset := 0;
        end if;
        
        case button_out_4 is
            when button_a =>
                button4_ascii <= 97 - shift_offset;
            when button_b =>
                button4_ascii <= 98 - shift_offset;
            when button_c =>
                button4_ascii <= 99 - shift_offset;
            when button_d =>
                button4_ascii <= 100 - shift_offset;
            when button_e =>
                button4_ascii <= 101 - shift_offset;
            when button_f =>
                button4_ascii <= 102 - shift_offset;
            when button_g =>
                button4_ascii <= 103 - shift_offset;
            when button_h =>
                button4_ascii <= 104 - shift_offset;
            when button_i =>
                button4_ascii <= 105 - shift_offset;
            when button_j =>
                button4_ascii <= 106 - shift_offset;
            when button_k =>
                button4_ascii <= 107 - shift_offset;
            when button_l =>
                button4_ascii <= 108 - shift_offset;
            when button_m =>
                button4_ascii <= 109 - shift_offset;
            when button_n =>
                button4_ascii <= 110 - shift_offset;
            when button_o =>
                button4_ascii <= 111 - shift_offset;
            when button_p =>
                button4_ascii <= 112 - shift_offset;
            when button_q =>
                button4_ascii <= 113 - shift_offset;
            when button_r =>
                button4_ascii <= 114 - shift_offset;
            when button_s =>
                button4_ascii <= 115 - shift_offset;
            when button_t =>
                button4_ascii <= 116 - shift_offset;
            when button_u =>
                button4_ascii <= 117 - shift_offset;
            when button_v =>
                button4_ascii <= 118 - shift_offset;
            when button_w =>
                button4_ascii <= 119 - shift_offset;
            when button_x =>
                button4_ascii <= 120 - shift_offset;
            when button_y =>
                button4_ascii <= 121 - shift_offset;
            when button_z =>
                button4_ascii <= 122 - shift_offset;
            when button_0 =>
                if shift_out = '0' then button4_ascii <= 48;
                else button4_ascii <= 41; -- )
                end if;                
            when button_1 =>
                if shift_out = '0' then button4_ascii <= 49;
                else button4_ascii <= 33; -- !
                end if;  
            when button_2 =>
                if shift_out = '0' then button4_ascii <= 50;
                else button4_ascii <= 64; -- @
                end if;  
            when button_3 =>
                if shift_out = '0' then button4_ascii <= 51;
                else button4_ascii <= 35; -- # 
                end if;  
            when button_4 =>
                if shift_out = '0' then button4_ascii <= 52;
                else button4_ascii <= 36; -- $
                end if;  
            when button_5 =>
                if shift_out = '0' then button4_ascii <= 53;
                else button4_ascii <= 37; -- %
                end if;  
            when button_6 =>
                if shift_out = '0' then button4_ascii <= 54;
                else button4_ascii <= 94; -- ^
                end if;  
            when button_7 =>
                if shift_out = '0' then button4_ascii <= 55;
                else button4_ascii <= 38; -- &
                end if;  
            when button_8 =>
                if shift_out = '0' then button4_ascii <= 56;
                else button4_ascii <= 42; -- *
                end if;  
            when button_9 =>
                if shift_out = '0' then button4_ascii <= 57;
                else button4_ascii <= 40; -- (
                end if;  
            when button_space =>
                button4_ascii <= 32;
            when button_tab =>
                button4_ascii <= 9; -- set as /t
            when button_ctrl =>
                button4_ascii <= 0;
            when button_alt =>
                button4_ascii <= 0;
            when button_enter =>
                button4_ascii <= 10; -- set as /n
            when button_backSpace =>
                button4_ascii <= 127;
            when button_special0 =>
                if shift_out = '1' then button4_ascii <= 126; -- `
                else button4_ascii <= 96; -- ~
                end if;
            when button_special1 =>
                if shift_out = '1' then button4_ascii <= 95; -- _
                else button4_ascii <= 45; -- -
                end if;
            when button_special2 =>
                if shift_out = '1' then button4_ascii <= 43; -- +
                else button4_ascii <= 61; -- =
                end if;
            when button_special3 =>
                if shift_out = '1' then button4_ascii <= 123; -- {
                else button4_ascii <= 91; -- [
                end if;
            when button_special4 =>
                if shift_out = '1' then button4_ascii <= 125; -- {
                else button4_ascii <= 93; -- ]
                end if;
            when button_special5 =>
                if shift_out = '1' then button4_ascii <= 58; -- :
                else button4_ascii <= 59; -- ;
                end if;
            when button_special6 =>
                if shift_out = '1' then button4_ascii <= 34; -- "
                else button4_ascii <= 39; -- '
                end if;
            when button_special7 =>
                if shift_out = '1' then button4_ascii <= 60; -- <
                else button4_ascii <= 44; -- ,
                end if;
            when button_special8 =>
                if shift_out = '1' then button4_ascii <= 62; -- >
                else button4_ascii <= 46; -- .
                end if;
            when button_special9 =>
                if shift_out = '1' then button4_ascii <= 63; -- ?
                else button4_ascii <= 47; -- /
                end if;
            when button_upArrow =>        
                button4_ascii <= 17; -- ascii 17 -> "Device Control 1" -> decrease cursor by 60
            when button_downArrow =>
                button4_ascii <= 18; -- ascii 18 -> "Device Control 2" -> increase cursor by 60
            when button_leftArrow =>
                button4_ascii <= 19; -- ascii 19 -> "Device Control 3" -> decrease cursor by 1
            when button_rightArrow =>
                button4_ascii <= 20; -- ascii 20 -> "Device Control 4" -> increase cursor by 1
            when others =>
                button4_ascii <= 0;
        end case;
     end process; 
    
     new_button_5_pressed : process(button_out_5)
        variable shift_offset : integer := 0;
     begin
        if shift_out = '1' or capsLock_en = '1' then
            shift_offset := 32;
        else
            shift_offset := 0;
        end if;
        
        case button_out_5 is
            when button_a =>
                button5_ascii <= 97 - shift_offset;
            when button_b =>
                button5_ascii <= 98 - shift_offset;
            when button_c =>
                button5_ascii <= 99 - shift_offset;
            when button_d =>
                button5_ascii <= 100 - shift_offset;
            when button_e =>
                button5_ascii <= 101 - shift_offset;
            when button_f =>
                button5_ascii <= 102 - shift_offset;
            when button_g =>
                button5_ascii <= 103 - shift_offset;
            when button_h =>
                button5_ascii <= 104 - shift_offset;
            when button_i =>
                button5_ascii <= 105 - shift_offset;
            when button_j =>
                button5_ascii <= 106 - shift_offset;
            when button_k =>
                button5_ascii <= 107 - shift_offset;
            when button_l =>
                button5_ascii <= 108 - shift_offset;
            when button_m =>
                button5_ascii <= 109 - shift_offset;
            when button_n =>
                button5_ascii <= 110 - shift_offset;
            when button_o =>
                button5_ascii <= 111 - shift_offset;
            when button_p =>
                button5_ascii <= 112 - shift_offset;
            when button_q =>
                button5_ascii <= 113 - shift_offset;
            when button_r =>
                button5_ascii <= 114 - shift_offset;
            when button_s =>
                button5_ascii <= 115 - shift_offset;
            when button_t =>
                button5_ascii <= 116 - shift_offset;
            when button_u =>
                button5_ascii <= 117 - shift_offset;
            when button_v =>
                button5_ascii <= 118 - shift_offset;
            when button_w =>
                button5_ascii <= 119 - shift_offset;
            when button_x =>
                button5_ascii <= 120 - shift_offset;
            when button_y =>
                button5_ascii <= 121 - shift_offset;
            when button_z =>
                button5_ascii <= 122 - shift_offset;
            when button_0 =>
                if shift_out = '0' then button5_ascii <= 48;
                else button5_ascii <= 41; -- )
                end if;                
            when button_1 =>
                if shift_out = '0' then button5_ascii <= 49;
                else button5_ascii <= 33; -- !
                end if;  
            when button_2 =>
                if shift_out = '0' then button5_ascii <= 50;
                else button5_ascii <= 64; -- @
                end if;  
            when button_3 =>
                if shift_out = '0' then button5_ascii <= 51;
                else button5_ascii <= 35; -- # 
                end if;  
            when button_4 =>
                if shift_out = '0' then button5_ascii <= 52;
                else button5_ascii <= 36; -- $
                end if;  
            when button_5 =>
                if shift_out = '0' then button5_ascii <= 53;
                else button5_ascii <= 37; -- %
                end if;  
            when button_6 =>
                if shift_out = '0' then button5_ascii <= 54;
                else button5_ascii <= 94; -- ^
                end if;  
            when button_7 =>
                if shift_out = '0' then button5_ascii <= 55;
                else button5_ascii <= 38; -- &
                end if;  
            when button_8 =>
                if shift_out = '0' then button5_ascii <= 56;
                else button5_ascii <= 42; -- *
                end if;  
            when button_9 =>
                if shift_out = '0' then button5_ascii <= 57;
                else button5_ascii <= 40; -- (
                end if;  
            when button_space =>
                button5_ascii <= 32;
            when button_tab =>
                button5_ascii <= 9; -- set as /t
            when button_ctrl =>
                button5_ascii <= 0;
            when button_alt =>
                button5_ascii <= 0;
            when button_enter =>
                button5_ascii <= 10; -- set as /n
            when button_backSpace =>
                button5_ascii <= 127;
            when button_special0 =>
                if shift_out = '1' then button5_ascii <= 126; -- `
                else button5_ascii <= 96; -- ~
                end if;
            when button_special1 =>
                if shift_out = '1' then button5_ascii <= 95; -- _
                else button5_ascii <= 45; -- -
                end if;
            when button_special2 =>
                if shift_out = '1' then button5_ascii <= 43; -- +
                else button5_ascii <= 61; -- =
                end if;
            when button_special3 =>
                if shift_out = '1' then button5_ascii <= 123; -- {
                else button5_ascii <= 91; -- [
                end if;
            when button_special4 =>
                if shift_out = '1' then button5_ascii <= 125; -- {
                else button5_ascii <= 93; -- ]
                end if;
            when button_special5 =>
                if shift_out = '1' then button5_ascii <= 58; -- :
                else button5_ascii <= 59; -- ;
                end if;
            when button_special6 =>
                if shift_out = '1' then button5_ascii <= 34; -- "
                else button5_ascii <= 39; -- '
                end if;
            when button_special7 =>
                if shift_out = '1' then button5_ascii <= 60; -- <
                else button5_ascii <= 44; -- ,
                end if;
            when button_special8 =>
                if shift_out = '1' then button5_ascii <= 62; -- >
                else button5_ascii <= 46; -- .
                end if;
            when button_special9 =>
                if shift_out = '1' then button5_ascii <= 63; -- ?
                else button5_ascii <= 47; -- /
                end if;
            when button_upArrow =>        
                button5_ascii <= 17; -- ascii 17 -> "Device Control 1" -> decrease cursor by 60
            when button_downArrow =>
                button5_ascii <= 18; -- ascii 18 -> "Device Control 2" -> increase cursor by 60
            when button_leftArrow =>
                button5_ascii <= 19; -- ascii 19 -> "Device Control 3" -> decrease cursor by 1
            when button_rightArrow =>
                button5_ascii <= 20; -- ascii 20 -> "Device Control 4" -> increase cursor by 1
            when others =>
                button5_ascii <= 0;
        end case;
     end process; 
     
       
    button1_ascii_bit <= std_logic_vector(to_unsigned(button1_ascii, 8));
    button2_ascii_bit <= std_logic_vector(to_unsigned(button2_ascii, 8));
    button3_ascii_bit <= std_logic_vector(to_unsigned(button3_ascii, 8));
    button4_ascii_bit <= std_logic_vector(to_unsigned(button4_ascii, 8));
    button5_ascii_bit <= std_logic_vector(to_unsigned(button5_ascii, 8));

    digit0 <= button1_ascii_bit(3 downto 0);
    digit1 <= button1_ascii_bit(7 downto 4);
    digit2 <= button2_ascii_bit(3 downto 0);
    digit3 <= button2_ascii_bit(7 downto 4);
    digit4 <= button3_ascii_bit(3 downto 0);
    digit5 <= button3_ascii_bit(7 downto 4);
    digit6 <= button4_ascii_bit(3 downto 0);
    digit7 <= button4_ascii_bit(7 downto 4);
    
    push_keyboard_digit : process(clock) begin
        if rising_edge(clock) then
            keyboard_digit_1 <= button1_ascii;
            keyboard_digit_2 <= button2_ascii;
            keyboard_digit_3 <= button3_ascii;
            keyboard_digit_4 <= button4_ascii;
            keyboard_digit_5 <= button5_ascii;
        else 
            keyboard_digit_1 <= keyboard_digit_1;
            keyboard_digit_2 <= keyboard_digit_2;
            keyboard_digit_3 <= keyboard_digit_3;
            keyboard_digit_4 <= keyboard_digit_4;
            keyboard_digit_5 <= keyboard_digit_5;
        end if;
    end process;
    
end Behavioral;
