----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.05.2022 20:11:31
-- Design Name: 
-- Module Name: counter_with_signals - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity counter_with_signals is
    generic (
        N : STD_LOGIC_VECTOR(9 downto 0)
    );
    Port ( en : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst: in STD_LOGIC;
           equals_zero : out STD_LOGIC := '1';
           equals_N_minus_1 : out STD_LOGIC := '0');
end counter_with_signals;

architecture Behavioral of counter_with_signals is
signal counter: STD_LOGIC_VECTOR(9 downto 0) := "0000000000";

begin
    process(clk, rst) begin
        if rst='0' then
            counter<=(others=>'0');
        elsif en='1' and (rising_edge(clk)) and counter<N-1 then
            counter <= counter+1;
        elsif en='1' and (rising_edge(clk)) and counter=N-1 then
            counter <= (others=>'0');
        end if;
    end process;
    
    with counter select
        equals_zero <= '1' when "0000000000",
                        '0' when others;
    with counter select
        equals_N_minus_1 <= '1' when N-1,
                        '0' when others;

    --counter_out <= counter;         

end Behavioral;