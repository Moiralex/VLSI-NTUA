----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2022 02:20:18 AM
-- Design Name: 
-- Module Name: multiplier_four_bit_pipeline - Behavioral
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

entity multiplier_four_bit_pipeline is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           Pout : out STD_LOGIC_VECTOR (7 downto 0));
end multiplier_four_bit_pipeline;

architecture mult of multiplier_four_bit_pipeline is
    
    component full_adder_for_multiplier is
        Port ( a_j : in STD_LOGIC;
               b_i : in STD_LOGIC;
               cin : in STD_LOGIC;
               sin : in STD_LOGIC;
               clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               s_out : out STD_LOGIC;
               c_out : out STD_LOGIC;
               D_horizontal : out STD_LOGIC;
               D_diagonal : out STD_LOGIC);
    end component;
    
    component reg is
        Port ( D : in STD_LOGIC;
               clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               Q : out STD_LOGIC);
    end component;
    
signal result_first_row, carry_first_row, horizontal_first_row, diagonal_first_row : std_logic_vector(3 downto 0);
signal result_second_row, carry_second_row, horizontal_second_row, diagonal_second_row : std_logic_vector(3 downto 0);
signal result_third_row, carry_third_row, horizontal_third_row, diagonal_third_row, regP0 : std_logic_vector(3 downto 0);
signal carry_fourth_row, horizontal_fourth_row : std_logic_vector(3 downto 0);
signal dontcare, regP2 : std_logic;
signal regP1 : std_logic_vector(1 downto 0);

begin

FIRST_ROW_FIRST: full_adder_for_multiplier port map(a_j=>A(0), b_i=>B(0), cin=>'0', sin=>'0', clk=>clk, rst=>rst, s_out=>regP0(0), c_out=>carry_first_row(0), D_horizontal=>horizontal_first_row(0), D_diagonal=>diagonal_first_row(0));
FIRST_ROW_SECOND: full_adder_for_multiplier port map(a_j=>A(1), b_i=>horizontal_first_row(0), cin=>carry_first_row(0), sin=>'0', clk=>clk, rst=>rst, s_out=>result_first_row(1), c_out=>carry_first_row(1), D_horizontal=>horizontal_first_row(1), D_diagonal=>diagonal_first_row(1));
FIRST_ROW_THIRD: full_adder_for_multiplier port map(a_j=>A(2), b_i=>horizontal_first_row(1), cin=>carry_first_row(1), sin=>'0', clk=>clk, rst=>rst, s_out=>result_first_row(2), c_out=>carry_first_row(2), D_horizontal=>horizontal_first_row(2), D_diagonal=>diagonal_first_row(2));
FIRST_ROW_FOURTH: full_adder_for_multiplier port map(a_j=>A(3), b_i=>horizontal_first_row(2), cin=>carry_first_row(2), sin=>'0', clk=>clk, rst=>rst, s_out=>result_first_row(3), c_out=>carry_first_row(3), D_horizontal=>horizontal_first_row(3), D_diagonal=>diagonal_first_row(3));

regP0_0: reg port map (D=>regP0(0), clk=>clk, rst=>rst, Q=>regP0(1));
regP0_1: reg port map (D=>regP0(1), clk=>clk, rst=>rst, Q=>regP0(2));
regP0_2: reg port map (D=>regP0(2), clk=>clk, rst=>rst, Q=>Pout(0));

SECOND_ROW_FIRST: full_adder_for_multiplier port map(a_j=>diagonal_first_row(0), b_i=>B(1), cin=>'0', sin=>result_first_row(1), clk=>clk, rst=>rst, s_out=>regP1(0), c_out=>carry_second_row(0), D_horizontal=>horizontal_second_row(0), D_diagonal=>diagonal_second_row(0));
SECOND_ROW_SECOND: full_adder_for_multiplier port map(a_j=>diagonal_first_row(1), b_i=>horizontal_second_row(0), cin=>carry_second_row(0), sin=>result_first_row(2), clk=>clk, rst=>rst, s_out=>result_second_row(1), c_out=>carry_second_row(1), D_horizontal=>horizontal_second_row(1), D_diagonal=>diagonal_second_row(1));
SECOND_ROW_THIRD: full_adder_for_multiplier port map(a_j=>diagonal_first_row(2), b_i=>horizontal_second_row(1), cin=>carry_second_row(1), sin=>result_first_row(3), clk=>clk, rst=>rst, s_out=>result_second_row(2), c_out=>carry_second_row(2), D_horizontal=>horizontal_second_row(2), D_diagonal=>diagonal_second_row(2));
SECOND_ROW_FOURTH: full_adder_for_multiplier port map(a_j=>diagonal_first_row(3), b_i=>horizontal_second_row(2), cin=>carry_second_row(2), sin=>carry_first_row(3), clk=>clk, rst=>rst, s_out=>result_second_row(3), c_out=>carry_second_row(3), D_horizontal=>horizontal_second_row(3), D_diagonal=>diagonal_second_row(3));

