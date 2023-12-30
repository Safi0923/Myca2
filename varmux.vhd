----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/30/2023 12:12:54 PM
-- Design Name: 
-- Module Name: varmux - behavioral
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

entity varmux is
    port(i0,i1,i2,i3,i4,i5,i6,i7 : in std_logic;
         varmux   : in std_logic_vector(2 downto 0);
         o   : out std_logic);
end varmux;

architecture behavioral of varmux is

begin
with varmux select
o <= i0 when "000",
     i1 when "001",
     i2 when "010",
     i3 when "011",
     i4 when "100",
     i5 when "101",
     i6 when "110",
     i7 when "111";

end behavioral;
