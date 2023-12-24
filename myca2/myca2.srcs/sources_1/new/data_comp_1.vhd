----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/24/2023 03:31:56 PM
-- Design Name: 
-- Module Name: data_comp_1 - Behavioral
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

entity data_comp_1 is
    port (altbin,aeqbin,agtbin: in std_logic;
          a,b: in std_logic;
          altbout,aeqbout,agtbout: out std_logic);
end data_comp_1;

architecture structural of data_comp_1 is

component and_2 is
  port (in1,in2: in std_logic;
          and_out: out std_logic);
end component;

component xor_2 is
  port (in1,in2: in std_logic;
          xor_out: out std_logic);
end component;

component or_2 is
  port (in1,in2: in std_logic;
          or_out: out std_logic);
end component;

signal p: std_logic;
signal not_b: std_logic:=not b;
signal q: std_logic;
signal not_a: std_logic:=not a;
signal r: std_logic;
signal s: std_logic;
signal t: std_logic;
signal u: std_logic;
signal v: std_logic;
signal w: std_logic;

begin
d1 : xor_2
    port map (
        in1 => a,
        in2 => b,
        xor_out => p
    );
d2 : and_2
    port map (
        in1 => a,
        in2 => not_b,
        and_out => q
    );
d3 : and_2
    port map (
        in1 => not_a,
        in2 => b,
        and_out => r
    );
d4 : and_2
    port map (
        in1 => p,
        in2 => altbin,
        and_out => s
    );
d5 : and_2
    port map (
        in1 => p,
        in2 => aeqbin,
        and_out => aeqbout
    );
d6 : and_2
    port map (
        in1 => p,
        in2 => agtbin,
        and_out => u
    );
d7 : or_2
    port map (
        in1 => q,
        in2 => u,
        or_out => agtbout
    );
d8 : or_2
    port map (
        in1 => r,
        in2 => s,
        or_out => altbout
    );    

end structural;
