----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/30/2023 12:19:38 PM
-- Design Name: 
-- Module Name: ROM - behavioral
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

entity ROM is
    port(A : in std_logic_vector(7 downto 0);
         D   : out std_logic_vector(21 downto 0));
end ROM;

--varmux decides the input to the Myca-2 Top--
--input is chosen as per the algorithm--
--so varmux value is decided as per the input--

architecture behavioral of ROM is
constant ignore: std_logic_vector(7 downto 0):="--------";
begin
process(A)
begin
case A is
    when x"00" => D <= "000" & "000" & ignore & "00000001"; 
    when x"01" => D <= "000" & "001" & ignore & "00000010"; 
    when x"02" => D <= "100" & "111" & x"00" & "00000000";
    when x"03" => D <= "101" & "110" & x"06" & "00000000"; 
    when x"04" => D <= "000" & "100" & ignore & "00000100"; 
    when x"05" => D <= "011" & "---" & x"00" & "00001000"; 
    when x"06" => D <= "000" & "010" & ignore & "00010000";
    when x"07" => D <= "010" & "---" & ignore & "00100000";
    when x"08" => D <= "000" & "011" & ignore & "00000000";
    when x"09" => D <= "110" & "---" & x"04" & "00000000";
    when others => D <= "000" & "---" & ignore & "00000001";  

end case;
end process;
end behavioral;
