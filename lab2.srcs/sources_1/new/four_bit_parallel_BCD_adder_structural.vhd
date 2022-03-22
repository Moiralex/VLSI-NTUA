----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.03.2022 20:55:08
-- Design Name: 
-- Module Name: four_bit_parallel_BCD_adder_structural - Structural
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

entity four_bit_parallel_BCD_adder_structural is
    Port ( in_digitA1 : in STD_LOGIC_VECTOR (3 downto 0);
           in_digitA2 : in STD_LOGIC_VECTOR (3 downto 0);
           in_digitA3 : in STD_LOGIC_VECTOR (3 downto 0);
           in_digitA4 : in STD_LOGIC_VECTOR (3 downto 0);
           in_digitB1 : in STD_LOGIC_VECTOR (3 downto 0);
           in_digitB2 : in STD_LOGIC_VECTOR (3 downto 0);
           in_digitB3 : in STD_LOGIC_VECTOR (3 downto 0);
           in_digitB4 : in STD_LOGIC_VECTOR (3 downto 0);
           out_digit1 : out STD_LOGIC_VECTOR (3 downto 0);
           out_digit2 : out STD_LOGIC_VECTOR (3 downto 0);
           out_digit3 : out STD_LOGIC_VECTOR (3 downto 0);
           out_digit4 : out STD_LOGIC_VECTOR (3 downto 0);
           four_digits_BCD_Cin : in STD_LOGIC;
           four_digits_BCD_Cout : inout STD_LOGIC);
end four_bit_parallel_BCD_adder_structural;

architecture Structural of four_bit_parallel_BCD_adder_structural is

component BCD_full_adder_structural is
    Port ( P4A_BCD : in STD_LOGIC_VECTOR (3 downto 0);
           P4B_BCD : in STD_LOGIC_VECTOR (3 downto 0);
           PCin_BCD : in STD_LOGIC;
           P4S_BCD : out STD_LOGIC_VECTOR (3 downto 0);
           PCout_BCD : inout STD_LOGIC);
end component;

signal C1, C2, C3 : STD_LOGIC;

begin

BCD_adder1: BCD_full_adder_structural PORT MAP (P4A_BCD=>in_digitA1, P4B_BCD=>in_digitB1, PCin_BCD=>four_digits_BCD_Cin, P4S_BCD=>out_digit1, PCout_BCD=>C1);
BCD_adder2: BCD_full_adder_structural PORT MAP (P4A_BCD=>in_digitA2, P4B_BCD=>in_digitB2, PCin_BCD=>C1, P4S_BCD=>out_digit2, PCout_BCD=>C2);
BCD_adder3: BCD_full_adder_structural PORT MAP (P4A_BCD=>in_digitA3, P4B_BCD=>in_digitB3, PCin_BCD=>C2, P4S_BCD=>out_digit3, PCout_BCD=>C3);
BCD_adder4: BCD_full_adder_structural PORT MAP (P4A_BCD=>in_digitA4, P4B_BCD=>in_digitB4, PCin_BCD=>C3, P4S_BCD=>out_digit4, PCout_BCD=>four_digits_BCD_Cout);

end Structural;
