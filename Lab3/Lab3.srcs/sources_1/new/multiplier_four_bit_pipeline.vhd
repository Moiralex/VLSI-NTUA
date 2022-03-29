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
signal carry_buf_first_row, carry_buf_second_row, carry_buf_third_row : std_logic;
signal result_second_row, carry_second_row, horizontal_second_row, diagonal_second_row : std_logic_vector(3 downto 0);
signal result_third_row, carry_third_row, horizontal_third_row, diagonal_third_row : std_logic_vector(3 downto 0);
signal regP0 : std_logic_vector(8 downto 0);
signal carry_fourth_row, horizontal_fourth_row : std_logic_vector(3 downto 0);
signal dontcare : std_logic;

signal b1_buf: std_logic_vector(1 downto 0);
signal b2_buf: std_logic_vector(3 downto 0);
signal b3_buf: std_logic_vector(5 downto 0);

signal regP1 : std_logic_vector(6 downto 0);
signal regP2 : std_logic_vector(4 downto 0);
signal regP3 : std_logic_vector(2 downto 0);
signal regP4 : std_logic_vector(1 downto 0);
signal regP5 : std_logic;

signal a1_buf: std_logic;
signal a2_buf: std_logic_vector(1 downto 0);
signal a3_buf: std_logic_vector(2 downto 0);


begin

FIRST_ROW_FIRST: full_adder_for_multiplier port map(a_j=>A(0), b_i=>B(0), cin=>'0', sin=>'0', clk=>clk, rst=>rst, s_out=>regP0(0), c_out=>carry_first_row(0), D_horizontal=>horizontal_first_row(0), D_diagonal=>diagonal_first_row(0));

regA1_0: reg port map (D=>A(1), clk=>clk, rst=>rst, Q=>a1_buf);

FIRST_ROW_SECOND: full_adder_for_multiplier port map(a_j=>a1_buf, b_i=>horizontal_first_row(0), cin=>carry_first_row(0), sin=>'0', clk=>clk, rst=>rst, s_out=>result_first_row(1), c_out=>carry_first_row(1), D_horizontal=>horizontal_first_row(1), D_diagonal=>diagonal_first_row(1));

regA2_0: reg port map (D=>A(2), clk=>clk, rst=>rst, Q=>a2_buf(0));
regA2_1: reg port map (D=>a2_buf(0), clk=>clk, rst=>rst, Q=>a2_buf(1));

FIRST_ROW_THIRD: full_adder_for_multiplier port map(a_j=>a2_buf(1), b_i=>horizontal_first_row(1), cin=>carry_first_row(1), sin=>'0', clk=>clk, rst=>rst, s_out=>result_first_row(2), c_out=>carry_first_row(2), D_horizontal=>horizontal_first_row(2), D_diagonal=>diagonal_first_row(2));

regA3_0: reg port map (D=>A(3), clk=>clk, rst=>rst, Q=>a3_buf(0));
regA3_1: reg port map (D=>a3_buf(0), clk=>clk, rst=>rst, Q=>a3_buf(1));
regA3_2: reg port map (D=>a3_buf(1), clk=>clk, rst=>rst, Q=>a3_buf(2));

FIRST_ROW_FOURTH: full_adder_for_multiplier port map(a_j=>a3_buf(2), b_i=>horizontal_first_row(2), cin=>carry_first_row(2), sin=>'0', clk=>clk, rst=>rst, s_out=>result_first_row(3), c_out=>carry_first_row(3), D_horizontal=>horizontal_first_row(3), D_diagonal=>diagonal_first_row(3));

regCoutFirstRow: reg port map (D=>carry_first_row(3), clk=>clk, rst=>rst, Q=>carry_buf_first_row);

regP0_0: reg port map (D=>regP0(0), clk=>clk, rst=>rst, Q=>regP0(1));
regP0_1: reg port map (D=>regP0(1), clk=>clk, rst=>rst, Q=>regP0(2));
regP0_2: reg port map (D=>regP0(2), clk=>clk, rst=>rst, Q=>regP0(3));
regP0_3: reg port map (D=>regP0(3), clk=>clk, rst=>rst, Q=>regP0(4));
regP0_4: reg port map (D=>regP0(4), clk=>clk, rst=>rst, Q=>regP0(5));
regP0_5: reg port map (D=>regP0(5), clk=>clk, rst=>rst, Q=>regP0(6));
regP0_6: reg port map (D=>regP0(6), clk=>clk, rst=>rst, Q=>regP0(7));
regP0_7: reg port map (D=>regP0(7), clk=>clk, rst=>rst, Q=>regP0(8));
regP0_8: reg port map (D=>regP0(8), clk=>clk, rst=>rst, Q=>Pout(0));

