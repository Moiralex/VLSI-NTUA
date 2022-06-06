----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.06.2022 20:30:42
-- Design Name: 
-- Module Name: testbench_computation_module - Behavioral
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

entity testbench_computation_module is
--  Port ( );
end testbench_computation_module;

architecture Behavioral of testbench_computation_module is

constant clk1_period : time := 1 ns;

component computation_module is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           state : in STD_LOGIC_VECTOR (1 downto 0);
           pixel_0 : in STD_LOGIC_VECTOR (7 downto 0);
           pixel_1 : in STD_LOGIC_VECTOR (7 downto 0);
           pixel_2 : in STD_LOGIC_VECTOR (7 downto 0);
           pixel_3 : in STD_LOGIC_VECTOR (7 downto 0);
           pixel_4 : in STD_LOGIC_VECTOR (7 downto 0);
           pixel_5 : in STD_LOGIC_VECTOR (7 downto 0);
           pixel_6 : in STD_LOGIC_VECTOR (7 downto 0);
           pixel_7 : in STD_LOGIC_VECTOR (7 downto 0);
           pixel_8 : in STD_LOGIC_VECTOR (7 downto 0);
           first_col : in STD_LOGIC;
           last_col : in STD_LOGIC;
           first_row : in STD_LOGIC;
           last_row : in STD_LOGIC;
           red : out STD_LOGIC_VECTOR (7 downto 0);
           green : out STD_LOGIC_VECTOR (7 downto 0);
           blue : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal clk_test, rst, first_col, last_col, first_row, last_row : std_logic;
signal pixel_0, pixel_1, pixel_2, pixel_3, pixel_4, pixel_5, pixel_6, pixel_7, pixel_8, red, green, blue: STD_LOGIC_VECTOR (7 downto 0);
signal state: std_logic_vector(1 downto 0);

begin
    uut: computation_module port map(clk=>clk_test, rst=>rst, state => state, pixel_0 => pixel_0,  pixel_1 => pixel_1, pixel_2 => pixel_2, pixel_3 => pixel_3, pixel_4 => pixel_4, pixel_5 => pixel_5, pixel_6 => pixel_6, pixel_7 => pixel_7, pixel_8 => pixel_8,
                            first_col => first_col, last_col => last_col, first_row => first_row, last_row => last_row, red => red, green => green, blue => blue);

    stimulus: process begin
        rst <= '1';
    
        pixel_0 <= "00010101";
        pixel_1 <= "00011010";
        pixel_2 <= "00010001";
        pixel_3 <= "00011100";
        pixel_4 <= "00011101";
        pixel_5 <= "00000110";
        pixel_6 <= "00000111";
        pixel_7 <= "00011011";
        pixel_8 <= "00011001";
        
        state <= "00";
        first_col <= '1';
        last_col <= '0';
        first_row <= '1';
        last_row <= '0';
        
        wait for clk1_period;
        
        state <= "01";
        first_col <= '0';
        last_col <= '0';
        first_row <= '1';
        last_row <= '0';
        
        wait for clk1_period;
        
        state <= "10";
        first_col <= '0';
        last_col <= '0';
        first_row <= '1';
        last_row <= '0';
        
        wait for clk1_period;
        
        state <= "11";
        first_col <= '0';
        last_col <= '0';
        first_row <= '1';
        last_row <= '0';
        
        
        wait;
        
    end process;



    clk1_generator: process begin
                clk_test <= '0';
                wait for clk1_period/2;
                clk_test <= '1';
                wait for clk1_period/2;
    end process;


end Behavioral;
