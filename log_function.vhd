----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/25/2023 10:51:12 AM
-- Design Name: 
-- Module Name: log_function - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

package log_function is

    function log2( x : natural) return integer;
    
end;

package body log_function is
  function log2(x : integer) return integer is
    variable temp : integer :=x;
    variable n : integer := 0;
    begin
        while temp > 1 loop
            temp := temp/2;
            n := n + 1;
        end loop;
    return n;
  end function log2;
end package body;
