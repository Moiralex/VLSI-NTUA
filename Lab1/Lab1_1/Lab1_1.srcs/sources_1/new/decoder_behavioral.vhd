----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2022 08:51:02 PM
-- Design Name: 
-- Module Name: decoder_behavioral - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder_behavioral is
    port(
           decoder_input : in  std_logic_vector(2 downto 0);
           decoder_output : out std_logic_vector(7 downto 0)
          );
end entity;

architecture behavioral_arch of decoder_behavioral is

begin

  MUX_LOGIC : process(decoder_input)
  begin
    case decoder_input is
      when "000" =>
        decoder_output <= "00000001";
      when "001" =>
        decoder_output <= "00000010";
      when "010" =>
        decoder_output <= "00000100";
      when "011" =>
        decoder_output <= "00001000";
      when "100" =>
        decoder_output <= "00010000";
      when "101" =>
        decoder_output <= "00100000";
      when "110" =>
        decoder_output <= "01000000";
      when "111" =>
        decoder_output <= "10000000";
      when others =>
        decoder_output <= (others => '-');
    end case;
  end process;

end architecture ; -- arch

