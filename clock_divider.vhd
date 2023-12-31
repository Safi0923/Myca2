----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/31/2023 02:10:34 PM
-- Design Name: 
-- Module Name: clock_divider - behavioral
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
use ieee.numeric_std.all;
use work.log_function.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_divider is
generic(
input_frequency : positive := 100000000;
refresh_frequency : positive := 1000
);
port (
clk : in std_logic;
rst : in std_logic;
clk_out : out std_logic_vector(2 downto 0));
end clock_divider;

architecture structural of clock_divider is

    component synchronous_counter
        Generic(WIDTH : positive := 8);
        Port (clk : in  STD_LOGIC;
           updwn, clr, ld, en : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
           Q : out  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           overflow : out  STD_LOGIC);
     end component;

    constant number_of_seven_segments : positive := 6;
    constant counter_limit_int : integer :=  input_frequency/(refresh_frequency*(number_of_seven_segments));
    constant counter_width: positive := log2(counter_limit_int);
    constant counter_limit_binary :      unsigned(counter_width-1 downto 0) :=  to_unsigned(counter_limit_int, counter_width);
    
    signal counter_refresh :    std_logic_vector(counter_width-1 downto 0) := (others => '0');
    signal counter_reset : std_logic := '0';
    signal next_counter_enable : std_logic := '0';
    signal selected_segment : std_logic_vector(2 downto 0) := (others => '0');
    
begin

    D1 : synchronous_counter
    generic map (
        WIDTH => counter_width
    )
    port map (
        CLK => clk,
        updwn => '1',
        clr => rst,
        ld => '0',
        en => '1',
        D => (others=>'0'),
        Q => counter_refresh,
        overflow => open
    );
    
counter_refresh_proc : process(clk, rst)
    begin 
        if(rst='1') then
            next_counter_enable <= '0';
            counter_reset <= '0';
        elsif(rising_edge(clk)) then
            if counter_refresh = std_logic_vector(counter_limit_binary) then
                if selected_segment = (std_logic_vector(to_unsigned(number_of_seven_segments, selected_segment'length))) then
                    counter_reset <= '1';
                else
                    next_counter_enable <= '1';
                end if;
            else
                counter_reset <= '0';
                next_counter_enable <= '0'; 
            end if;
        end if;
    end process counter_refresh_proc;

D2 : synchronous_counter
    generic map (
        WIDTH => 3
    )
    port map (
        CLK => clk,
        updwn => '1',
        clr => counter_reset,
        ld => '0',
        en => next_counter_enable,
        D => (others=>'0'),
        Q => selected_segment,
        overflow => open
    );
    
clk_out <= selected_segment;
end structural;
