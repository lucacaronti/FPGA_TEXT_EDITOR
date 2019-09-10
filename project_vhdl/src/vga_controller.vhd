----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.05.2019 20:47:27
-- Design Name: 
-- Module Name: vga_controller - Behavioral
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

entity vga_controller is
    generic(
		h_pulse 		: INTEGER 	:=96;		--horizontal sync pulse in pixels
		h_bkprch		: INTEGER	:=48;		--horizontal back porch width in pixels
		h_pixels		: INTEGER	:=HORIZONTAL_PIXELS;		--horizontal display width in pixels
		h_frprch		: INTEGER	:=16;		--horizontal front porch width in pixels
		h_pol			: STD_LOGIC	:='0';		--horizontal sync pulse polarity (1= positive, 0= negative)

		v_pulse 		: INTEGER 	:=2;		--vertical sync pulse in pixels
		v_bkprch		: INTEGER	:=33;		--vertical back porch width in pixels
		v_pixels		: INTEGER	:=VERTICAL_PIXELS;		--vertical display width in pixels
		v_frprch		: INTEGER	:=10;		--vertical front porch width in pixels
		v_pol			: STD_LOGIC	:='0'		--vertical sync pulse polarity (1= positive, 0= negative)
        );
	port(
		pixel_clk		    : IN	STD_LOGIC;		--pixel clock frequency in function of VGA mode used 
		res			        : IN 	STD_LOGIC;		--active low async reset	
		h_sync			    : OUT	STD_LOGIC;		--horizontal sync pulse
		v_sync			    : OUT	STD_LOGIC;		--vertical sync pulse
		horizontal_active	: OUT 	STD_LOGIC;
		vertical_active		: OUT 	STD_LOGIC;
		disp_en			    : OUT 	STD_LOGIC		--display enable ('1'= display time, '0'= blanking time)
	    );
end vga_controller;

architecture Behavioral of vga_controller is
	CONSTANT h_period	: INTEGER := h_pixels + h_bkprch + h_pulse + h_frprch;	--total number of pixels cloks in a row
	CONSTANT v_period	: INTEGER := v_pixels + v_bkprch + v_pulse + V_frprch;	--total number of rows in colums
    signal H_active, V_active : STD_LOGIC;
   
    
    signal init_H_count : std_logic;
    signal CE_H         : std_logic;
    signal TC_H         : std_logic;
    signal h_counter    : integer range 0 to h_period - 1;
    
    signal init_V_count : std_logic;
    signal CE_V         : std_logic;
    signal TC_V         : std_logic;
    signal v_counter    : integer range 0 to v_period - 1;
    
begin

    disp_en <= H_active AND V_active;
    horizontal_active <= H_active;
    vertical_active <= V_active;
    
	process (pixel_clk, res) begin
        
            
		if (res = '0') then	    --if reset is enabled
			
			init_H_count <= '1';
			init_V_count <= '1';
			
			h_sync	  <= NOT H_pol;	--start from non pulsing state
			v_sync	  <= NOT V_pol;	--start from non pulsing state
			H_active  <='0';
		elsif (rising_edge(pixel_clk)) then
            init_H_count <= '0';
            init_V_count <= '0';
            CE_V <= '0';
            
            CE_H <= '1';
            if h_counter = h_period - 2 then
                CE_V <= '1';
            end if;

			--horizontal sync signals
			if ((h_counter < (h_pixels + h_frprch)) OR (h_counter >= (h_pixels + h_frprch + h_pulse))) then
				h_sync <= NOT h_pol;	--the horizzontal sync signal is not pulsing
			else
				h_sync <= h_pol;		--the horizzontal sync signal is pulsing
			end if;

			--vertical sync signals
			if ((v_counter < (v_pixels + v_frprch)) OR (v_counter >= (v_pixels + v_frprch + v_pulse))) then
			    v_sync <= NOT v_pol;	--the horizzontal sync signal is not pulsing
			else
				v_sync <= v_pol;		--the horizzontal sync signal is pulsing
			end if;
            
			--set display enable output
			if (h_counter < h_pixels) then 	--display time
				H_active <= '1';		--enable display, beeing a signal it will be displayed at the h_pixels or v_picxels count (note the less non equal)
			else								--blanking time 
				H_active <= '0';		--disable display
			end if;
			
			if (v_counter < v_pixels) then 	--display time
				V_active <= '1';		--enable display, beeing a signal it will be displayed at the h_pixels or v_picxels count (note the less non equal)
			else								--blanking time 
				V_active <= '0';		--disable display
			end if;
		end if;
	end process;


    COUNT_H: entity work.counter(Behavioral)
    generic map(
        MAX         => h_period - 1,
        INIT_VALUE  => 0,
        INCREASE_BY => 1
    )
    port map(
        clk      => pixel_clk,
        resetn   => res,
        INIT     => init_H_count,
        CE       => CE_H,
        TC       => TC_H,
        value    => h_counter
    );
    
    COUNT_V: entity work.counter(Behavioral)
    generic map(
        MAX         => v_period - 1,
        INIT_VALUE  => 0,
        INCREASE_BY => 1
    )
    port map(
        clk      => pixel_clk,
        resetn   => res,
        INIT     => init_V_count,
        CE       => CE_v,
        TC       => TC_v,
        value    => v_counter
    );

end Behavioral;
