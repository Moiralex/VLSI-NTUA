----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/28/2022 09:34:25 PM
-- Design Name: 
-- Module Name: full_adder_for_multiplier - Behavioral
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

entity full_adder_for_multiplier is
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
end full_adder_for_multiplier;

architecture structural of full_adder_for_multiplier is

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

component and_gate is
    Port ( X_and : in STD_LOGIC;
           Y_and : in STD_LOGIC;
           Z_and : out STD_LOGIC);
end component;

signal result_and, reg_temp, reg_carry, reg_result : std_logic;
begin

AND1: and_gate port map(X_and=>a_j, Y_and=>b_i, Z_and=>result_and);
REG_HORIZONTAL: reg port map (D=>b_i, clk=>clk, rst=>rst, Q=>D_horizontal);
REG_DIAGONAL_1: reg port map (D=>a_j, clk=>clk, rst=>rst, Q=>reg_temp);
REG_DIAGONAL_2: reg port map (D=>reg_temp, clk=>clk, rst=>rst, Q=>D_diagonal);
fll_adder: full_adder_behavioral port map (A=>result_and, B=>sin, Cin=>cin, clk=>clk, rst=>rst, S=>reg_result, Cout=>reg_carry);
carry_reg:  reg port map (D=>reg_carry, clk=>clk, rst=>rst, Q=>c_out);
sum_result_reg: reg port map (D=>reg_result, clk=>clk, rst=>rst, Q=>s_out);

end structural;
