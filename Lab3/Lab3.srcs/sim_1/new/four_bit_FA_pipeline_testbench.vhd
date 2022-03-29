----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/28/2022 08:36:03 PM
-- Design Name: 
-- Module Name: four_bit_FA_pipeline_testbench - Behavioral
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

entity four_bit_FA_pipeline_testbench is
end four_bit_FA_pipeline_testbench;

architecture test_four_bit_full_adder of four_bit_FA_pipeline_testbench is

    constant clk1_period: time := 270ps;
    signal clk_test, rst_test :std_logic := '0';
    signal Cin_test :std_logic := '0';
    signal A_test, B_test :std_logic_vector(3 downto 0):= "1111";
    signal S_test :std_logic_vector(3 downto 0);
    signal Cout_test: std_logic;
    
    component four_bit_FA_pipeline is
        Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
               B : in STD_LOGIC_VECTOR (3 downto 0);
               Cin : in STD_LOGIC;
               clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               S : out STD_LOGIC_VECTOR (3 downto 0);
               Cout : out STD_LOGIC);
    end component;
begin
     uut: four_bit_FA_pipeline
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
            for l in 0 to 1 loop
                Cin_test <= not Cin_test;
                for j in 0 to 15 loop
                    A_test<= A_test + 1;
                    for k in 0 to 15 loop
                        B_test <= B_test+1;
                        wait for clk1_period;
                    end loop;
                end loop;
            end loop;
        end loop;
        wait;
    end process;
    
    clk1_generator: process begin
            clk_test <= '0';
            wait for clk1_period/2;
            clk_test <= '1';
            wait for clk1_period/2;
    end process;


end test_four_bit_full_adder;