----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/22/2022 01:42:24 AM
-- Design Name: 
-- Module Name: signal_register_20_bit - Behavioral
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

entity signal_register_20_bit is
    Port ( D : in STD_LOGIC_VECTOR (20 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (20 downto 0));
end signal_register_20_bit;

architecture Behavioral of signal_register_20_bit is

begin
    process(clk, rst) begin
        if rst='0' then
            Q<=(others => '0');
        elsif rising_edge(clk) then
            Q<=D;
        end if;
    end process;
end Behavioral;
