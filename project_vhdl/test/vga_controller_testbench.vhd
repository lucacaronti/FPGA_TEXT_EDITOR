----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/13/2019 07:47:24 PM
-- Design Name: 
-- Module Name: vga_controller_testbench - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
use work.commonPak.ALL;

entity vga_controller_testbench is
--  Port ( );
end vga_controller_testbench;

architecture Behavioral of vga_controller_testbench is

    signal CLK100MHZ, CPU_RESETN, VGA_HS, VGA_VS,CLK_25, H_active, V_active : std_logic;
    signal display_en_fut, vertical_active_fut, horizontal_active_fut : std_logic;
    signal display_en : std_logic;
    signal column,row : INTEGER;
    component clk_wiz_0 is port(
        clk_in : in std_logic;
        resetn   : in std_logic;
        CLK_VGA : out std_logic
    );
    end component;
begin
    vga_controller: entity work.vga_controller(Behavioral) 
    generic map (    
            h_pulse 		=> 96,
            h_bkprch		=> 48,
            h_pixels		=> HORIZONTAL_PIXELS,
            h_frprch		=> 16,
            h_pol			=> '0',
            
            v_pulse 		=> 2,
            v_bkprch		=>33,
            v_pixels		=> VERTICAL_PIXELS,
            v_frprch		=> 10,
            v_pol			=> '0'
    )
    port map(
--            pixel_clk => CLK_25,
--            res => CPU_RESETN,
--            h_sync => VGA_HS,
--            v_sync => VGA_VS,
--            disp_en => display_en    
        pixel_clk                       => CLK_25,
        res                             => CPU_RESETN,
        h_sync                          => VGA_HS,
        v_sync                          => VGA_VS,
        horizontal_active               => H_active,
        vertical_active                 => V_active,
        disp_en                         => display_en,
        disp_en_fut                     => display_en_fut,
	    vertical_active_fut             => vertical_active_fut,
		horizontal_active_fut           => horizontal_active_fut
     );
    clk_wiz: clk_wiz_0 port map(
        clk_in => CLK100MHz,
        resetn => CPU_RESETN,
        CLK_VGA => CLK_25
        );
    process begin
        CLK100MHz <= '0';
        wait for 5 ns;
        CLK100MHz <= '1';
        wait for 5 ns;
    end process;
    
    process begin
        CPU_RESETN<='0'; 
        wait for 15 ns;
        CPU_RESETN<='1';
        wait;
    end process;
end Behavioral;
