----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/31/2022 10:31:00 PM
-- Design Name: 
-- Module Name: testbench_fifo_with_registers - Behavioral
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

entity testbench_fifo_with_registers is
end testbench_fifo_with_registers;
    
architecture Behavioral of testbench_fifo_with_registers is
    
    signal reg_output_1_1 , reg_output_1_2 , reg_output_1_3, reg_output_2_1, reg_output_2_2, reg_output_2_3,
     reg_output_3_1, reg_output_3_2, reg_output_3_3: STD_LOGIC_VECTOR(7 DOWNTO 0); 
    signal input : STD_LOGIC_VECTOR(7 DOWNTO 0) := (others=>'0');
    signal clk, rst, valid_in, new_image, full : std_logic;
    signal counter_in :  std_logic_vector(10 downto 0) := (others=>'0'); 
    signal counter_out_fifo3 :  std_logic_vector(10 downto 0) := (others=>'0');
    constant clk1_period : time := 10 ns;
        
    component fifo_with_registers is
      Port ( clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            valid_in : IN STD_LOGIC;
            input : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            new_image : IN STD_LOGIC;
            full : out STD_LOGIC;
            reg_output_1_1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            reg_output_1_2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            reg_output_1_3 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            reg_output_2_1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            reg_output_2_2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            reg_output_2_3 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            reg_output_3_1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            reg_output_3_2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            reg_output_3_3 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            counter_in : inout std_logic_vector(10 downto 0) := (others=>'0'); 
            counter_out_fifo3 : inout std_logic_vector(10 downto 0) := (others=>'0')
          );
    end component;

begin

uut : fifo_with_registers
    PORT MAP (
        clk => clk,
        rst => rst,
        valid_in => valid_in,
        input => input,
        new_image => new_image,
        full=>full,
        --wr_enabled => wr_enabled_test,
        reg_output_1_1 => reg_output_1_1,
        reg_output_1_2 => reg_output_1_2,
        reg_output_1_3 => reg_output_1_3,
        reg_output_2_1 => reg_output_2_1,
        reg_output_2_2 => reg_output_2_2,
        reg_output_2_3 => reg_output_2_3,
        reg_output_3_1 => reg_output_3_1,
        reg_output_3_2 => reg_output_3_2,
        reg_output_3_3 => reg_output_3_3,
        counter_in => counter_in,
        counter_out_fifo3 => counter_out_fifo3
      );  
        
    stimulus: process begin
        valid_in <= '1';
        input <= "00001111";
        wait for clk1_period;
        input <= "01001111";
        wait for clk1_period;
        input <= "00000000";
        wait for clk1_period;
        rst <= '0';
        new_image <= '1';
        
        wait for clk1_period;
        new_image <= '0';
        
        for i in 0 to 1023 loop
            --wr_en_test <= '1';
            input <= input + 1;
            wait for clk1_period;
            --wr_en_test <= '0';
            --wait for 2*clk1_period;
        end loop;
        --wr_en_test <= '0';
        
        wait for 10*clk1_period;
    end process;
    
    clk1_generator: process begin
            clk <= '0';
            wait for clk1_period/2;
            clk <= '1';
            wait for clk1_period/2;
    end process;
end Behavioral;
