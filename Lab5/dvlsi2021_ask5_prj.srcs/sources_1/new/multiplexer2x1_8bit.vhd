library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multiplexer2x1_8bit is
    Port ( D1 : in std_logic_vector(7 downto 0);
           D2 : in std_logic_vector(7 downto 0);
           rst : in STD_LOGIC;
           choose : in STD_LOGIC;
           output : out std_logic_vector(7 downto 0));
end multiplexer2x1_8bit;

architecture Behavioral of multiplexer2x1_8bit is

begin
    process(D1, D2, choose, rst) begin
        if rst='0' then
            output<=(others=>'0');
        end if;
        if choose = '0' then
            output<=D1;
        else
            output<=D2;
        end if;
    end process;
end Behavioral;