regP1_0: reg port map (D=>regP1(0), clk=>clk, rst=>rst, Q=>regP1(1));
regP1_1: reg port map (D=>regP1(1), clk=>clk, rst=>rst, Q=>Pout(1));

THIRD_ROW_FIRST: full_adder_for_multiplier port map(a_j=>diagonal_second_row(0), b_i=>B(2), cin=>'0', sin=>result_second_row(1), clk=>clk, rst=>rst, s_out=>regP2, c_out=>carry_third_row(0), D_horizontal=>horizontal_third_row(0), D_diagonal=>diagonal_third_row(0));
THIRD_ROW_SECOND: full_adder_for_multiplier port map(a_j=>diagonal_second_row(1), b_i=>horizontal_third_row(0), cin=>carry_third_row(0), sin=>result_second_row(2), clk=>clk, rst=>rst, s_out=>result_third_row(1), c_out=>carry_third_row(1), D_horizontal=>horizontal_third_row(1), D_diagonal=>diagonal_third_row(1));
THIRD_ROW_THIRD: full_adder_for_multiplier port map(a_j=>diagonal_second_row(2), b_i=>horizontal_third_row(1), cin=>carry_third_row(1), sin=>result_second_row(3), clk=>clk, rst=>rst, s_out=>result_third_row(2), c_out=>carry_third_row(2), D_horizontal=>horizontal_third_row(2), D_diagonal=>diagonal_third_row(2));
THIRD_ROW_FOURTH: full_adder_for_multiplier port map(a_j=>diagonal_second_row(3), b_i=>horizontal_third_row(2), cin=>carry_third_row(2), sin=>carry_second_row(3), clk=>clk, rst=>rst, s_out=>result_third_row(3), c_out=>carry_third_row(3), D_horizontal=>horizontal_third_row(3), D_diagonal=>diagonal_third_row(3));

regP2_0: reg port map (D=>regP2, clk=>clk, rst=>rst, Q=>Pout(2));

FOURTH_ROW_FIRST: full_adder_for_multiplier port map(a_j=>diagonal_third_row(0), b_i=>B(3), cin=>'0', sin=>result_third_row(1), clk=>clk, rst=>rst, s_out=>Pout(3), c_out=>carry_fourth_row(0), D_horizontal=>horizontal_fourth_row(0), D_diagonal=>dontcare);
FOURTH_ROW_SECOND: full_adder_for_multiplier port map(a_j=>diagonal_third_row(1), b_i=>horizontal_fourth_row(0), cin=>carry_fourth_row(0), sin=>result_third_row(2), clk=>clk, rst=>rst, s_out=>Pout(4), c_out=>carry_fourth_row(1), D_horizontal=>horizontal_fourth_row(1), D_diagonal=>dontcare);
FOURTH_ROW_THIRD: full_adder_for_multiplier port map(a_j=>diagonal_third_row(2), b_i=>horizontal_fourth_row(1), cin=>carry_fourth_row(1), sin=>result_third_row(3), clk=>clk, rst=>rst, s_out=>Pout(5), c_out=>carry_fourth_row(2), D_horizontal=>horizontal_fourth_row(2), D_diagonal=>dontcare);
FOURTH_ROW_FOURTH: full_adder_for_multiplier port map(a_j=>diagonal_third_row(3), b_i=>horizontal_fourth_row(2), cin=>carry_fourth_row(2), sin=>carry_third_row(3), clk=>clk, rst=>rst, s_out=>Pout(6), c_out=>Pout(7), D_horizontal=>horizontal_fourth_row(3), D_diagonal=>dontcare);


end mult;
