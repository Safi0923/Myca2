----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/26/2023 10:30:43 PM
-- Design Name: 
-- Module Name: stack - behavioral
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

entity stack is
    port (clk,clr: in std_logic;
          S: in std_logic_vector(1 downto 0);
          A: in std_logic_vector(3 downto 0);
          Q: out std_logic_vector(3 downto 0));
end stack;

architecture behavioral of stack is

    component bidirectional_shift_register is
        port (clk,clr,l,r: in std_logic;
              D0,D1,D2,D3: in std_logic;
              S: in std_logic_vector(1 downto 0);
              Q0,Q1,Q2,Q3: out std_logic);
    end component;

    signal p1,q1,s1 : std_logic_vector(3 downto 0);

begin
reg: for i in 0 to 3 generate
    DC : bidirectional_shift_register
    port map(
        clk => clk,
        clr => clr,
        S  => S,
        D0 => p1(i),
        l => p1(i),
        Q0 => p1(i),
        D1 => q1(i),
        r => A(i),
        D3 => A(i),
        D2 => s1(i),
        Q2 => s1(i), 
        Q1 => q1(i),
        Q3 => Q(i)  
        );
end generate;
end behavioral;
