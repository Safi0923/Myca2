----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/31/2023 12:03:27 PM
-- Design Name: 
-- Module Name: leds_mux - behavioral
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

entity sevenseg_mux is
    port (A, B, C, D, E, F : in std_logic_vector(3 downto 0);
          S : in std_logic_vector (2 downto 0);
          Num_Out : out std_logic_vector(3 downto 0);
          Cathode_Out : out std_logic_vector(5 downto 0));
end sevenseg_mux;

architecture behavioral  of sevenseg_mux is
begin
process (A, B, C, D, E, F, S)
begin
    if (S = "000") then
    Num_Out <= A;
    Cathode_Out <= "000001";
    elsif (S = "001") then
    Num_Out <= B;
    Cathode_Out <= "000010";
    elsif (S = "010") then
    Num_Out <= C;
    Cathode_Out <= "000100";
    elsif (S = "011") then
    Num_Out <= D;
    Cathode_Out <= "001000";
    elsif (S = "100") then
    Num_Out <= E;
    Cathode_Out <= "010000";
    else
    Num_Out <= F;
    Cathode_Out <= "100000";
    end if;
end process;
end behavioral ;