----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2022 09:49:28 PM
-- Design Name: 
-- Module Name: multiplier_four_bit_pipeline_testbench - Behavioral
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

entity multiplier_four_bit_pipeline_testbench is
end multiplier_four_bit_pipeline_testbench;

architecture testbench_multiplier of multiplier_four_bit_pipeline_testbench is
    
    constant clk1_period: time := 3ns;
    signal clk_test, rst_test : std_logic := '0';
    signal A_test, B_test : std_logic_vector(3 downto 0) := "1111";
    signal Pout_test : std_logic_vector(7 downto 0);
    
    component multiplier_four_bit_pipeline is
        Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
               B : in STD_LOGIC_VECTOR (3 downto 0);
               clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               Pout : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
begin  
    uut: multiplier_four_bit_pipeline
        port map(
            A=>A_test,
            B=>B_test,
            clk=>clk_test,
            rst=>rst_test,
            Pout=>Pout_test);
            
    stimulus: process begin
    
        for i in 0 to 1 loop
            rst_test <= not rst_test;
            for j in 0 to 15 loop
                A_test<=A_test + 1;
                for k in 0 to 15 loop
                    B_test<=B_test + 1;
                    wait for clk1_period;
                end loop;
            end loop;
        end loop;
    end process;
    
    clk1_generator: process begin
            clk_test <= '0';
            wait for clk1_period/2;
            clk_test <= '1';
            wait for clk1_period/2;
    end process;

end testbench_multiplier;
