library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity shift_right_left_behavioral is
    port (
    clk,rst,si,en,pl, control: in std_logic;
    din: in std_logic_vector(3 downto 0);
    so: out std_logic);
end shift_right_left_behavioral;

architecture rtl of shift_right_left_behavioral is
    signal dff: std_logic_vector(3 downto 0);
begin
    edge: process (clk,rst)
    begin
    if rst='0' then
        dff<=(others=>'0');
    elsif clk'event and clk='1' then
        if pl='1' then
            dff<=din;
        elsif en='1' and control='0' then
            dff<=si&dff(3 downto 1);
        elsif en='1' and control='1' then
            dff<=dff(2 downto 0)&si;
        end if;
    end if;
    end process;
    
    with control select so <=
        dff(0) when '0',
        dff(3) when '1',
        '-' when others;
end rtl;
