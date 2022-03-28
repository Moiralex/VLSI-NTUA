----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.03.2022 17:03:32
-- Design Name: 
-- Module Name: full_adder_behavioral - Behavioral
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

entity full_adder_behavioral is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Cin : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           S : out STD_LOGIC;
           Cout : out STD_LOGIC);
end full_adder_behavioral;

architecture Behavioral of full_adder_behavioral is

begin
    process(clk, rst)
    begin
        if rst='0' then 
            S<='0';
            Cout<='0';
        elsif rising_edge(clk) then
            if ((A='1' and B='1' and Cin='0') or (A='0' and B='1' and Cin='1') or (A='1' and B='0' and Cin='1') or (A='1' and B='1' and Cin='1')) then
                Cout<='1';
            else
                Cout<='0';
            end if;
            
            if ((A='1' and B='0' and Cin='0') or (A='0' and B='1' and Cin='0') or (A='0' and B='0' and Cin='1') or (A='1' and B='1' and Cin='1')) then
                S<='1';
            else
                S<='0';
            end if;
        end if;
    end process;
            
end Behavioral;
