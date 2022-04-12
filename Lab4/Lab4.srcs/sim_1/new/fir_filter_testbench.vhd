----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2022 07:50:33 PM
-- Design Name: 
-- Module Name: fir_filter_testbench - Behavioral
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

entity fir_filter_testbench is
end fir_filter_testbench;

architecture fir_test of fir_filter_testbench is
    
    signal count : std_logic_vector(7 downto 0) := (others => '1');
    constant clk1_period: time := 10ns;
    signal clk_test, rst_test, valid_in_test, valid_out_test : std_logic;
    signal x_test : std_logic_vector(7 downto 0);
    signal fir_output_test : std_logic_vector(19 downto 0);
    
    component fir_filter is
      Port ( clk : in std_logic;
             rst : in std_logic;
             valid_in : in std_logic;
             x : in std_logic_vector(7 downto 0);
             valid_out : out std_logic;
             fir_output : out std_logic_vector (19 downto 0)); 
    end component;
begin
    
    uut: fir_filter 
        port map(
            clk=>clk_test,
            rst=>rst_test,
            valid_in=>valid_in_test,
            x=>x_test,
            valid_out=>valid_out_test,
            fir_output=>fir_output_test);
    
    stimulus: process begin
        rst_test <= '1';
        valid_in_test <= '1';
        
        for i in 0 to 7 loop
            x_test <= "11111111";
            wait for 8*clk1_period;
        end loop;
        
        for i in 0 to 7 loop
            x_test <= "00000000";
            wait for 8*clk1_period;
        end loop;
        
        for i in 0 to 7 loop
            valid_in_test <= '0';
            wait for clk1_period;
            x_test <= x_test + 1;
            valid_in_test <= '1';
            wait for 8*clk1_period;
        end loop;
        
        for i in 0 to 7 loop
            x_test <= "00000000";
            wait for 8*clk1_period;
        end loop;
        
        valid_in_test <= '1';
        x_test <= "00000010"; --2
        wait for 8*clk1_period;
        
        valid_in_test <= '1';
        x_test <= "00000110"; --6
        wait for 8*clk1_period;
        
        valid_in_test <= '1';
        x_test <= "00001010"; --10
        wait for 8*clk1_period;
        
        valid_in_test <= '1';
        x_test <= "00100010"; --34
        wait for 8*clk1_period;
        
        valid_in_test <= '1';
        x_test <= "01000010"; --66
        wait for 8*clk1_period;
        
        valid_in_test <= '1';
        x_test <= "10000010"; --130
        wait for 8*clk1_period;
        
        valid_in_test <= '1';
        x_test <= "00000011"; --3
        wait for 8*clk1_period;
        
        valid_in_test <= '1';
        x_test <= "00000111"; --7
        wait for 8*clk1_period;
    end process;
    
    clk1_generator: process begin
            clk_test <= '0';
            wait for clk1_period/2;
            clk_test <= '1';
            wait for clk1_period/2;
    end process;

end fir_test;