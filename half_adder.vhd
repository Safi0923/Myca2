----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/25/2023 08:46:34 PM
-- Design Name: 
-- Module Name: half_adder - Behavioral
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

entity half_adder is
    port( A : in std_logic;
          B : in std_logic;
          SUM : out std_logic;
          CARRY : out std_logic);
end half_adder;

architecture structural of half_adder is

    component and_2
        port ( in1,in2: in std_logic;
               and_out: out std_logic);
    end component;
    
    component xor_2 is
        port (in1,in2: in std_logic;
              xor_out: out std_logic);
    end component;
    
    begin
        U1: and_2 port map (in1 => A, in2 => B, and_out => CARRY);
        U2: xor_2 port map (in1 => A, in2 => B, xor_out => SUM);
end structural;