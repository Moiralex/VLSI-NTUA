library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity reg_clk_and_valid_in_1bit is
    Port ( D : in STD_LOGIC;
           clk : in STD_LOGIC;
           valid_in : in std_logic;
           rst : in STD_LOGIC;
           Q : out STD_LOGIC :='0');
end reg_clk_and_valid_in_1bit;

architecture Behavioral of reg_clk_and_valid_in_1bit is

begin
    process(clk, rst) begin
        if rst='0' then
            Q<='0';
        elsif rising_edge(clk) and valid_in = '1' then
            Q<=D;
        end if;
    end process;
end Behavioral;