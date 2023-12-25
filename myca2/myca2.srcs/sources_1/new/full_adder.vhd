----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/25/2023 08:54:24 PM
-- Design Name: 
-- Module Name: full_adder - Behavioral
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

entity full_adder is
    port( A, B, CIN: in std_logic;
          SUM, COUT: out std_logic);
end full_adder;

architecture structural of full_adder is

    component half_adder
        port( A : in std_logic;
          B : in std_logic;
          SUM : out std_logic;
          CARRY : out std_logic);
    end component;
    
    component or_2 is
        port (in1,in2: in std_logic;
              or_out: out std_logic);
    end component;

signal SIG1, SIG2, SIG3: std_logic;

begin
        U1: half_adder port map (A => A, B => B, SUM => SIG1, CARRY => SIG2);
        U2: half_adder port map (A => SIG1, B => CIN, SUM => SUM, CARRY => SIG3);
        U3: or_2 port map (in1 => SIG2, in2 => SIG3, or_out => COUT);
end structural;