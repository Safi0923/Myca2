----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/31/2023 03:19:00 PM
-- Design Name: 
-- Module Name: ripple_adder_wrapper - structural
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

entity ripple_adder_wrapper is
    generic(WIDTH : positive := 4);
    port(CLK,RST,EN,CIN: in std_logic;
        A,B: in  std_logic_vector(WIDTH-1 downto 0);
        SUM: out std_logic_vector(WIDTH-1 downto 0);
        COUT: out std_logic);
end ripple_adder_wrapper;

architecture structural of ripple_adder_wrapper is

component ripple_adder is
    generic( WIDTH : positive := 4);
    port( CIN : in std_logic;
          A, B: in std_logic_vector(WIDTH-1 downto 0);
          SUM : out std_logic_vector(WIDTH-1 downto 0);
          COUT: out std_logic);
end component;

signal synchronous_sum :  std_logic_vector(WIDTH-1 downto 0);
signal synchronous_sum_carry_out : std_logic;

begin

D1: ripple_adder
generic map (WIDTH => WIDTH)
port map(
        A => A, 
        B => B,
        CIN => CIN,
        SUM => synchronous_sum,
        COUT => synchronous_sum_carry_out);

process(clk)
begin
    if rising_edge(clk) then
        if rst = '1' then
            SUM <= (others=>'0');
            cout <= '0';
        else
            if en = '1' then
                SUM <= synchronous_sum;
                COUT <= synchronous_sum_carry_out;
            end if;
        end if;
    end if;
end process;

end structural;
