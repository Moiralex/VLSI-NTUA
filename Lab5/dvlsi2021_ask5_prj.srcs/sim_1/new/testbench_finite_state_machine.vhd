----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/25/2022 12:19:16 AM
-- Design Name: 
-- Module Name: testbench_finite_state_machine - Behavioral
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
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity testbench_finite_state_machine is
end testbench_finite_state_machine;

architecture Behavioral of testbench_finite_state_machine is
    
    signal early_valid_test, line0_test, rst_test, clk_test: std_logic;
    signal y_test : std_logic_vector(1 downto 0);
    constant clk1_period : time := 1 ns;
    
    component finite_state_machine is
        port ( early_valid, line0, rst, clk : in std_logic;
               y : out std_logic_vector(1 downto 0));
    end component;
begin
    
    uut:finite_state_machine
        port map(  early_valid => early_valid_test, 
                line0 => line0_test, 
                rst => rst_test, 
                clk => clk_test,
                y => y_test);
    
    stimulus: process begin
            rst_test <= '1';
            wait for 2*clk1_period;
            rst_test <= '0';
            
            early_valid_test <= '0';
            line0_test <='0';
            wait for 2*clk1_period;
            
            early_valid_test <= '1';
            wait for 4*clk1_period;
            
            line0_test <= '1';
            wait for 6*clk1_period;
    end process;
    
    clk1_generator: process begin
            clk_test <= '0';
            wait for clk1_period/2;
            clk_test <= '1';
            wait for clk1_period/2;
        end process;
end Behavioral;
