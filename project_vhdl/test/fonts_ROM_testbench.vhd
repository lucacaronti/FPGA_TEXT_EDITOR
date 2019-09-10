----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/21/2019 03:25:33 PM
-- Design Name: 
-- Module Name: fonts_ROM_testbench - Behavioral
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

entity fonts_ROM_testbench is
--  Port ( );
end fonts_ROM_testbench;

architecture Behavioral of fonts_ROM_testbench is
    signal CLK100HZ,CPU_RESETN: STD_LOGIC;
    signal address: STD_LOGIC_VECTOR(FONTS_ROM_ADDRESS_WIDTH-1 DOWNTO 0) := (others =>'0');
    signal data_out: STD_LOGIC_VECTOR(FONTS_ROM_DATA_WIDTH-1 DOWNTO 0) := (others =>'0');
    component fonts_ROM is 
    port(
        clk		    : in	STD_LOGIC;
		addr		: in	STD_LOGIC_VECTOR(FONTS_ROM_ADDRESS_WIDTH-1 downto 0);		-- input address
		data_out	: out	STD_LOGIC_VECTOR(FONTS_ROM_DATA_WIDTH-1 downto 0)		-- value of the address
    );
    end component fonts_ROM;
begin
    f_rom: fonts_ROM port map(
        clk => CLK100HZ,
        addr => address,
        data_out => data_out
    );
    CLK:process begin
        CLK100HZ <= '0';
        wait for 5ns;
        CLK100HZ <= '1';
        wait for 5ns;
    end process;
    
    process begin
        CPU_RESETN <= '0';
        wait for 15ns;
        CPU_RESETN <= '1';
        wait;
    end process;
    process begin
        wait for 20 ns;
        address <= std_logic_vector(to_unsigned(34,7)) & std_logic_vector(to_unsigned(0,4)); 
        wait for 10 ns;
        address <= std_logic_vector(to_unsigned(35,7)) & std_logic_vector(to_unsigned(0,4));
        wait for 10 ns;
        address <= std_logic_vector(to_unsigned(36,7)) & std_logic_vector(to_unsigned(0,4));

        wait;
    end process;

end Behavioral;

