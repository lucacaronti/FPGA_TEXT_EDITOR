----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.05.2019 20:06:49
-- Design Name: 
-- Module Name: testbench - Behavioral
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

entity testbench is
--  Port ( );
end testbench;

architecture Behavioral of testbench is 
    signal CLK100MHZ, CPU_RESETN, VGA_HS, VGA_VS : std_logic;
    signal VGA_R, VGA_B, VGA_G : std_logic_vector(3 downto 0);
begin
    top_l : entity work.top_level port map(
        CLK100MHz => CLK100MHZ,
        CPU_RESETN => CPU_RESETN,
        VGA_HS => VGA_HS,
        VGA_VS => VGA_VS,
        VGA_R => VGA_R,
        VGA_B => VGA_B,
        VGA_G => VGA_G);
    process begin
        CLK100MHz <= '0';
        wait for 5 ns;
        CLK100MHz <= '1';
        wait for 5 ns;
    end process;
    
    process begin
        CPU_RESETN<='0';
        wait for 10 ns;
        CPU_RESETN<='1';
        wait;
    end process;
end Behavioral;
