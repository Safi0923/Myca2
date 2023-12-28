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
          braddr, jaddr: in std_logic_vector(7 downto 0);
          Q: out std_logic_vector(7 downto 0));
end myca2_controller;

architecture structural of myca2_controller is

    component ripple_adder
        generic( WIDTH : positive := 8);
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
        Generic(WIDTH : positive := 8);
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

signal x1,x2,x3,x4: std_logic_vector(7 downto 0);
signal y1,y2,y3: std_logic;
signal z1,z2: std_logic_vector(1 downto 0);

begin
D1 : ripple_adder port map(CIN => y1, B => x1, A => "00000000", COUT => open, SUM => x2);
D2 : opcode_decoder port map(deco_in_flag=> flag, deco_in_opcode => opcode, deco_out_cin => y1, deco_out2_stack => z1, deco_out3_mux => z2, deco_out4_en => y3, deco_out5_ld => y2);
D3 : stack port map(clk => clk, clr => clr, S => z1, A => x2, Q => x3);
D4 : mux_4_to_1 port map(D0 => braddr, D1 => jaddr, D2 => x3, D3 => "00000000", S => z2, O => x4);
D5 : synchronous_counter port map(clk => clk, updwn => '1', clr => clr, ld => y2, en => y3, D => x4, Q => x1, overflow => open);

Q <= x1;

end structural;
