----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.04.2022 23:56:00
-- Design Name: 
-- Module Name: control_unit - Behavioral
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control_unit is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           valid_in : in STD_LOGIC;
           rom_address : out STD_LOGIC_VECTOR (2 downto 0);
           ram_address : out STD_LOGIC_VECTOR (2 downto 0);
           we: out STD_LOGIC := '0';
           mac_init : out STD_LOGIC;
           valid_out : out STD_LOGIC);
end control_unit;

architecture Behavioral of control_unit is

signal addr_count: std_logic_vector(2 downto 0) := (others => '1');
signal pause: std_logic;

begin

    process(clk, rst)
    begin
        if rst='0' then
            addr_count <= (others => '1');
            valid_out<='0';
            mac_init<='1';        
            
        elsif clk'event and clk='1' then
            if pause='1' then --if the system is paused check if valid input has arrived to unpause it
                if valid_in='1' then
                    we<='1';
                    mac_init<='1';
                    pause<='0';
                end if;
            else
                addr_count <= addr_count + 1;
                if addr_count=0 then --calculation data scanned output will be valid the next cycle
                    valid_out<='1';
                    if valid_in='1' then --if new valid data has arrived start new calculation else pause the system
                        we<='1';
                        mac_init<='1';
                    else
                        pause<='1';
                    end if;
                else --we are in the middle of a calculation, not expecting new data
                    valid_out<='0';
                    we<='0';
                    mac_init<='0';
                end if;
            end if;
        end if;
    end process;
    
    ram_address <= addr_count;
    rom_address <= 7-addr_count;

end Behavioral;
