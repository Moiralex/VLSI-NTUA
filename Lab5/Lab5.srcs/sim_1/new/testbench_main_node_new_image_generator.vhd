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
use std.textio.all;

entity testbench_main_node_new_image_generator is
end testbench_main_node_new_image_generator;

architecture Behavioral of testbench_main_node_new_image_generator is
    signal clk, rst,  tmp_tvalid, valid_out, image_finished : std_logic;
    signal input_read : std_logic_vector(7 downto 0) := (others => '0');
    signal tdata_output : std_logic_vector(31 downto 0);
    constant clk1_period : time := 1 ns;
    --signal value_read: std_logic_vector(7 downto 0);
    signal red_test : std_logic_vector(7 downto 0);
    signal green_test : std_logic_vector(7 downto 0);
    signal blue_test : std_logic_vector(7 downto 0);
    signal valid_in_test, new_image_test : std_logic;
    signal clk_counter : std_logic_vector (12 downto 0) := (others => '0');
    signal counter_in :  std_logic_vector(20 downto 0);
    --debug
    signal next_state: std_logic_vector(1 downto 0);
    --debug

    component main_node_new_image_generator is
    generic (N: std_logic_vector(11 downto 0) := "000000100000");
    port(clk : in std_logic;
        rst, tmp_tvalid: in std_logic;
        input : in std_logic_vector(7 downto 0);
        tdata_output : out std_logic_vector(31 downto 0);
        --debug
        red_test : out std_logic_vector(7 downto 0);
        green_test : out std_logic_vector(7 downto 0);
        blue_test : out std_logic_vector(7 downto 0);
        valid_in_test, new_image_test : out std_logic;
        next_state: out std_logic_vector(1 downto 0);
        counter_in : inout std_logic_vector(20 downto 0);
        --debug
        valid_out, image_finished : out std_logic);
    end component;
    
    
begin

    uut : main_node_new_image_generator

      generic map (N => "000001000000")
      Port map(clk => clk,
            rst => rst, 
            tmp_tvalid => tmp_tvalid,  
            input => input_read, 
            tdata_output => tdata_output,
            --debug
            red_test => red_test,
            green_test => green_test,
            blue_test => blue_test,
            valid_in_test => valid_in_test,
            new_image_test => new_image_test,
            next_state => next_state,
            counter_in => counter_in,
            --debug
            valid_out => valid_out, image_finished => image_finished);
    
    stimulus: process 
    
        file test_file : text open read_mode is "bayer32x32.txt";
        variable row : line;
        variable v_data_read : integer;
    begin
        tmp_tvalid <= '0';
        rst <= '0';
        wait for 100ns;
        rst <= '1';
        wait for 100ns;

         
--        tmp_tvalid <= '1';
        --wait for clk1_period/4 ;
        --new_image <= '1';
--        wait for clk1_period/2;
--        clk_counter <= clk_counter + 1;
--        wait for clk1_period/2;

    
        --for i in 1 to 1023 loop
        --    readline(test_file, row);
        --    read(row, v_data_read);
        --    input_read <= std_logic_vector(to_unsigned(v_data_read, 8));
        --    wait for clk1_period/2;
        --        clk_counter <= clk_counter + 1;
        --        wait for clk1_period/2;
        --end loop;
--        for i in 1 to 1024 loop
--            readline(test_file, row);
--            read(row, v_data_read);
--            input_read <= std_logic_vector(to_unsigned(v_data_read, 8));
--            tmp_tvalid <= '1';
--            clk_counter <= clk_counter + 1;
--            wait for clk1_period;
--        end loop;
        
        input_read <= (others=>'0');
        for i in 0 to 4095 loop
            
            tmp_tvalid <= '1';
            wait for clk1_period;
            input_read <= input_read+1;
        end loop;
        tmp_tvalid <='0';
        
        wait; 
        
            
    end process;
  
    
    clk1_generator: process begin
            clk <= '0';
            wait for clk1_period/2;
            clk <= '1';
            wait for clk1_period/2;
        end process;
end Behavioral;