----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.06.2022 20:10:28
-- Design Name: 
-- Module Name: testbench_multiplexer4x1_8bit - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testbench_multiplexer4x1_8bit is
--  Port ( );
end testbench_multiplexer4x1_8bit;

architecture Behavioral of testbench_multiplexer4x1_8bit is

constant clk1_period : time := 1 ns;

component multiplexer4x1_8bit is
    Port ( D1 : in std_logic_vector(7 downto 0);
           D2 : in std_logic_vector(7 downto 0);
           D3 : in std_logic_vector(7 downto 0);
           D4 : in std_logic_vector(7 downto 0);
           choose : in std_logic_vector(1 downto 0);
           output : out std_logic_vector(7 downto 0));
end component;

signal D1, D2, D3, D4, output: std_logic_vector(7 downto 0);
signal choose: std_logic_vector(1 downto 0);
signal clk_test: std_logic;

begin

    uut: multiplexer4x1_8bit port map (D1 => D1, D2 => D2, D3 => D3, D4 => D4, choose => choose, output => output);
    
    stimulus: process begin
        D1 <= "10101010";
        D2 <= "00000000";
        D3 <= "11111111";
        D4 <= "11110000";
        
        choose <= "00";
        wait for clk1_period;
        choose <= "01";
        wait for clk1_period;
        choose <= "10";
        wait for clk1_period;
        choose <= "11";
        wait for clk1_period;
        
    end process;
    
    clk1_generator: process begin
            clk_test <= '0';
            wait for clk1_period/2;
            clk_test <= '1';
            wait for clk1_period/2;
    end process;

end Behavioral;
