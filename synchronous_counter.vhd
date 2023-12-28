----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/28/2023 12:45:52 PM
-- Design Name: 
-- Module Name: synchronous_counter - behavioral
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
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity synchronous_counter is
    Generic(WIDTH : positive := 4);
    Port (clk : in  STD_LOGIC;
           updwn, clr, ld, en : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
           Q : out  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           overflow : out  STD_LOGIC);
end synchronous_counter;


architecture behavioral of synchronous_counter is

    signal ones : unsigned(WIDTH-1 downto 0) := (others=>'1');
    signal zeroes : unsigned(WIDTH-1 downto 0) := (others=>'0');

begin
    
    process (CLK)
        variable temp1 : unsigned(WIDTH-1 downto 0) := (others=>'0');
        variable temp2 : STD_LOGIC := '0';
    begin
        if rising_edge(CLK) then
            if (clr = '1') then
                temp1 := zeroes;
                temp2 := '0';
            elsif (en = '0') then
                temp1 := temp1;
                temp2 := '0';
            elsif (en = '1') then
                if (ld = '1') then
                    temp1 := unsigned(D);
                    temp2 := '0';
                else
                    if (updwn = '0') then
                        if (temp1 = zeroes) then
                            temp1 := ones;
                            temp2 := '1';
                        else
                            temp1 := temp1 - 1;
                            temp2 := '0';
                        end if;
                    else
                        if (temp1 = ones) then
                            temp1 := zeroes;
                            temp2 := '1';
                        else
                            temp1 := temp1 + 1;
                            temp2 := '0';
                        end if;
                    end if;
                end if;
            else
                temp1:= temp1;
            end if;
        end if;

        Q <= std_logic_vector(temp1);
        overflow <= temp2;
    end process;
        
end behavioral;