----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2022 06:15:23 PM
-- Design Name: 
-- Module Name: exA2 - Behavioral
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

entity decoder_dataflow is
    port(
           decoder_input : in  std_logic_vector(2 downto 0);
           decoder_output : out std_logic_vector(7 downto 0)
          );
end entity;

architecture dataflow_arch of decoder_dataflow is
begin
  with decoder_input select decoder_output <=
    "00000001" when "000",
    "00000010" when "001",
    "00000100" when "010",
    "00001000" when "011",
    "00010000" when "100",
    "00100000" when "101",
    "01000000" when "110",
    "10000000" when "111",
    "--------" when others;
end architecture;
