----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.03.2022 21:23:46
-- Design Name: 
-- Module Name: four_bit_parallel_BCD_adder_structural_testbench - Behavioral
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

entity four_bit_parallel_BCD_adder_structural_testbench is
--  Port ( );
end four_bit_parallel_BCD_adder_structural_testbench;

architecture Behavioral of four_bit_parallel_BCD_adder_structural_testbench is

signal four_digits_BCD_Cin_test : STD_LOGIC :='0';

signal in_digitA4_test, in_digitA3_test, in_digitA2_test, in_digitA1_test,
         in_digitB4_test, in_digitB3_test, in_digitB2_test, in_digitB1_test,
         out_digit4_test, out_digit3_test, out_digit2_test, out_digit1_test : STD_LOGIC_VECTOR(3 downto 0);


signal four_digits_BCD_Cout_test : STD_LOGIC;

component four_bit_parallel_BCD_adder_structural is
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
end component;

begin

 uut: four_bit_parallel_BCD_adder_structural
        port map(
            in_digitA1=>in_digitA1_test,
            in_digitA2=>in_digitA2_test,
            in_digitA3=>in_digitA3_test,
            in_digitA4=>in_digitA4_test,
            in_digitB1=>in_digitB1_test,
            in_digitB2=>in_digitB2_test,
            in_digitB3=>in_digitB3_test,
            in_digitB4=>in_digitB4_test,
            out_digit1=>out_digit1_test,
            out_digit2=>out_digit2_test,
            out_digit3=>out_digit3_test,
            out_digit4=>out_digit4_test,
            four_digits_BCD_Cin=>four_digits_BCD_Cin_test,
            four_digits_BCD_Cout=>four_digits_BCD_Cout_test
            );
            
            
 stimulus: process begin
    for i in 0 to 1 loop
           four_digits_BCD_Cin_test <= not four_digits_BCD_Cin_test;
           in_digitA1_test<="1001";
           in_digitA2_test<="1001";
           in_digitA3_test<="1001";
           in_digitA4_test<="1001";
           in_digitB1_test<="1001";
           in_digitB2_test<="1001";
           in_digitB3_test<="1001";
           in_digitB4_test<="1001";
           wait for 2ns;
           
           in_digitA1_test<="1001";
           in_digitA2_test<="1001";
           in_digitA3_test<="1001";
           in_digitA4_test<="1001";
           in_digitB1_test<="0001";
           in_digitB2_test<="0000";
           in_digitB3_test<="0000";
           in_digitB4_test<="0000";
           wait for 2ns;
           
           in_digitA1_test<="0100";
           in_digitA2_test<="0010";
           in_digitA3_test<="0101";
           in_digitA4_test<="0000";
           in_digitB1_test<="0110";
           in_digitB2_test<="0100";
           in_digitB3_test<="0011";
           in_digitB4_test<="0000";
           wait for 2ns;
           
           in_digitA1_test<="0000";
           in_digitA2_test<="0000";
           in_digitA3_test<="0101";
           in_digitA4_test<="0001";
           in_digitB1_test<="1001";
           in_digitB2_test<="0111";
           in_digitB3_test<="0010";
           in_digitB4_test<="0000";
           wait for 2ns;
     end loop;
 end process;

end Behavioral;
