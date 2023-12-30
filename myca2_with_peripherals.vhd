----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/30/2023 02:26:57 PM
-- Design Name: 
-- Module Name: myca2_with_peripherals - behavioral
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

entity myca2_with_peripherals is
    port (clk,clr: in std_logic;
          i0,i1,i2,i3,i4,i5,i6,i7 : in std_logic;
          Q: out std_logic_vector(7 downto 0);
          o0,o1,o2,o3,o4,o5,o6,o7 : out std_logic);
end myca2_with_peripherals;

architecture structural of myca2_with_peripherals is

component myca2_controller
    port (clk,clr,flag: in std_logic;
          opcode: in std_logic_vector(2 downto 0);
          braddr, jaddr: in std_logic_vector(7 downto 0);
          Q: out std_logic_vector(7 downto 0));
          
end component;

component varmux is
    port(i0,i1,i2,i3,i4,i5,i6,i7 : in std_logic;
         varmux   : in std_logic_vector(2 downto 0);
         o   : out std_logic);
end component;

component ROM is
    port(A : in std_logic_vector(7 downto 0);
         D   : out std_logic_vector(21 downto 0));
 end component;

signal A_1, braddr_1: std_logic_vector(7 downto 0);
signal flag_1: std_logic;
signal varmux_1, opcode_1: std_logic_vector(2 downto 0);

begin

D1 : varmux port map(i0 => i0, i1 => i1, i2 => i2, i3 => i3, i4 => i4, i5 => i5, i6 => i6, i7 => i7, varmux => varmux_1, o => flag_1);
D2 : myca2_controller port map(clk => clk, clr => clr, flag => flag_1, opcode => opcode_1, braddr => braddr_1, jaddr => "00000000", Q => A_1);
D3 : ROM port map(A => A_1, D(0) => o0, D(1) => o1, D(2) => o2, D(3) => o3, D(4) => o4, D(5) => o5, D(6) => o6, D(7) => o7,
                  D(15 downto 8) => braddr_1, D(18 downto 16) => varmux_1, D(21 downto 19) => opcode_1);

Q <= A_1;
end structural;
