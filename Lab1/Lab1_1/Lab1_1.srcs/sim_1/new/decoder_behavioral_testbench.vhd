----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2022 06:39:43 PM
-- Design Name: 
-- Module Name: decoder_dataflow_testbench - dataflow
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
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder_behavioral_testbench is
end decoder_behavioral_testbench;

architecture test of decoder_behavioral_testbench is
    
    signal input : std_logic_vector(2 downto 0) := (others => '0');
    signal output : std_logic_vector(7 downto 0) := (others => '0');
    
    component decoder_behavioral is
        port(
               decoder_input : in  std_logic_vector(2 downto 0);
               decoder_output : out std_logic_vector(7 downto 0)
              );
    end component;
begin
    uut: decoder_behavioral
        port map (
        decoder_input => input,
        decoder_output => output
        );

    stimulus: process begin
         input <= "000";
         wait for 2ns;      
         input <= "001";
         wait for 2ns;  
         input <= "010";
         wait for 2ns;  
         input <= "011";
         wait for 2ns;  
         input <= "100";
         wait for 2ns;  
         input <= "101";
         wait for 2ns;  
         input <= "110";
         wait for 2ns;  
         input <= "111";
         wait for 2ns;  
    end process;
end architecture;