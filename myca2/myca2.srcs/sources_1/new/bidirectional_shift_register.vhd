----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/26/2023 09:43:51 PM
-- Design Name: 
-- Module Name: bidirectional_shift_register - behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bidirectional_shift_register is
    port (clk,clr,l,r: in std_logic;
          D: in std_logic_vector(3 downto 0);
          S: in std_logic_vector(1 downto 0);
          Q: out std_logic_vector(3 downto 0));
end bidirectional_shift_register;

architecture behavioral of bidirectional_shift_register is
  signal zero : unsigned(3 downto 0) := (others=>'0');
  begin
    process (CLK)
      variable temp : unsigned(3 downto 0) := (others=>'0');
      begin
        if rising_edge(CLK) then
            if (clr = '1') then
                temp := zero;
            elsif (S = "00") then
                temp := temp;
            elsif (S = "01") then
                if (r = '0') then
                    temp := '0' & temp(2 downto 0);
                else
                    temp := '1' & temp(2 downto 0);
                end if;
            elsif (S="10") then
                if (l = '0') then
                    temp := temp(3 downto 1) & '0';
                else
                    temp := temp(3 downto 1) & '1';
                end if;
            else
                temp:=unsigned(D);
            end if;
        end if;    
      Q <= std_logic_vector(temp);
    end process;
        
end behavioral;