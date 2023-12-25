----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/25/2023 10:39:46 AM
-- Design Name: 
-- Module Name: logical_shift_n - Behavioral
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
use work.log_function.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity logical_shift_n is
    generic(WIDTH : positive :=8);
    port (A: in std_logic_vector(WIDTH-1 downto 0);
          S: in std_logic_vector(log2(WIDTH)-1 downto 0);
          D: out std_logic_vector(WIDTH-1 downto 0));
          type two_dim is array (0 to log2(WIDTH)-1) of std_logic_vector(WIDTH-1 downto 0);
end logical_shift_n;

architecture behavioral of logical_shift_n is

component mux is
  port(A,B : in std_logic_vector(WIDTH-1 downto 0);
         S   : in std_logic;
         O   : out std_logic_vector(WIDTH-1 downto 0));
end component;

signal D1 : two_dim :=(others=>(others=>'0'));
signal D0 : two_dim :=(others=>(others=>'0'));
signal Y : two_dim :=(others=>(others=>'0'));
begin
D0 <= A;
D1 <= A & '0';

reg: for i in 0 to log2(WIDTH) generate
    DC : mux
    port map(
        A => D0,
        B => D1,
        S => S(i),
        O  => Y
        );
end generate;

D <= Y; 

end behavioral;
