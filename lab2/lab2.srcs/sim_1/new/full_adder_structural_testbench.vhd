----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.03.2022 17:19:18
-- Design Name: 
-- Module Name: full_adder_structural_testbench - test_full_adder
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

entity full_adder_structural_testbench is
end full_adder_structural_testbench;

architecture test_full_adder of full_adder_structural_testbench is

signal FA_test, FB_test, FCin_test :std_logic;
signal FS_test, FCout_test: std_logic;

component full_adder_structural is
    port(
        FA, FB, FCin: in std_logic;
        FS, FCout: out std_logic
        );
end component;

begin
    uut: full_adder_structural
        port map(
            FA=>FA_test,
            FB=>FB_test,
            FCin => FCin_test,
            FS=>FS_test,
            FCout=>FCout_test
            );
    stimulus: process begin
        FA_test<='0';
        FB_test<='0';
        FCin_test<='0';
        wait for 2ns;
        FA_test<='0';
        FB_test<='0';
        FCin_test<='1';
        wait for 2ns;
        FA_test<='0';
        FB_test<='1';
        FCin_test<='0';
        wait for 2ns;
        FA_test<='0';
        FB_test<='1';
        FCin_test<='1';
        wait for 2ns;
        FA_test<='1';
        FB_test<='0';
        FCin_test<='0';
        wait for 2ns;
        FA_test<='1';
        FB_test<='0';
        FCin_test<='1';
        wait for 2ns;
        FA_test<='1';
        FB_test<='1';
        FCin_test<='0';
        wait for 2ns;
        FA_test<='1';
        FB_test<='1';
        FCin_test<='1';
        wait for 2ns;
    end process;

end architecture;
