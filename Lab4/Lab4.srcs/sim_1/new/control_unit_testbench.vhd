----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.04.2022 21:28:55
-- Design Name: 
-- Module Name: control_unit_testbench - Behavioral
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

entity control_unit_testbench is
--  Port ( );
end control_unit_testbench;

architecture Behavioral of control_unit_testbench is

    constant clk1_period: time := 10ns;
    signal rom_address_test, ram_address_test : std_logic_vector (2 downto 0);
    signal valid_in_test, clk_test, rst_test, we_test, mac_init_test, valid_out_test : std_logic;


    component control_unit is
        Port ( clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               valid_in : in STD_LOGIC;
               rom_address : out STD_LOGIC_VECTOR (2 downto 0);
               ram_address : out STD_LOGIC_VECTOR (2 downto 0);
               we: out STD_LOGIC := '0';
               mac_init : out STD_LOGIC;
               valid_out : out STD_LOGIC);
    end component;

begin

    uut: control_unit
        port map(
            clk=>clk_test,
            rst=>rst_test,
            valid_in=>valid_in_test,
            ram_address=>ram_address_test,
            rom_address=>rom_address_test,
            we => we_test,
            mac_init=>mac_init_test,
            valid_out=>valid_out_test);
    
    stimulus: process begin
        rst_test<='1';
        valid_in_test<='1';
        wait for 5ns;
    end process;
    
    clk1_generator: process begin
            clk_test <= '0';
            wait for clk1_period/2;
            clk_test <= '1';
            wait for clk1_period/2;
    end process;


end Behavioral;
