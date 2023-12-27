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
use IEEE.numeric_std.ALL;
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
end logical_shift_n;

architecture behavioral of logical_shift_n is
type two_dim is array (0 to log2(WIDTH)-1) of std_logic_vector(WIDTH-1 downto 0);

component mux is
generic(WIDTH : positive :=8);
  port(A,B : in std_logic_vector(WIDTH-1 downto 0);
         S   : in std_logic;
         O   : out std_logic_vector(WIDTH-1 downto 0));
end component;

signal D0 : std_logic_vector(((log2(WIDTH)+1)*WIDTH)-1 downto 0);
signal D1 : two_dim :=(others=>(others=>'0'));


begin

D0(WIDTH-1 downto 0) <= A;
D1(0) <= D0(WIDTH-2 downto 0) & '0';

reg: for i in 1 to log2(WIDTH) generate
    DC : mux
    port map(
        A => D0((i*WIDTH)-1 downto (i-1)*WIDTH),
        B => D1(i-1),
        S => S(i-1),
        O => D0((i+1)*WIDTH-1 downto (i)*WIDTH)
        );
end generate;

generate_D1: for i in 1 to log2(WIDTH)-1 generate
    D1(i) <= D0(((i+1)*WIDTH) -(2**i)-1 downto (i)*WIDTH) & std_logic_vector(to_unsigned(0,2**i));
end generate;

--D1(1) <= D0((1+1)*WIDTH-3 downto (1)*WIDTH) & "00";
--D1(2) <= D0((2+1)*WIDTH-5 downto (2)*WIDTH) & "0000";
--D1(3) <= D0((3+1)*WIDTH-9 downto (3)*WIDTH) & "00000000";

D <= D0((log2(WIDTH)+1)*WIDTH-1 downto log2(WIDTH)*WIDTH); 

end behavioral;
