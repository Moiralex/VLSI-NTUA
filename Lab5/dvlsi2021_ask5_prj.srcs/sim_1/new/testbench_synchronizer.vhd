----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.05.2022 14:48:58
-- Design Name: 
-- Module Name: testbench_synchronizer - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testbench_synchronizer is
--  Port ( );
end testbench_synchronizer;

architecture Behavioral of testbench_synchronizer is

component synchronizer is
    generic (
        N : STD_LOGIC_VECTOR(9 downto 0)
    );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           early_valid : in STD_LOGIC;
           first_col : out STD_LOGIC;
           last_col : out STD_LOGIC;
           new_line : out STD_LOGIC;
           first_line : out STD_LOGIC;
           last_line : out STD_LOGIC;
           image_finished : out STD_LOGIC);
end component;

    signal clk_test, rst_test, early_valid_test, first_col_test, last_col_test, new_line_test, first_line_test, last_line_test, image_finished_test: std_logic;
    signal clk_counter : std_logic_vector(12 downto 0) := (others => '0');
    constant clk1_period : time := 1 ns;

begin
    uut: synchronizer
        generic map (N=>"0000100000")
        port map (
            clk => clk_test,
            rst => rst_test,
            early_valid => early_valid_test,
            first_col => first_col_test,
            last_col => last_col_test,
            new_line => new_line_test,
            first_line => first_line_test,
            last_line => last_line_test,
            image_finished => image_finished_test);
            
        stimulus: process begin
            rst_test <= '1';
            early_valid_test <= '1';
            for i in 0 to 1024 loop
                wait for clk1_period/2;
                clk_counter <= clk_counter + 1;
                wait for clk1_period/2;
            end loop;
            
            rst_test <= '0';
            
            for i in 0 to 5 loop
                wait for clk1_period/2;
                clk_counter <= clk_counter + 1;
                wait for clk1_period/2;
            end loop;
            
            rst_test <= '1';
            for i in 0 to 1024 loop
                wait for clk1_period/2;
                clk_counter <= clk_counter + 1;
                wait for clk1_period/2;
            end loop;
            
            wait;
            



        end process;
    
    clk1_generator: process begin
            clk_test <= '0';
            wait for clk1_period/2;
            clk_test <= '1';
            wait for clk1_period/2;
        end process;
            

end Behavioral;
