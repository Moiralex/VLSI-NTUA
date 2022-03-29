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
signal result_first_row, carry_first_row, horizontal_first_row, diagonal_first_row : std_logic_vector(3 downto 0);
signal result_second_row, carry_second_row, horizontal_second_row, diagonal_second_row : std_logic_vector(3 downto 0);
signal result_third_row, carry_third_row, horizontal_third_row, diagonal_third_row : std_logic_vector(2 downto 0);
signal carry_fourth_row, horizontal_fourth_row : std_logic_vector(3 downto 0);

begin

FIRST_ROW_FIRST: full_adder_for_multiplier port map(a_j=>A(0), b_i=>B(0), cin=>'0', sin=>'0', clk=>clk, rst=>rst, s_out=>result_first_row(0), c_out=>carry_first_row(0), D_horizontal=>horizontal_first_row(0), D_diagonal=>diagonal_first_row(0));
FIRST_ROW_SECOND:
FIRST_ROW_THIRD:
FIRST_ROW_FOURTH:
SECOND_ROW_FIRST:
SECOND_ROW_SECOND:
SECOND_ROW_THIRD:
SECOND_ROW_FOURTH:
THIRD_ROW_FIRST:
THIRD_ROW_SECOND:
THIRD_ROW_THIRD:
THIRD_ROW_FOURTH:
end mult;
