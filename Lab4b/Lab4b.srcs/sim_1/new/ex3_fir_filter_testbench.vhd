----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/23/2022 11:16:41 PM
-- Design Name: 
-- Module Name: ex3_fir_filter_testbench - Behavioral
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
use ieee.std_logic_unsigned.all;

entity ex3_fir_filter_testbench is
end ex3_fir_filter_testbench;

architecture ex3_fir_test of ex3_fir_filter_testbench is
    
    signal count : std_logic_vector(7 downto 0) := (others => '1');
    constant clk1_period: time := 10ns;
    signal clk_test, rst_test, valid_in_test, valid_out_test : std_logic;
    signal x1_test, x2_test : std_logic_vector(7 downto 0);
    signal first_result_test, second_result_test : std_logic_vector(20 downto 0);
    
    component ex3_fir_filter is
        port (clk  : in std_logic;
              rst : in std_logic;
              x_1 : in std_logic_vector(7 downto 0);
              x_2 : in std_logic_vector(7 downto 0);
              valid_in : in std_logic;
              valid_out : out std_logic;
              first_result : out std_logic_vector(20 downto 0);
              second_result : out std_logic_vector(20 downto 0));	
    end component;
begin
    
    uut: ex3_fir_filter 
        port map(
            clk=>clk_test,
            rst=>rst_test,
            x_1=>x1_test,
            x_2=>x2_test,
            valid_in=>valid_in_test,
            valid_out=>valid_out_test,
            first_result=>first_result_test,
            second_result=>second_result_test);
    
    stimulus: process begin
    
        rst_test <= '0';
        wait for clk1_period/4;
    
        rst_test <= '1';
        valid_in_test <= '1';
        
        for i in 0 to 4 loop
            x1_test <= "11111111";
            x2_test <= "11111111";
            wait for clk1_period;
        end loop;
        
        for i in 0 to 4 loop
            x1_test <= "00000000";
            x2_test <= "00000000";
            wait for clk1_period;
        end loop;
        
        
        --LAB NUMBERS
        valid_in_test <= '1';
        
        x2_test <= "11000010"; --194
        x1_test <= "10111110"; --190
        wait for clk1_period;
        
        x2_test <= "01100101"; --101
        x1_test <= "10101000"; --168
        wait for clk1_period;
        
        x2_test <= "00101100"; --44
        x1_test <= "10110101"; --181
        wait for clk1_period;
        
        x2_test <= "00001001"; --9
        x1_test <= "01000111"; --71
        wait for clk1_period;
        
        x2_test <= "00001100"; --12
        x1_test <= "00011001"; --25
        wait for clk1_period;
        
        x2_test <= "11010010"; --210
        x1_test <= "10110010"; --178
        wait for clk1_period;
        
        x2_test <= "01010001"; --81
        x1_test <= "11110011"; --243
        wait for clk1_period;
        
        x2_test <= "00001001"; --9
        x1_test <= "00000000"; --0
        wait for clk1_period;
        
        for i in 0 to 4 loop
            x2_test <= "00000000";
            x1_test <= "00000000";
            wait for clk1_period;
        end loop;
        
        wait for 11*clk1_period;
    end process;
    
    clk1_generator: process begin
            clk_test <= '0';
            wait for clk1_period/2;
            clk_test <= '1';
            wait for clk1_period/2;
        end process;
end ex3_fir_test;