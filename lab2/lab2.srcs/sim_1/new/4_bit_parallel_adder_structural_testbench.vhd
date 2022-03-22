----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/21/2022 07:57:03 PM
-- Design Name: 
-- Module Name: 4_bit_parallel_adder_structural_testbench - Behavioral
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
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity four_bit_parallel_adder_structural_testbench is
--  Port ( );
end four_bit_parallel_adder_structural_testbench;

architecture test_four_bit_parallel_adder_structural_testbench of four_bit_parallel_adder_structural_testbench is
    
    signal PCin_test :std_logic := '0';
    signal P4A_test, P4B_test : std_logic_vector(3 downto 0) := (others => '1');
    signal PCout_test: std_logic;
    signal P4S_test : std_logic_vector(3 downto 0);
    
    component four_bit_parallel_adder_structural is
        Port ( P4A : in STD_LOGIC_VECTOR (3 downto 0);
               P4B : in STD_LOGIC_VECTOR (3 downto 0);
               PCin : in STD_LOGIC;
               P4S : out STD_LOGIC_VECTOR (3 downto 0);
               PCout : out STD_LOGIC);
    end component;
begin
    uut: four_bit_parallel_adder_structural
        port map(
            P4A=>P4A_test,
            P4B=>P4B_test,
            PCin=>PCin_test,
            P4S=>P4S_test,
            PCout=>PCout_test
            );
            
    stimulus: process begin
        for i in 0 to 1 loop
           PCin_test <= not PCin_test;
            for j in 0 to 15 loop
                P4A_test <= P4A_test + 1;
                for k in 0 to 15 loop
                    P4B_test <= P4B_test + 1;
                    wait for 2ns;
                end loop;
            end loop;
        end loop;
    end process;

end architecture;
