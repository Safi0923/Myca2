----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/03/2023 07:43:07 PM
-- Design Name: 
-- Module Name: pop_machine - Behavioral
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

entity PopMachine_Controller_FSM is
port (
clk : in std_logic;
clr : in std_logic;
coin_ack, coin_retired, seq30, sgt30, pop_retired : in std_logic;
clr_cnt, change_dec, drop_pop, return_nickel, add, ld_cnt : out std_logic
);
TYPE fsm_state IS (idle, s1, s2, s3, s4, s5, s6, s7, s8) ;
end PopMachine_Controller_FSM;
----------------------------------------------------------------
ARCHITECTURE behavioral OF PopMachine_Controller_FSM IS
SIGNAL current_state, next_state : fsm_state;
BEGIN
PROCESS (clk, clr)
BEGIN
IF (clr = '1') THEN
current_state <= idle ;
ELSIF (clk = '1' AND clk'EVENT) THEN
current_state <= next_state;
end if;
end process;
process(current_state,coin_ack)
begin
CASE current_state IS
WHEN idle =>
clr_cnt <= '0';
ld_cnt <= '0';
if (coin_ack='1') then
next_state <= s7;
elsif (coin_ack='0') then
next_state <= idle;
end if;
when s7 =>
add <= '1';
next_state <= s1;
WHEN s1 =>
add <= '0';
ld_cnt <= '1';
if (coin_ack='0' and sgt30='1') then
next_state <= s2;
elsif (coin_ack='1') then
next_state <= s1;
elsif (coin_ack='0' and sgt30='0' and seq30='0') then
next_state <= idle;
elsif (coin_ack='0' and seq30='1') then
next_state <= s5;
end if;
WHEN s2 =>
ld_cnt <= '0';
if (sgt30='1') then
next_state <= s3;
elsif (seq30='1') then
next_state <= s5;
end if;
WHEN s3 =>
return_nickel <= '1';
if (coin_retired='1') then
next_state <= s8;
elsif (coin_retired='0') then
next_state <= s3;
end if;
WHEN s4 =>
change_dec <= '0';
if (coin_retired='1') then
next_state <= s4;
elsif (coin_retired='0') then
next_state <= s2;
end if;
WHEN s5 =>
drop_pop <= '1';
if (pop_retired='0') then
next_state <= s5;
elsif (pop_retired='1') then
next_state <= s6;
end if;
WHEN s6 =>
drop_pop <= '0';
clr_cnt <= '1';
next_state <= idle;
WHEN s8 =>
return_nickel <= '0';
change_dec <= '0';
next_state <= s4;
end case;
end process;
end behavioral;