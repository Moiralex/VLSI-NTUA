library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity reg_clk_and_valid_in is
    Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           valid_in : in std_logic;
           rst : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (7 downto 0));
end reg_clk_and_valid_in;

architecture Behavioral of reg_clk_and_valid_in is

begin
    process(clk, rst) begin
        if rst='0' then
            Q<=(others => '0');
        elsif rising_edge(clk) and valid_in = '1' then
            Q<=D;
        end if;
    end process;
end Behavioral;