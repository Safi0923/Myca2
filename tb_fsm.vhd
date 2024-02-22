----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/22/2024 04:31:27 PM
-- Design Name: 
-- Module Name: tb_fsm - Behavioral
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

entity tb_fsm is
end tb_fsm;

architecture tb of tb_fsm is
COMPONENT PopMachine_Controller_FSM
    port (
clk : in std_logic;
clr : in std_logic;
coin_ack, coin_retired, seq30, sgt30, pop_retired : in std_logic;
clr_cnt, change_dec, drop_pop, return_nickel, add, ld_cnt : out std_logic
);
END COMPONENT;
signal clk, clr : std_logic := '0';
signal coin_ack, coin_retired, seq30, sgt30, pop_retired  : std_logic := '0';
signal clr_cnt, change_dec, drop_pop, return_nickel, add, ld_cnt : std_logic;
constant clk_period : time := 10 ns;	-- 100MHz
begin
uut: PopMachine_Controller_FSM PORT MAP (
          clk => clk,
          clr => clr,
         coin_ack => coin_ack,
         coin_retired => coin_retired,
         seq30 => seq30, 
         sgt30 => sgt30,
         pop_retired => pop_retired,
         clr_cnt => clr_cnt,
         change_dec => change_dec,
         drop_pop => drop_pop,
         return_nickel => return_nickel,
         add => add,
         ld_cnt => ld_cnt
        );
clk_process :process
   begin
		Clk <= '1';
		wait for clk_period/2;
		Clk <= '0';
		wait for clk_period/2;
   end process;
  stimulus_process: process
   begin		
   
        clr <= '1';
        wait for 200 ns;
        clr <= '0';        
        coin_ack <= '1';
        wait for 200 ns;
        coin_ack <= '0';
        sgt30 <= '1';	    
        wait;
      
   end process;
end tb;