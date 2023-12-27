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
          D0,D1,D2,D3: in std_logic;
          S: in std_logic_vector(1 downto 0);
          Q0,Q1,Q2,Q3: out std_logic);
end bidirectional_shift_register;

architecture behavioral of bidirectional_shift_register is
  signal zero : std_logic := '0';
  signal one : std_logic := '1';
  begin
    process (CLK)
      variable temp0 : std_logic := '0';
      variable temp1 : std_logic := '0';
      variable temp2 : std_logic := '0';
      variable temp3 : std_logic := '0';
      begin
        if rising_edge(CLK) then
            if (clr = '1') then
                temp0 := zero;
                temp1 := zero;
                temp2 := zero;
                temp3 := zero;
            elsif (S = "00") then
                temp0 := temp0;
                temp1 := temp1;
                temp2 := temp2;
                temp3 := temp3;
            elsif (S = "01") then
                if (r = '0') then
                    temp3 := zero;
                    temp2 := temp2;
                    temp1 := temp1;
                    temp0 := temp0;
                else
                    temp3 := one;
                    temp2 := temp2;
                    temp1 := temp1;
                    temp0 := temp0;
                end if;
            elsif (S="10") then
                if (l = '0') then
                    temp3 := temp3;
                    temp2 := temp2;
                    temp1 := temp1;
                    temp0 := zero;
                else
                    temp3 := temp3;
                    temp2 := temp2;
                    temp1 := temp1;
                    temp0 := one;
                end if;
            else
                temp3 := D3;
                temp2 := D2;
                temp1 := D1;
                temp0 := D0;
            end if;
        end if;
      Q0 <= temp0;
      Q1 <= temp1;
      Q2 <= temp2;    
      Q3 <= temp3;
    end process;
        
end behavioral;