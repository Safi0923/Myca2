----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/28/2023 12:20:57 AM
-- Design Name: 
-- Module Name: opcode_decoder - behavioral
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

entity opcode_decoder is
    port (deco_in_flag: in std_logic;
          deco_in_opcode: in std_logic_vector(2 downto 0);
          deco_out_cin,deco_out4_en,deco_out5_ld: out std_logic;
          deco_out2_stack : out std_logic_vector(1 downto 0);
          deco_out3_mux: out std_logic_vector(1 downto 0));
end opcode_decoder;

architecture behavioral of opcode_decoder is
signal p : std_logic_vector(3 downto 0);
signal q : std_logic_vector(6 downto 0);
begin
process(deco_in_flag,deco_in_opcode)
begin
p <= deco_in_opcode & deco_in_flag;
case p is
    when "0000" => q <= "0000000";
    when "0001" => q <= "1000000";
    when "0010" => q <= "0000000";
    when "0011" => q <= "0100000";
    when "0100" => q <= "1000000";
    when "0101" => q <= "1000000";
    when "0110" => q <= "0100000";
    when "0111" => q <= "0100000";
    when "1000" => q <= "1000000";
    when "1001" => q <= "0100000";
    when "1010" => q <= "1000000";
    when "1011" => q <= "0100011";
    when "1100" => q <= "0100000";
    when "1101" => q <= "0110100";
    when "1110" => q <= "1000000";
    when "1111" => q <= "0101011";
    
end case;
deco_out_cin <= q(0);
deco_out4_en <= q(6);
deco_out5_ld <= q(5);
deco_out2_stack <= q(2 downto 1);
deco_out3_mux <= q(4 downto 3);
end process;
end behavioral;
