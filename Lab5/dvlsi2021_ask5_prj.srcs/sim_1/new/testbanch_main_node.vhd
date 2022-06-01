----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.06.2022 10:29:37
-- Design Name: 
-- Module Name: testbanch_main_node - Behavioral
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

entity testbanch_main_node is
end testbanch_main_node;

architecture Behavioral of testbanch_main_node is
    signal clk, rst,  valid_in, rd_check, new_image, valid_out, image_finished : std_logic;
    signal red, blue, green, input : std_logic_vector(7 downto 0);
    constant clk1_period : time := 1 ns;

    component main_node is
      Port (clk : in std_logic;
            rst, valid_in, rd_check, new_image : in std_logic;
            input : in std_logic_vector(7 downto 0);
            red : out std_logic_vector(7 downto 0);
            blue : out std_logic_vector(7 downto 0);
            green : out std_logic_vector(7 downto 0);
            valid_out, image_finished : out std_logic);
    end component;
    
begin

    uut : main_node
      Port map(clk => clk,
            rst => rst, 
            valid_in => valid_in, 
            rd_check => rd_check, 
            new_image => new_image,
            input => input, 
            red => red,
            blue => blue, 
            green =>  green,
            valid_out => valid_out, image_finished => image_finished);
    
    stimulus: process begin

            
    end process;
  
    
    clk1_generator: process begin
            clk <= '0';
            wait for clk1_period/2;
            clk <= '1';
            wait for clk1_period/2;
        end process;
end Behavioral;
