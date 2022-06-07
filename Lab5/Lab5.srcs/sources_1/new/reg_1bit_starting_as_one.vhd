library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity reg_1bit_starting_as_one is
    Port ( D : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           Q : out STD_LOGIC :='1');
end reg_1bit_starting_as_one;

architecture Behavioral of reg_1bit_starting_as_one is

begin
    process(clk, rst) begin
        if rst='0' then
            Q<='0';
        elsif rising_edge(clk) then
            Q<=D;
        end if;
    end process;
end Behavioral;