----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/31/2023 01:54:48 PM
-- Design Name: 
-- Module Name: seven_segment_driver - structural
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

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2023 05:49:50 PM
-- Design Name: 
-- Module Name: led_controller - Behavioral
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

entity SevenSegment_driver is
port (
clk : in std_logic;
rst : in std_logic;
SS0 : in std_logic_vector(3 downto 0);
SS1 : in std_logic_vector(3 downto 0);
SS2 : in std_logic_vector(3 downto 0);
SS3 : in std_logic_vector(3 downto 0);
SS4 : in std_logic_vector(3 downto 0);
SS5 : in std_logic_vector(3 downto 0);
Sel : out std_logic_vector(5 downto 0);
SSO : out std_logic_vector(6 downto 0));
end SevenSegment_driver;

architecture structural of SevenSegment_driver is
    component BCDto7Seg
        Port ( BCD : in STD_LOGIC_VECTOR (3 downto 0);
               Segments : out STD_LOGIC_VECTOR (6 downto 0));
    end component;
    
	component sevenseg_mux
		port (A, B, C, D, E, F : in std_logic_vector(3 downto 0);
          S : in std_logic_vector (2 downto 0);
          Num_Out : out std_logic_vector(3 downto 0);
          Cathode_Out : out std_logic_vector(5 downto 0));
	end component;
    
    component clock_divider
        generic(
        input_frequency : positive := 100000000;
        refresh_frequency : positive := 1000
        );
        port (
        clk : in std_logic;
        rst : in std_logic;
        clk_out : out std_logic_vector(2 downto 0));
    end component;
    
signal BCD : std_logic_vector(3 downto 0) := (others => '0');
signal clock_output : std_logic_vector(2 downto 0) := (others => '0');

begin

    D1: clock_divider
    port map (clk => clk, rst => rst, clk_out => clock_output);
    
    D2: sevenseg_mux
    port map (
        A => SS0, B => SS1, C => SS2, D => SS3, E => SS4, F => SS5,
        S => clock_output,
        Num_Out => BCD,
        Cathode_Out => Sel
    );

    D3 : BCDto7Seg
    Port map( 
        BCD => BCD,
        Segments => SSO 
    );

end structural;