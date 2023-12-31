----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/30/2023 02:59:51 PM
-- Design Name: 
-- Module Name: myca2_pop - behavioral
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
entity myca2_pop is
    port (
    clk : in std_logic;
    clr : in std_logic;
    coin_sensor : in std_logic_vector(1 downto 0);
    coin_ack, coin_retired, pop_retired : in std_logic;
    drop_pop, return_nickel : out std_logic;
    segments : out std_logic_vector(6 downto 0);
    segments_sel : out std_logic_vector(5 downto 0)
    );
end myca2_pop;

architecture structural of myca2_pop is

        component BCDto7Seg is
            Port ( BCD : in STD_LOGIC_VECTOR (3 downto 0);
                   Segments : out STD_LOGIC_VECTOR (6 downto 0));
        end component;
    
        component sevenseg_mux is
            port (A, B, C, D, E, F : in std_logic_vector(3 downto 0);
                  S : in std_logic_vector (2 downto 0);
                  Num_Out : out std_logic_vector(3 downto 0);
                  Cathode_Out : out std_logic_vector(5 downto 0));
        end component;
        
        component synchronous_counter
            Generic(WIDTH : positive := 4);
            Port (clk : in  STD_LOGIC;
               updwn, clr, ld, en : in STD_LOGIC;
               D : in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
               Q : out  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
               overflow : out  STD_LOGIC);
         end component;
         
         component data_comp_n is
                generic(WIDTH : positive :=4);
                port (AEQBIN: in std_logic:='1';
                      ALTBIN,AGTBIN: in std_logic:='0';
                      A,B: in std_logic_vector(WIDTH-1 downto 0);
                      ALTBOUT,AEQBOUT,AGTBOUT: out std_logic);
         end component;
    
        component Debouncer 
            Generic ( count_width : integer := 17);
            Port ( clk : in  STD_LOGIC;
                  button : in  STD_LOGIC;
                  debounced : out  STD_LOGIC);
        end component;
        
        component SevenSegment_driver is
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
        end component;
        
        component myca2_with_peripherals is
            port (clk,clr: in std_logic;
                  i0,i1,i2,i3,i4,i5,i6,i7 : in std_logic;
                  Q: out std_logic_vector(7 downto 0);
                  o0,o1,o2,o3,o4,o5,o6,o7 : out std_logic);
        end component;
        
        component coin_deco is
            Port (COIN_IN : in STD_LOGIC_VECTOR(1 downto 0);
                   DECO_OUT : out  STD_LOGIC_VECTOR (3 downto 0));
        end component;
        
        component ripple_adder_wrapper is
            generic(WIDTH : positive := 4);
            port(CLK,RST,EN,CIN: in std_logic;
                A,B: in  std_logic_vector(WIDTH-1 downto 0);
                SUM: out std_logic_vector(WIDTH-1 downto 0);
                COUT: out std_logic);
        end component;
    
        component or_2 is
            port (in1,in2: in  std_logic; 
                  or_out:  out std_logic);
        end component;
    
     signal a : std_logic_vector(3 downto 0);
     signal b : std_logic;
     signal c : std_logic_vector(3 downto 0);
     signal d : std_logic_vector(3 downto 0);
     signal e : std_logic;
     signal f : std_logic;
     signal g : std_logic;
     signal price : std_logic_vector(3 downto 0) :="0110";
     signal h : std_logic;
     signal i : std_logic;
     signal j : std_logic_vector(3 downto 0);
     signal k : std_logic;
     signal l : std_logic;
     signal m : std_logic;
     signal n : std_logic;
     signal o : std_logic;
     signal not_k : std_logic := not k;
     signal not_l : std_logic := not l;
     signal not_m : std_logic := not m;
          
    begin

    d1 : coin_deco
    port map (
        COIN_IN => coin_sensor,
        DECO_OUT => a
    );
    
    d2 : ripple_adder_wrapper
    port map(
        CLK => clk,
        RST => clr,
        EN => b,
        CIN => '0',
        A => a,
        B => c,
        COUT => open,
        SUM => d
    );
    
    d3 : synchronous_counter
    port map(
        clk => clk,
        clr => e,
        ld => f,
        D => d,
        updwn => '0',
        en => g,
        overflow => open,
        Q => c    
    );
    
    d4 : data_comp_n
    port map(
        A => c,
        B => price,
        altbin => '0',
        aeqbin => '1',
        agtbin => '0',
        altbout => open,
        aeqbout => h,
        agtbout => i
    );
    
        d5 : SevenSegment_driver
        port map (
            clk => clk,
            rst => clr ,
            SS0 => c ,
            SS1 => d ,
            SS2 => price ,
            SS3 => j ,
            SS4 => "0000" ,
            SS5 => "0000" ,
            Sel => segments_sel ,
            SSO => segments 
            );
        
        d6 :myca2_with_peripherals
        port map(
        clk => clk ,
        clr => clr ,
        i0 => k,
        i1 => not_k,
        i2 => l,
        i3 => not_l,
        i4 => m,
        i5 => not_m,
        i6 =>h ,
        i7 => i,
        o0 => n ,
        o1 => o ,
        o3 => drop_pop ,
        o2 => return_nickel , 
        o4=> b ,
        o5 => f,
        Q(3 downto 0) => j,
        Q(7 downto 4) => "0000");
        
        d7 : or_2
        port map(
        in1=> n ,
        in2 => clr,  
        or_out => e
        );
        
         d8 : or_2
        port map(
        in1=> o ,
        in2 => clr,  
        or_out => f
        );
        
        d9 : Debouncer
        port map(
            clk => clk,
            button => coin_ack,
            debounced => k);
            
        d10 : Debouncer
        port map(
            clk => clk,
            button => coin_retired,
            debounced => l);
                
        d11 : Debouncer
        port map(
            clk => clk,
            button => pop_retired,
            debounced => m);
                
        end structural ;
        