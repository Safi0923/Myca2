----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/26/2023 10:17:15 AM
-- Design Name: 
-- Module Name: mux_8_to_1 - Behavioral
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

entity mux_8_to_1 is
    generic(WIDTH : positive :=4);
    port(A,B,C,D,E,F,G,H : in std_logic_vector(WIDTH-1 downto 0);
         S   : in std_logic_vector(2 downto 0);
         O   : out std_logic_vector(WIDTH-1 downto 0));
end mux_8_to_1;

architecture behavioral of mux_8_to_1 is

begin
with S select
O <= A when "000",
     B when "001",
     C when "010",
     D when "011",
     E when "100",
     F when "101",
     G when "110",
     H when "111";

end behavioral;
