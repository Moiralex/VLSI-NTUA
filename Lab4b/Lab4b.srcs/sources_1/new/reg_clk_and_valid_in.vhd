----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/22/2022 02:33:27 AM
-- Design Name: 
-- Module Name: reg_clk_and_valid_in - Behavioral
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
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/22/2022 02:10:29 AM
-- Design Name: 
-- Module Name: reg - Behavioral
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

entity reg_clk_and_valid_in is
    Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           valid_in : in std_logic;
           rst : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (7 downto 0));
end reg_clk_and_valid_in;

architecture Behavioral of reg_clk_and_valid_in is

begin
    process(clk, rst) begin
        if rst='0' then
            Q<=(others => '0');
        elsif rising_edge(clk) and valid_in = '1' then
            Q<=D;
        end if;
    end process;
end Behavioral;