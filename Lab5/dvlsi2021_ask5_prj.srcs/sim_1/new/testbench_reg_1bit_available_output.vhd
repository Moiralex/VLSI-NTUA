----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/26/2022 03:56:02 PM
-- Design Name: 
-- Module Name: testbench_reg_1bit_available_output - Behavioral
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

entity testbench_reg_1bit_available_output is
end testbench_reg_1bit_available_output;

architecture Behavioral of testbench_reg_1bit_available_output is

    signal D_test, clk_test, rst_test, Q_test, valid_in_test : std_logic;
    constant clk1_period : time := 1 ns;
    
    component reg_1bit_available_output is
        Port ( D : in STD_LOGIC;
               clk : in STD_LOGIC;
               valid_in : in std_logic;
               rst : in STD_LOGIC;
               Q : out STD_LOGIC);
    end component;

begin
    uut : reg_1bit_available_output
    PORT MAP (
        D => D_test,
        clk => clk_test,
        valid_in => valid_in_test,
        rst => rst_test,
        Q => Q_test
      );
    
    stimulus: process begin
        rst_test <= '1';
        D_test <= '0';
        wait for clk1_period;
        for i in 0 to 10 loop
            valid_in_test <= '0';
            D_test <= not D_test;
            wait for clk1_period;
            valid_in_test <= '1';
            wait for clk1_period;
        end loop;
        
    end process;
    
    clk1_generator: process begin
            clk_test <= '0';
            wait for clk1_period/2;
            clk_test <= '1';
            wait for clk1_period/2;
        end process;

end Behavioral;
