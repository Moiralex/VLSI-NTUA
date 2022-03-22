----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.03.2022 16:16:12
-- Design Name: 
-- Module Name: half_adder_behavioral_testbench - Behavioral
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

entity half_adder_behavioral_testbench is
end half_adder_behavioral_testbench;

architecture Behavioral of half_adder_behavioral_testbench is

signal A_test, B_test :std_logic;
signal S_test, Cout_test: std_logic;

component half_adder_behavioral is
    port(
        A, B: in std_logic;
        S, Cout: out std_logic
        );
end component;

begin
    uut: half_adder_behavioral
        port map(
            A=>A_test,
            B=>B_test,
            S=>S_test,
            Cout=>Cout_test
            );
    stimulus: process begin
        A_test<='0';
        B_test<='0';
        wait for 2ns;
        A_test<='0';
        B_test<='1';
        wait for 2ns;
        A_test<='1';
        B_test<='0';
        wait for 2ns;
        A_test<='1';
        B_test<='1';
        wait for 2ns;
    end process;

end architecture;
