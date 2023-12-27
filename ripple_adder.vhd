----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/25/2023 11:02:52 PM
-- Design Name: 
-- Module Name: ripple_adder - Behavioral
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

entity ripple_adder is
    generic( WIDTH : positive := 4);
    port( CIN : in std_logic;
          A, B: in std_logic_vector(WIDTH-1 downto 0);
          SUM : out std_logic_vector(WIDTH-1 downto 0);
          COUT: out std_logic);
    end ripple_adder;
architecture structural of ripple_adder is

    component full_adder
        port( A, B, CIN: in std_logic;
          SUM, COUT: out std_logic);
    end component;

signal carry: std_logic_vector(WIDTH downto 0);

begin
carry(0) <= CIN;
reg: for i in 0 to WIDTH-1 generate
    FA : full_adder
    port map (
    A => A(i),
    B => B(i),
    CIN =>carry(i),
    SUM =>SUM(i),
    COUT =>carry(i+1)
);
end generate;

COUT <= carry(WIDTH);

end structural;