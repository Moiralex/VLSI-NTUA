library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity multiplier is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           coeff : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           result : out STD_LOGIC_VECTOR (20 downto 0));
end multiplier;

architecture multiplier_arch of multiplier is

begin
    process(clk, rst) begin
        if rst='0' then
            result<= (others => '0');
        elsif rising_edge(clk) then
            result <= "000000000000000000000" + coeff*A;
        end if;
    end process;
end multiplier_arch;