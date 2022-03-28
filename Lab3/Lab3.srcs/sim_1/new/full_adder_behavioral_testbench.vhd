----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.03.2022 17:19:18
-- Design Name: 
-- Module Name: full_adder_structural_testbench - test_full_adder
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

entity full_adder_structural_testbench is
end full_adder_structural_testbench;

architecture test_full_adder of full_adder_structural_testbench is

constant clk1_period: time := 27ns;
signal clk_test, rst_test :std_logic := '0';
signal A_test, B_test, Cin_test :std_logic := '0';
signal S_test, Cout_test: std_logic;

component full_adder_behavioral is
    port(
        A, B, Cin, clk, rst: in std_logic;
        S, Cout: out std_logic
        );
end component;

begin
    uut: full_adder_behavioral
        port map(
            A=>A_test,
            B=>B_test,
            Cin => Cin_test,
            clk=>clk_test,
            rst=>rst_test,
            S=>S_test,
            Cout=>Cout_test
            );
    stimulus: process begin
    
        for i in 0 to 1 loop
            rst_test <= not rst_test;
            wait for 20ns;
            
            A_test<='0';
            B_test<='0';
            Cin_test<='0';
            wait for 50ns;
            A_test<='0';
            B_test<='0';
            Cin_test<='1';
            wait for 50ns;
            A_test<='0';
            B_test<='1';
            Cin_test<='0';
            wait for 50ns;
            A_test<='0';
            B_test<='1';
            Cin_test<='1';
            wait for 50ns;
            A_test<='1';
            B_test<='0';
            Cin_test<='0';
            wait for 50ns;
            A_test<='1';
            B_test<='0';
            Cin_test<='1';
            wait for 50ns;
            A_test<='1';
            B_test<='1';
            Cin_test<='0';
            wait for 50ns;
            A_test<='1';
            B_test<='1';
            Cin_test<='1';
            wait for 50ns;
        end loop;
    end process;
    
    clk1_generator: process begin
            clk_test <= '0';
            wait for clk1_period/2;
            clk_test <= '1';
            wait for clk1_period/2;
    end process;

end architecture;
