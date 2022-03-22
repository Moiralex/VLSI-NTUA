----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/21/2022 09:14:11 PM
-- Design Name: 
-- Module Name: BCD_full_adder_structural_testbench - Behavioral
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
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BCD_full_adder_structural_testbench is
end BCD_full_adder_structural_testbench;

architecture Behavioral of BCD_full_adder_structural_testbench is

    signal PCin_BCD_test :std_logic := '0';
    signal P4A_BCD_test, P4B_BCD_test : std_logic_vector(3 downto 0) := (others => '1');
    signal PCout_BCD_test: std_logic;
    signal P4S_BCD_test : std_logic_vector(3 downto 0);
    
    component BCD_full_adder_structural is
        Port ( P4A_BCD : in STD_LOGIC_VECTOR (3 downto 0);
           P4B_BCD : in STD_LOGIC_VECTOR (3 downto 0);
           PCin_BCD : in STD_LOGIC;
           P4S_BCD : out STD_LOGIC_VECTOR (3 downto 0);
           PCout_BCD : inout STD_LOGIC);
    end component;
    
begin
 uut: BCD_full_adder_structural
        port map(
            P4A_BCD=>P4A_BCD_test,
            P4B_BCD=>P4B_BCD_test,
            PCin_BCD=>PCin_BCD_test,
            P4S_BCD=>P4S_BCD_test,
            PCout_BCD=>PCout_BCD_test
            );
            
    stimulus: process begin
        for i in 0 to 1 loop
           PCin_BCD_test <= not PCin_BCD_test;
            for j in 0 to 9 loop
                P4A_BCD_test <= P4A_BCD_test + 1;
                for k in 0 to 9 loop
                    P4B_BCD_test <= P4B_BCD_test + 1;
                    wait for 2ns;
                end loop;
                P4B_BCD_test <= "1111"; 
                wait for 2ps;        
            end loop;
            P4A_BCD_test <= "1111";
            wait for 2ps; 
        end loop;
    end process;

end architecture;
