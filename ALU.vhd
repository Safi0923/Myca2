----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/26/2023 12:45:45 AM
-- Design Name: 
-- Module Name: ALU - Behavioral
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
use work.log_function.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    port (A,B: in std_logic_vector(3 downto 0);
          S: in std_logic_vector(2 downto 0);
          D: out std_logic_vector(3 downto 0));
end ALU;

architecture structural of ALU is

    component ripple_adder
        generic( WIDTH : positive := 4);
        port( CIN : in std_logic;
            A, B: in std_logic_vector(WIDTH-1 downto 0);
            SUM : out std_logic_vector(WIDTH-1 downto 0);
            COUT: out std_logic);
    end component;
    
    component data_comp_n
        generic(WIDTH : positive :=4);
        port (AEQBIN: in std_logic:='1';
              ALTBIN,AGTBIN: in std_logic:='0';
              A,B: in std_logic_vector(WIDTH-1 downto 0);
              ALTBOUT,AEQBOUT,AGTBOUT: out std_logic);
    end component;
    
    component logical_shift_n
        generic(WIDTH : positive :=8);
        port (A: in std_logic_vector(WIDTH-1 downto 0);
              S: in std_logic_vector(log2(WIDTH)-1 downto 0);
              D: out std_logic_vector(WIDTH-1 downto 0));
    end component;
    
    component logical_shift_n_right
        generic(WIDTH : positive :=8);
        port (A: in std_logic_vector(WIDTH-1 downto 0);
              S: in std_logic_vector(log2(WIDTH)-1 downto 0);
              D: out std_logic_vector(WIDTH-1 downto 0));
    end component;
    
    component mux
        generic(WIDTH : positive :=4);
        port(A,B : in std_logic_vector(WIDTH-1 downto 0);
             S   : in std_logic;
             O   : out std_logic_vector(WIDTH-1 downto 0));
    end component;
    
    component mux_8_to_1 is
        generic(WIDTH : positive :=4);
        port(A,B,C,D,E,F,G,H : in std_logic_vector(WIDTH-1 downto 0);
             S   : in std_logic_vector(2 downto 0);
             O   : out std_logic_vector(WIDTH-1 downto 0));
    end component;
    
    component and_2 is
        port (in1,in2: in std_logic;
              and_out: out std_logic);
    end component;

    component xor_2 is
        port (in1,in2: in std_logic;
              xor_out: out std_logic);
    end component;

    component or_2 is
        port (in1,in2: in std_logic;
              or_out: out std_logic);
    end component;
    
signal SIG1, SIG2, SIG3, SIG4, SIG5, SIG6, SIG7, SIG8, SIG9, SIG10, SIG11, SIG12: std_logic;
signal not_B: std_logic_vector(3 downto 0) := not B;
signal SIG13, SIG16: std_logic_vector(3 downto 0);
signal SIG14, SIG17: std_logic_vector(7 downto 0);
signal SIG15: std_logic_vector(7 downto 0) := "0000" & A;
signal SIG18: std_logic_vector(3 downto 0) := A and B;
signal SIG19: std_logic_vector(3 downto 0) := A or B;
signal SIG20: std_logic_vector(3 downto 0) := "000" & SIG11;
signal SIG21: std_logic_vector(3 downto 0) := "000" & SIG12;

begin
    U1: data_comp_n port map (A => A, B => B, AEQBIN => '1', ALTBIN => '0', AGTBIN => '0', AEQBOUT => open, ALTBOUT => SIG2, AGTBOUT => SIG1);
    U2: and_2 port map (in1 => A(3), in2 => B(3), and_out => SIG3);
    U3: and_2 port map (in1 => SIG3, in2 => SIG1, and_out => SIG4);
    U4: and_2 port map (in1 => SIG3, in2 => SIG2, and_out => SIG5);
    U5: and_2 port map (in1 => A(3), in2 => B(3), and_out => SIG6);
    U6: and_2 port map (in1 => A(3), in2 => B(3), and_out => SIG7);
    U7: xor_2 port map (in1 => A(3), in2 => B(3), xor_out => SIG8);
    U8: and_2 port map (in1 => SIG6, in2 => SIG8, and_out => SIG9);
    U9: and_2 port map (in1 => SIG7, in2 => SIG8, and_out => SIG10);
    U10: or_2 port map (in1 => SIG10, in2 => SIG5, or_out => SIG11);
    U11: or_2 port map (in1 => SIG9, in2 => SIG4, or_out => SIG12);
    U12: mux port map (A => not_B, B => B, S => S(0), O => SIG13);
    U13 : logical_shift_n_right port map (A => SIG15, S => B(2 downto 0), D => SIG14);
    U14 : ripple_adder port map(CIN => S(0), B => SIG13, A => A, COUT => open, SUM => SIG16);
    U15 : logical_shift_n port map (A => SIG15, S => B(2 downto 0), D => SIG17);
    U16: mux_8_to_1 port map (A => SIG16, B => SIG16, C => SIG20, D => SIG21, E => SIG18, F => SIG19, G => SIG17(3 downto 0), H => SIG14(3 downto 0), S => S, O => D);

end structural;
