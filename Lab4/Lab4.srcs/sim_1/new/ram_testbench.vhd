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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ram_testbench is
--  Port ( );
end ram_testbench;

architecture Behavioral of ram_testbench is

    constant clk1_period: time := 10ns;
    signal addr_test : std_logic_vector (2 downto 0);
    signal we_test, clk_test, rst_test, en_test : std_logic;
    signal di_test, do_test : std_logic_vector (7 downto 0);


    component mlab_ram is
	generic (
	   data_width : integer :=8  				--- width of data (bits)
	);
    port (clk  : in std_logic;
          we   : in std_logic;						--- memory write enable
          en   : in std_logic;				--- operation enable
          rst : in std_logic;
          addr : in std_logic_vector(2 downto 0);			-- memory address
          di   : in std_logic_vector(data_width-1 downto 0);		-- input data
          do   : out std_logic_vector(data_width-1 downto 0));		-- output data
    end component;

begin

    uut: mlab_ram
        port map(
            clk=>clk_test,
            rst=>rst_test,
            we=>we_test,
            addr=>addr_test,
            en => en_test,
            di=>di_test,
            do=>do_test);
    
    stimulus: process begin
        rst_test<='1';
        en_test<='1';
        we_test<='1';
        addr_test<="000";
        
        di_test<="00000001";
        wait for clk1_period;
        di_test<="00000010";
        wait for clk1_period;
        di_test<="00000011";
        wait for clk1_period;
        di_test<="00000100";
        wait for clk1_period;
        di_test<="00000101";
        wait for clk1_period;
        di_test<="00000110";
        wait for clk1_period;
        di_test<="00000111";
        wait for clk1_period;
        di_test<="00000010";
        wait for clk1_period;
        
        we_test<='0';
        addr_test<="011";
        wait for clk1_period;
        
        addr_test<="000";
        we_test<='1';
        di_test<="00000001";
        wait for clk1_period;
        
        we_test<='0';
        addr_test<="011";
        wait for clk1_period;
        
        wait;
        
        
        
    end process;
    
    clk1_generator: process begin
            clk_test <= '0';
            wait for clk1_period/2;
            clk_test <= '1';
            wait for clk1_period/2;
    end process;


end Behavioral;