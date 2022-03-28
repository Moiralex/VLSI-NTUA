----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.03.2022 18:33:28
-- Design Name: 
-- Module Name: four_bit_FA_pipeline - Structural
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

entity four_bit_FA_pipeline is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0);
           Cout : out STD_LOGIC);
end four_bit_FA_pipeline;

architecture Structural of four_bit_FA_pipeline is

component reg is
    Port ( D : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           Q : out STD_LOGIC);
end component;

component full_adder_behavioral is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Cin : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           S : out STD_LOGIC;
           Cout : out STD_LOGIC);
end component;

--signal regCout, regCin : std_logic_vector(2 downto 0);
signal C1, C2, C3 : std_logic;
signal regA1, regB1 : std_logic;
signal regA2, regB2 : std_logic_vector(1 downto 0);
signal regA3, regB3 : std_logic_vector(2 downto 0);
signal regS0 : std_logic_vector (2 downto 0);
signal regS1 : std_logic_vector (1 downto 0);
signal regS2 : std_logic;

begin

FA0: full_adder_behavioral port map (A=>A(0), B=>B(0), Cin=>Cin, clk=>clk, rst=>rst, S=>regS0(0), Cout=>C1);
regS0_0: reg port map (D=>regS0(0), clk=>clk, rst=>rst, Q=>regS0(1));
regS0_1: reg port map (D=>regS0(1), clk=>clk, rst=>rst, Q=>regS0(2));
regS0_2: reg port map (D=>regS0(2), clk=>clk, rst=>rst, Q=>S(0));

regA1_0: reg port map (D=>A(1), clk=>clk, rst=>rst, Q=>regA1);
regB1_0: reg port map (D=>B(1), clk=>clk, rst=>rst, Q=>regB1);
FA1: full_adder_behavioral port map (A=>regA1, B=>regB1, Cin=>C1, clk=>clk, rst=>rst, S=>regS1(0), Cout=>C2);
regS1_0: reg port map (D=>regS1(0), clk=>clk, rst=>rst, Q=>regS1(1));
regS1_1: reg port map (D=>regS1(1), clk=>clk, rst=>rst, Q=>S(1));

regA2_0: reg port map (D=>A(2), clk=>clk, rst=>rst, Q=>regA2(0));
regB2_0: reg port map (D=>B(2), clk=>clk, rst=>rst, Q=>regB2(0));
regA2_1: reg port map (D=>regA2(0), clk=>clk, rst=>rst, Q=>regA2(1));
regB2_1: reg port map (D=>regB2(0), clk=>clk, rst=>rst, Q=>regB2(1));
FA2: full_adder_behavioral port map (A=>regA2(1), B=>regB2(1), Cin=>C2, clk=>clk, rst=>rst, S=>regS2, Cout=>C3);
regS2_0: reg port map (D=>regS2, clk=>clk, rst=>rst, Q=>S(2));

regA3_0: reg port map (D=>A(3), clk=>clk, rst=>rst, Q=>regA3(0));
regB3_0: reg port map (D=>B(3), clk=>clk, rst=>rst, Q=>regB3(0));
regA3_1: reg port map (D=>regA3(0), clk=>clk, rst=>rst, Q=>regA3(1));
regB3_1: reg port map (D=>regB3(0), clk=>clk, rst=>rst, Q=>regB3(1));
regA3_2: reg port map (D=>regA3(1), clk=>clk, rst=>rst, Q=>regA3(2));
regB3_2: reg port map (D=>regB3(1), clk=>clk, rst=>rst, Q=>regB3(2));
FA3: full_adder_behavioral port map (A=>regA3(2), B=>regB3(2), Cin=>C3, clk=>clk, rst=>rst, S=>S(4), Cout=>Cout);

end Structural;
