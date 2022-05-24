library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg_8bit is
    Port ( D : in std_logic_vector(7 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           Q : out std_logic_vector(7 downto 0));
end reg_8bit;

architecture Behavioral of reg_8bit is

begin
    process(clk, rst) begin
        if rst='0' then
            Q<=(others=>'0');
        elsif rising_edge(clk) then
            Q<=D;
        end if;
    end process;
end Behavioral;