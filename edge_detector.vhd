----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/01/2024 08:10:44 PM
-- Design Name: 
-- Module Name: edge_detector - behavioral
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

entity EdgeDetector is
Port ( Clk : in STD_LOGIC;
InputSignal : in STD_LOGIC;
Edge : out STD_LOGIC);
end EdgeDetector;

architecture behavioral of EdgeDetector is
signal reg_0 : STD_LOGIC;
signal reg_1 : STD_LOGIC;   
     
begin
process(clk)
begin
if(rising_edge(clk)) then
    reg_0 <= reg_1;
    reg_1 <= InputSignal;
end if;
end process;
Edge <= (not reg_0) and reg_1;

end Behavioral;