regB1_0: reg port map (D=>B(1), clk=>clk, rst=>rst, Q=>b1_buf(0));
regB1_1: reg port map (D=>b1_buf(0), clk=>clk, rst=>rst, Q=>b1_buf(1));

SECOND_ROW_FIRST: full_adder_for_multiplier port map(a_j=>diagonal_first_row(0), b_i=>b1_buf(1), cin=>'0', sin=>result_first_row(1), clk=>clk, rst=>rst, s_out=>regP1(0), c_out=>carry_second_row(0), D_horizontal=>horizontal_second_row(0), D_diagonal=>diagonal_second_row(0));
SECOND_ROW_SECOND: full_adder_for_multiplier port map(a_j=>diagonal_first_row(1), b_i=>horizontal_second_row(0), cin=>carry_second_row(0), sin=>result_first_row(2), clk=>clk, rst=>rst, s_out=>result_second_row(1), c_out=>carry_second_row(1), D_horizontal=>horizontal_second_row(1), D_diagonal=>diagonal_second_row(1));
SECOND_ROW_THIRD: full_adder_for_multiplier port map(a_j=>diagonal_first_row(2), b_i=>horizontal_second_row(1), cin=>carry_second_row(1), sin=>result_first_row(3), clk=>clk, rst=>rst, s_out=>result_second_row(2), c_out=>carry_second_row(2), D_horizontal=>horizontal_second_row(2), D_diagonal=>diagonal_second_row(2));
SECOND_ROW_FOURTH: full_adder_for_multiplier port map(a_j=>diagonal_first_row(3), b_i=>horizontal_second_row(2), cin=>carry_second_row(2), sin=>carry_buf_first_row, clk=>clk, rst=>rst, s_out=>result_second_row(3), c_out=>carry_second_row(3), D_horizontal=>horizontal_second_row(3), D_diagonal=>diagonal_second_row(3));

regCoutSecondRow: reg port map (D=>carry_second_row(3), clk=>clk, rst=>rst, Q=>carry_buf_second_row);

regP1_0: reg port map (D=>regP1(0), clk=>clk, rst=>rst, Q=>regP1(1));
regP1_1: reg port map (D=>regP1(1), clk=>clk, rst=>rst, Q=>regP1(2));
regP1_2: reg port map (D=>regP1(2), clk=>clk, rst=>rst, Q=>regP1(3));
regP1_3: reg port map (D=>regP1(3), clk=>clk, rst=>rst, Q=>regP1(4));
regP1_4: reg port map (D=>regP1(4), clk=>clk, rst=>rst, Q=>regP1(5));
regP1_5: reg port map (D=>regP1(5), clk=>clk, rst=>rst, Q=>regP1(6));
regP1_6: reg port map (D=>regP1(6), clk=>clk, rst=>rst, Q=>Pout(1));

regB2_0: reg port map (D=>B(2), clk=>clk, rst=>rst, Q=>b2_buf(0));
regB2_1: reg port map (D=>b2_buf(0), clk=>clk, rst=>rst, Q=>b2_buf(1));
regB2_2: reg port map (D=>b2_buf(1), clk=>clk, rst=>rst, Q=>b2_buf(2));
regB2_3: reg port map (D=>b2_buf(2), clk=>clk, rst=>rst, Q=>b2_buf(3));

THIRD_ROW_FIRST: full_adder_for_multiplier port map(a_j=>diagonal_second_row(0), b_i=>b2_buf(3), cin=>'0', sin=>result_second_row(1), clk=>clk, rst=>rst, s_out=>regP2(0), c_out=>carry_third_row(0), D_horizontal=>horizontal_third_row(0), D_diagonal=>diagonal_third_row(0));
THIRD_ROW_SECOND: full_adder_for_multiplier port map(a_j=>diagonal_second_row(1), b_i=>horizontal_third_row(0), cin=>carry_third_row(0), sin=>result_second_row(2), clk=>clk, rst=>rst, s_out=>result_third_row(1), c_out=>carry_third_row(1), D_horizontal=>horizontal_third_row(1), D_diagonal=>diagonal_third_row(1));
THIRD_ROW_THIRD: full_adder_for_multiplier port map(a_j=>diagonal_second_row(2), b_i=>horizontal_third_row(1), cin=>carry_third_row(1), sin=>result_second_row(3), clk=>clk, rst=>rst, s_out=>result_third_row(2), c_out=>carry_third_row(2), D_horizontal=>horizontal_third_row(2), D_diagonal=>diagonal_third_row(2));
THIRD_ROW_FOURTH: full_adder_for_multiplier port map(a_j=>diagonal_second_row(3), b_i=>horizontal_third_row(2), cin=>carry_third_row(2), sin=>carry_buf_second_row, clk=>clk, rst=>rst, s_out=>result_third_row(3), c_out=>carry_third_row(3), D_horizontal=>horizontal_third_row(3), D_diagonal=>diagonal_third_row(3));

