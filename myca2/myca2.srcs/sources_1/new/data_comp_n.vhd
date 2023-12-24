----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/24/2023 04:18:24 PM
-- Design Name: 
-- Module Name: data_comp_n - Behavioral
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

entity data_comp_n is
    generic(WIDTH : positive :=4);
    port (ALTBIN,AEQBIN,AGTBIN: in std_logic:='1';
          A,B: in std_logic_vector(WIDTH-1 downto 0);
          ALTBOUT,AEQBOUT,AGTBOUT: out std_logic);
end data_comp_n;

architecture structural of data_comp_n is

component data_comp_1 is
  port (altbin,aeqbin,agtbin: in std_logic;
          a,b: in std_logic;
          altbout,aeqbout,agtbout: out std_logic);
end component;

signal carry_1 : std_logic_vector(WIDTH downto 0);
signal carry_2 : std_logic_vector(WIDTH downto 0);
signal carry_3 : std_logic_vector(WIDTH downto 0);

begin
carry_1(0) <= altbin;
carry_2(0) <= aeqbin;
carry_3(0) <= agtbin;

reg: for i in 0 to WIDTH-1 generate
    DC : data_comp_1
    port map(
        a => A(i),
        b => B(i),
        altbin  => carry_1(i),
        aeqbin  => carry_2(i),
        agtbin  => carry_3(i),
        altbout => carry_1(i+1),
        aeqbout => carry_2(i+1),
        agtbout => carry_3(i+1)
        );
end generate;

ALTBOUT <= carry_1(WIDTH); 
AEQBOUT <= carry_2(WIDTH);
AGTBOUT <= carry_3(WIDTH);

end structural;