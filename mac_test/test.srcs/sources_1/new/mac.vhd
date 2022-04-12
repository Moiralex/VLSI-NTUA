----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/09/2022 10:53:55 PM
-- Design Name: 
-- Module Name: mac - Behavioral
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

entity mac is
        Port( rom_output : in std_logic_vector (7 downto 0);
            ram_output : in std_logic_vector (7 downto 0);
            mac_init : in std_logic;
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            mac_output : out std_logic_vector (19 downto 0)); --255 X 255 X 8 = 520200 = 1111111000000001000 => 19 bits
end mac;

architecture Behavioral of mac is
    
    signal intermediate: std_logic_vector (19 downto 0) := (others => '0'); --initialized this
    signal tmp1 : std_logic_vector(19 downto 0) := (others => '0');
    signal tmp2 : std_logic_vector(19 downto 0) := (others => '0');
begin
    process(clk, rst)
    begin
        if rst='0' then
            mac_output <= (others => '0');
            intermediate <= (others => '0');
        elsif rising_edge(clk) then
            if mac_init='1' then
               tmp1 <= (others => '0');
            else
                tmp1 <= intermediate;
            end if;
            tmp2 <= tmp1 + rom_output*ram_output;
            intermediate <= tmp2;
            
            --intermediate <= intermediate + rom_output*ram_output;
            --intermediate <= (others => '1');
            --intermediate <= intermediate + 1;
            mac_output <= intermediate;
        end if;
    end process;
end Behavioral;