regCoutThirdRow: reg port map (D=>carry_third_row(3), clk=>clk, rst=>rst, Q=>carry_buf_third_row);

regP2_0: reg port map (D=>regP2(0), clk=>clk, rst=>rst, Q=>regP2(1));
regP2_1: reg port map (D=>regP2(1), clk=>clk, rst=>rst, Q=>regP2(2));
regP2_2: reg port map (D=>regP2(2), clk=>clk, rst=>rst, Q=>regP2(3));
regP2_3: reg port map (D=>regP2(3), clk=>clk, rst=>rst, Q=>regP2(4));
regP2_4: reg port map (D=>regP2(4), clk=>clk, rst=>rst, Q=>Pout(2));

regB3_0: reg port map (D=>B(3), clk=>clk, rst=>rst, Q=>b3_buf(0));
regB3_1: reg port map (D=>b3_buf(0), clk=>clk, rst=>rst, Q=>b3_buf(1));
regB3_2: reg port map (D=>b3_buf(1), clk=>clk, rst=>rst, Q=>b3_buf(2));
regB3_3: reg port map (D=>b3_buf(2), clk=>clk, rst=>rst, Q=>b3_buf(3));
regB3_4: reg port map (D=>b3_buf(3), clk=>clk, rst=>rst, Q=>b3_buf(4));
regB3_5: reg port map (D=>b3_buf(4), clk=>clk, rst=>rst, Q=>b3_buf(5));

FOURTH_ROW_FIRST: full_adder_for_multiplier port map(a_j=>diagonal_third_row(0), b_i=>b3_buf(5), cin=>'0', sin=>result_third_row(1), clk=>clk, rst=>rst, s_out=>regP3(0), c_out=>carry_fourth_row(0), D_horizontal=>horizontal_fourth_row(0), D_diagonal=>dontcare);

regP3_0: reg port map (D=>regP3(0), clk=>clk, rst=>rst, Q=>regP3(1));
regP3_1: reg port map (D=>regP3(1), clk=>clk, rst=>rst, Q=>regP3(2));
regP3_2: reg port map (D=>regP3(2), clk=>clk, rst=>rst, Q=>Pout(3));

FOURTH_ROW_SECOND: full_adder_for_multiplier port map(a_j=>diagonal_third_row(1), b_i=>horizontal_fourth_row(0), cin=>carry_fourth_row(0), sin=>result_third_row(2), clk=>clk, rst=>rst, s_out=>regP4(0), c_out=>carry_fourth_row(1), D_horizontal=>horizontal_fourth_row(1), D_diagonal=>dontcare);

regP4_0: reg port map (D=>regP4(0), clk=>clk, rst=>rst, Q=>regP4(1));
regP4_1: reg port map (D=>regP4(1), clk=>clk, rst=>rst, Q=>Pout(4));

FOURTH_ROW_THIRD: full_adder_for_multiplier port map(a_j=>diagonal_third_row(2), b_i=>horizontal_fourth_row(1), cin=>carry_fourth_row(1), sin=>result_third_row(3), clk=>clk, rst=>rst, s_out=>regP5, c_out=>carry_fourth_row(2), D_horizontal=>horizontal_fourth_row(2), D_diagonal=>dontcare);

regP5_0: reg port map (D=>regP5, clk=>clk, rst=>rst, Q=>Pout(5));

FOURTH_ROW_FOURTH: full_adder_for_multiplier port map(a_j=>diagonal_third_row(3), b_i=>horizontal_fourth_row(2), cin=>carry_fourth_row(2), sin=>carry_buf_third_row, clk=>clk, rst=>rst, s_out=>Pout(6), c_out=>Pout(7), D_horizontal=>horizontal_fourth_row(3), D_diagonal=>dontcare);


end mult;