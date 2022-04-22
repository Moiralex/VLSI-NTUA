library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity adder is
    Port ( A : in STD_LOGIC_VECTOR (20 downto 0);
           B : in STD_LOGIC_VECTOR (20 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           result : out STD_LOGIC_VECTOR (20 downto 0));
end adder;

architecture adder_arch of adder is

begin
    process(clk, rst) begin
        if rst='0' then
            result<= (others => '0');
        elsif rising_edge(clk) then
            result<=A+B;
        end if;
    end process;
end adder_arch;