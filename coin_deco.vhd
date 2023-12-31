----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/12/2023 03:52:01 PM
-- Design Name: 
-- Module Name: coin_deco - Behavioral
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

entity coin_deco is
    Port (COIN_IN : in STD_LOGIC_VECTOR(1 downto 0);
           DECO_OUT : out  STD_LOGIC_VECTOR (3 downto 0));
end coin_deco;

architecture Behavioral of coin_deco is

begin
 with COIN_IN select
    DECO_OUT <=  "0001" when "00",
                 "0010" when "01",
                 "0100" when "10",
                 "1010" when "11",
                 "0000" when others;

end Behavioral;
