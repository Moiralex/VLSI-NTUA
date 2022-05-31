library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity reg_1bit_available_output is
    Port ( D : in STD_LOGIC;
           clk : in STD_LOGIC;
           valid_in : in std_logic;
           rst : in STD_LOGIC;
           Q : out STD_LOGIC);
end reg_1bit_available_output;

architecture Behavioral of reg_1bit_available_output is
    signal available_output : std_logic := '0';
begin
    process(clk, rst) begin
        if rst='0' then
            Q<='0';
            available_output <= '0';
        else            
            if rising_edge(clk) then 
                if available_output = '1' then
                    Q<=D;
                elsif valid_in = '1' then --prwti fora pou tha gemisei o register meta tha dinei apotelesma gia kathe wr_enable
                    available_output <= '1';
                end if;
            end if;
        end if;
    end process;
end Behavioral;