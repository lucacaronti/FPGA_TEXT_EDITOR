----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/01/2019 09:17:06 PM
-- Design Name: 
-- Module Name: testbench_pixel_stream - Behavioral
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
entity testbench_pixel_stream is
--  Port ( );
end testbench_pixel_stream;

 architecture Behavioral of testbench_pixel_stream is
    component clk_wiz_0 is 
    port(
        clk_in : in STD_LOGIC;
        resetn  : in STD_LOGIC;
        CLK_VGA : out STD_LOGIC
    );
    end component;
    component image_generator is 
    Port ( 
           clk              : in STD_LOGIC;
           resetn           : in STD_LOGIC;
           disp_en          : in STD_LOGIC;
           pixel_col        : in INTEGER;
           pixel_row        : in INTEGER;
           cursor_rel_pos       : in INTEGER; --distance from start of the stream of the cursor
           stream_out_char  : in STD_LOGIC_VECTOR (BITS_ADDRESSING_ALPHABET-1 DOWNTO 0); --char value outputted from stream
           stream_start_addr: in STD_LOGIC_VECTOR (STREAM_ADDRESS_WIDTH-1 DOWNTO 0);
           VGA_R            : out STD_LOGIC_VECTOR(3 DOWNTO 0);
           VGA_G            : out STD_LOGIC_VECTOR(3 DOWNTO 0);
           VGA_B            : out STD_LOGIC_VECTOR(3 DOWNTO 0);
           req_char_addr    : out STD_LOGIC_VECTOR(STREAM_ADDRESS_WIDTH -1 DOWNTO 0);
           req_char_addr_en  : out STD_LOGIC
     );
    end component;
    component vga_controller is 
    generic(
		h_pulse 		: INTEGER 	:=96;		
		h_bkprch		: INTEGER	:=48;		
		h_pixels		: INTEGER	:=640;		
		h_frprch		: INTEGER	:=16;		
		h_pol			: STD_LOGIC	:='0';		

		v_pulse 		: INTEGER 	:=2;		
		v_bkprch		: INTEGER	:=33;		
		v_pixels		: INTEGER	:=480;		
		v_frprch		: INTEGER	:=10;		
		v_pol			: STD_LOGIC	:='1'		
        );
    port(
        pixel_clk   : in STD_LOGIC;
        res         : in STD_LOGIC;
        h_sync      : out STD_LOGIC;
        v_sync      : out STD_LOGIC;
        disp_en     : out STD_LOGIC;
        column      : out INTEGER;
        row         : out INTEGER
    );
    end component;
    component stream is 
     port(
        sys_clk                   : in std_logic;
        resetn                    : in std_logic;
        input_char_value          : in std_logic_vector(BITS_ADDRESSING_ALPHABET - 1 downto 0);
        request_char_address      : in std_logic_vector(17 downto 0);
        request_char_address_en   : in std_logic;
        set_cursor_pos            : in integer;
        output_char_value         : out std_logic_vector(BITS_ADDRESSING_ALPHABET - 1 downto 0);
        cursor_rel_pos                : out integer
    );
   end component;
   
    signal CLK100HZ,CPU_RESETN,VGA_HS,VGA_VS,CLK_25,disp_en ,req_char_addr_en: STD_LOGIC;
    signal column,row,set_cursor_pos,cursor_rel_pos : INTEGER;
    signal VGA_R,VGA_G,VGA_B : STD_LOGIC_VECTOR (3 DOWNTO 0);
    signal req_char_addr : STD_LOGIC_VECTOR(17 downto 0);
    signal output_char_value : std_logic_vector(BITS_ADDRESSING_ALPHABET - 1 downto 0);
    signal input_char:std_logic_vector(BITS_ADDRESSING_ALPHABET - 1 downto 0);
    signal stream_start_addr: STD_LOGIC_VECTOR (STREAM_ADDRESS_WIDTH-1 DOWNTO 0):=(others => '0');
begin
    clk_wiz: clk_wiz_0 port map(
        clk_in => CLK100HZ,
        resetn  => CPU_RESETN,
        CLK_VGA =>CLK_25
    );
    vga_c: vga_controller port map(
        pixel_clk   => CLK_25,
        res         => CPU_RESETN,
        h_sync      => VGA_HS,
        v_sync      => VGA_VS,
        disp_en     => disp_en,
        column      => column,
        row         => row
    );
    st: stream port map(
        sys_clk => CLK100HZ,
        resetn => CPU_RESETN,
        input_char_value => input_char,
        request_char_address => req_char_addr,
        request_char_address_en => req_char_addr_en,
        set_cursor_pos => set_cursor_pos,
        output_char_value=> output_char_value,
        cursor_rel_pos => cursor_rel_pos
    );
    px_ctrl: image_generator port map(
       clk => CLK100HZ,             
       resetn => CPU_RESETN,         
       disp_en => disp_en,        
       pixel_col => column,      
       pixel_row => row,      
       cursor_rel_pos => cursor_rel_pos,     
       stream_out_char =>output_char_value,
       stream_start_addr => stream_start_addr,
       VGA_R => VGA_R,           
       VGA_G => VGA_G,          
       VGA_B => VGA_B,          
       req_char_addr => req_char_addr,  
       req_char_addr_en =>req_char_addr_en
    );

    
    CLK:process begin
        CLK100HZ <= '0';
        wait for 5ns;
        CLK100HZ <= '1';
        wait for 5ns;
    end process;
    
    process begin
        CPU_RESETN <= '0';
        set_cursor_pos <= 0;
        input_char <= (others => '0');
        wait for 30ns;
        CPU_RESETN <= '1';
        wait for 100 ns;
        
        for row in 65 to 125 loop
            wait for 20 ns;
                input_char <= std_logic_vector(to_unsigned(row,BITS_ADDRESSING_ALPHABET));
            for col in 15 to 93 loop 
                wait for 20 ns;
                input_char <= std_logic_vector(to_unsigned(col,BITS_ADDRESSING_ALPHABET));
            end loop;
            wait for 20 ns;
                input_char <= std_logic_vector(to_unsigned(127,BITS_ADDRESSING_ALPHABET));
        end loop;
        wait;
    end process;

end Behavioral;
