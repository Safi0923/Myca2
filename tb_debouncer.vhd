----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/22/2024 03:38:42 PM
-- Design Name: 
-- Module Name: tb_debouncer - Behavioral
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

entity tb_debouncer is
end tb_debouncer;

architecture tb of tb_debouncer is

COMPONENT Debouncer
    Generic (count_width : integer := 17);
	Port ( clk : in  STD_LOGIC;
          button : in  STD_LOGIC;
          debounced : out  STD_LOGIC);
    END COMPONENT;
signal Clk : std_logic := '0';
signal Input : std_logic := '0';
signal Output : std_logic;
constant clk_period : time := 10 ns;	-- 100MHz
begin
uut: Debouncer PORT MAP (
          clk => clk,
          button => Input,
         debounced => Output
        );
clk_process :process
   begin
		Clk <= '1';
		wait for clk_period/2;
		Clk <= '0';
		wait for clk_period/2;
   end process;
  stimulus_process: process
   begin		
   
        Input <= '0';
        wait for 200 ns;        
        Input <= '1';
        wait for 2000 ns;
        Input <= '0';	
        wait for 2000 ns;        
        Input <= '1';
        wait for 1400000 ns;
        Input <= '0';    
        wait;
      
   end process;
end tb;