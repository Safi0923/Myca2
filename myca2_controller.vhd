----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/28/2023 12:58:08 PM
-- Design Name: 
-- Module Name: myca2_controller - structural
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

entity myca2_controller is
    port (clk,clr,flag: in std_logic;
          opcode: in std_logic_vector(2 downto 0);
          braddr: in std_logic_vector(3 downto 0);
          jaddr: in std_logic_vector(3 downto 0);
          Q: out std_logic_vector(3 downto 0));
end myca2_controller;

architecture structural of myca2_controller is

    component ripple_adder
        generic( WIDTH : positive := 4);
        port( CIN : in std_logic;
            A, B: in std_logic_vector(WIDTH-1 downto 0);
            SUM : out std_logic_vector(WIDTH-1 downto 0);
            COUT: out std_logic);
    end component;
    
    component stack
        port (clk,clr: in std_logic;
          S: in std_logic_vector(1 downto 0);
          A: in std_logic_vector(7 downto 0);
          Q: out std_logic_vector(7 downto 0));
    end component;
    
    component opcode_decoder
        port (deco_in_flag: in std_logic;
          deco_in_opcode: in std_logic_vector(2 downto 0);
          deco_out_cin,deco_out4_en,deco_out5_ld: out std_logic;
          deco_out2_stack : out std_logic_vector(1 downto 0);
          deco_out3_mux: out std_logic_vector(1 downto 0));
    end component;
    
    component synchronous_counter
        Generic(WIDTH : positive := 4);
        Port (clk : in  STD_LOGIC;
           updwn, clr, ld, en : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
           Q : out  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           overflow : out  STD_LOGIC);
    end component;
    
    component mux_4_to_1 is
    port(D0,D1,D2,D3 : in std_logic_vector(7 downto 0);
         S   : in std_logic_vector(1 downto 0);
         O   : out std_logic_vector(7 downto 0));
    end component;

begin


end structural;
