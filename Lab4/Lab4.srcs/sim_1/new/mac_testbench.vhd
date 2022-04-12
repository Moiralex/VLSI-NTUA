----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/12/2022 01:51:02 AM
-- Design Name: 
-- Module Name: mac_testbench - Behavioral
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

entity mac_testbench is
end mac_testbench;

architecture Behavioral of mac_testbench is
    
    constant clk1_period: time := 10ns;
    signal rom_output_test, ram_output_test : std_logic_vector (7 downto 0);
    signal mac_init_test, clk_test, rst_test : std_logic;
    signal mac_output_test : std_logic_vector (19 downto 0);
    
    component mac is
        Port( rom_output : in std_logic_vector (7 downto 0);
            ram_output : in std_logic_vector (7 downto 0);
            mac_init : in std_logic;
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            mac_output : out std_logic_vector (19 downto 0)); 
    end component;
begin
    
    uut: mac
        port map(
            clk=>clk_test,
            rst=>rst_test,
            ram_output=>ram_output_test,
            rom_output=>rom_output_test,
            mac_init=>mac_init_test,
            mac_output=>mac_output_test);
    
    stimulus: process begin
        rst_test <= '1';
        mac_init_test <= '0';
        --wait for 5ps;
        rom_output_test <= "00001111";
        ram_output_test <= "00001111";
        wait for clk1_period;
        --mac_init_test <= '1';
        --wait for 5ps;
        rom_output_test <= "00001111";
        ram_output_test <= "00001111";
        wait for clk1_period;
        mac_init_test <= '1';
        rom_output_test <= "00000001";
        ram_output_test <= "00000010";
        wait for clk1_period;
    end process;
    
    clk1_generator: process begin
            clk_test <= '0';
            wait for clk1_period/2;
            clk_test <= '1';
            wait for clk1_period/2;
    end process;

end Behavioral;