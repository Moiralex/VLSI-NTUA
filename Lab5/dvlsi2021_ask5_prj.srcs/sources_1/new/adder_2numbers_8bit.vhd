library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity adder_2numbers_8bit is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           mean : out STD_LOGIC_VECTOR (7 downto 0));
end adder_2numbers_8bit;

architecture adder_arch of adder_2numbers_8bit is

begin
    process(A, B)
        variable tmp1: std_logic_vector (8 downto 0);
        begin
            tmp1 := A+B;
            mean<= tmp1(8 downto 1); --divide by 2
    end process;
end adder_arch;