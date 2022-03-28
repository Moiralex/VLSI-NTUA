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
    Port ( a_j : in STD_LOGIC_VECTOR (3 downto 0);
           b_i : in STD_LOGIC_VECTOR (3 downto 0);
           cin : in STD_LOGIC;
           sin : in STD_LOGIC;
           Sout : out STD_LOGIC_VECTOR;
           Cout : out STD_LOGIC;
           D_horizontal : out STD_LOGIC;
           D_diagonal : out STD_LOGIC);
end full_adder_for_multiplier;

architecture Behavioral of full_adder_for_multiplier is

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

begin

AND1: 
REG_HORIZONTAL:
REG_DIAGONAL_1:
REG_DIAGONAL_2:
carry_reg:
sum_result_reg:

end Behavioral;
