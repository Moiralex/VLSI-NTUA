----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/21/2022 08:20:08 PM
-- Design Name: 
-- Module Name: BCD_full_adder_structural - Behavioral
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

entity BCD_full_adder_structural is
    Port ( P4A_BCD : in STD_LOGIC_VECTOR (3 downto 0);
           P4B_BCD : in STD_LOGIC_VECTOR (3 downto 0);
           PCin_BCD : in STD_LOGIC;
           P4S_BCD : out STD_LOGIC_VECTOR (3 downto 0);
           PCout_BCD : inout STD_LOGIC);
end BCD_full_adder_structural;

architecture Structural_BCD of BCD_full_adder_structural is

    component four_bit_parallel_adder_structural is
        Port ( P4A : in STD_LOGIC_VECTOR (3 downto 0);
               P4B : in STD_LOGIC_VECTOR (3 downto 0);
               PCin : in STD_LOGIC;
               P4S : out STD_LOGIC_VECTOR (3 downto 0);
               PCout : out STD_LOGIC
                );
    end component;
    
    component and_gate is
        Port ( X_and : in STD_LOGIC;
               Y_and : in STD_LOGIC;
               Z_and : out STD_LOGIC);
    end component;
    
    component or_gate_3_input is
        Port ( X : in STD_LOGIC;
           Y : in STD_LOGIC;
           Z : in STD_LOGIC;
           or_output : out STD_LOGIC);
    end component;
    
    signal and1, and2, carry_of_first_adder, dontcare_check_it_moiras : STD_LOGIC;
    signal result_of_first_adder, input_of_second_adder : STD_LOGIC_VECTOR(3 downto 0);
begin

ADDER1: four_bit_parallel_adder_structural PORT MAP (P4A=>P4A_BCD, P4B=>P4B_BCD, PCin=>PCin_BCD, P4S=>result_of_first_adder, PCout=>carry_of_first_adder);
AND_first: and_gate PORT MAP (X_and =>result_of_first_adder(3) , Y_and=>result_of_first_adder(2), Z_and=>and1);
AND_second: and_gate PORT MAP (X_and =>result_of_first_adder(3) , Y_and=>result_of_first_adder(1), Z_and=>and2);
OR_carry: or_gate_3_input PORT MAP (X =>and1, Y=>and2, Z=>carry_of_first_adder, or_output=>PCout_BCD);
ADDER2: four_bit_parallel_adder_structural PORT MAP (P4A=>result_of_first_adder, P4B(3)=>'0', P4B(2)=>PCout_BCD, P4B(1)=>PCout_BCD, P4B(0)=>'0', PCin=>'0', P4S=>P4S_BCD, PCout=>dontcare_check_it_moiras);

end Structural_BCD;
