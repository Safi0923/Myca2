----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/22/2024 03:01:32 PM
-- Design Name: 
-- Module Name: debouncer - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Debouncer is
	Generic (count_width : integer := 17);
	Port ( clk : in  STD_LOGIC;
          button : in  STD_LOGIC;
          debounced : out  STD_LOGIC);
end Debouncer;

architecture structural of Debouncer is
    component synchronous_counter
        generic (
            WIDTH : positive := 4
        );
        port (  
            clk : in  STD_LOGIC;
           updwn, clr, ld, en : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
           Q : out  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           overflow : out  STD_LOGIC
        ); 
    end component;

	component EdgeDetector
		Port ( Clk : in STD_LOGIC;
			   InputSignal : in STD_LOGIC;
			   Edge : out STD_LOGIC);
	end component;
    
    signal not_button : STD_LOGIC := not(button);
	signal trigger : STD_LOGIC := '0';
	signal rise_edge, fall_edge : STD_LOGIC;
	signal count_enable : STD_LOGIC := '0';
	signal reset, d : STD_LOGIC := '0';
begin

    d1 : synchronous_counter
        generic map (
            WIDTH => count_width 
        )
        port map (
            CLK => clk,
            updwn => '1',
            clr => '0',
            ld => '0',
            en => count_enable,
            D => (others=>'0'),
            Q => open,
            overflow => trigger
        );

	d2 : EdgeDetector
	Port map ( Clk => clk,
		   InputSignal => button,
		   Edge => rise_edge
	);

	d3: EdgeDetector
	Port map ( Clk => clk,
		   InputSignal => not_button,
		   Edge => fall_edge
	);
	
	process(clk)
		begin
		if(reset='1') then
			count_enable <= '0';
		elsif(rising_edge(clk)) then
			if(rise_edge='1') then
				count_enable <='1';
			elsif(fall_edge='1') then
				count_enable <= '1';
			end if;
		end if;
	end process;

	process(clk)
		begin
		if(rising_edge(clk)) then
			if(trigger = '1') then
				d <= not(d);
				reset <= '1';
			elsif(trigger='0') then
				reset <= '0';
			end if;
		end if;
	end process;

	debounced <= d;
	
end structural;
