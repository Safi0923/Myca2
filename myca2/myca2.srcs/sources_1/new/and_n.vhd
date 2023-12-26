----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/26/2023 10:39:56 AM
-- Design Name: 
-- Module Name: and_n - Behavioral
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

entity and_n is
    generic(WIDTH : positive :=4);
    port (in1, in2: in std_logic_vector(WIDTH-1 downto 0);
        outp:  out std_logic);
end entity;

architecture structural of and_n is

    component and_2 is
        port (in1,in2: in std_logic;
              and_out: out std_logic);
    end component;

    signal temp: std_logic_vector(WIDTH downto 0);
    
begin
    temp(0) <= in1(0);
    reg: for i in 0 to WIDTH-1 generate
    FA : and_2
    port map (
    in1 => temp(i),
    in2 => in2(i),
    and_out => temp(i+1)
);
end generate;

outp <= temp(WIDTH);
    
end structural;