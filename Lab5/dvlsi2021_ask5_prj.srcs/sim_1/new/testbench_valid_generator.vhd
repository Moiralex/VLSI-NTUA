library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity testbench_valid_generator is
end testbench_valid_generator;

architecture Behavioral of testbench_valid_generator is
    signal valid_in_test, rd_test, clk_test, rst_test, early_valid_test, valid_out_test: std_logic;
    signal clk_counter : std_logic_vector (12 downto 0) := (others => '0');
    constant clk1_period : time := 1 ns;
    
    
    component valid_generator is
    generic (N: std_logic_vector (11 downto 0) := "000000100000");
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           valid_in : in STD_LOGIC;
           rd_check : out STD_LOGIC;
           early_valid : out STD_LOGIC;
           valid_out : out STD_LOGIC);
    end component;
begin
    uut : valid_generator
        generic map ( N => "000000100000")
        PORT MAP (
            clk => clk_test,
            rst => rst_test,
            valid_in => valid_in_test,
            rd_check => rd_test,
            early_valid => early_valid_test,
            valid_out => valid_out_test
          );
    
    stimulus: process begin
            rst_test <= '1';
            valid_in_test <= '1';
            for i in 0 to 16 loop
                wait for clk1_period/2;
                clk_counter <= clk_counter + 1;
                wait for clk1_period/2;
            end loop;
            
            valid_in_test <= '0';
            wait for clk1_period/2;
            clk_counter <= clk_counter + 1;
            wait for clk1_period/2;
            
            valid_in_test <= '1';
            for i in 0 to 16 loop
                wait for clk1_period/2;
                clk_counter <= clk_counter + 1;
                wait for clk1_period/2;
            end loop;
            
            
            for i in 0 to 65 loop
                wait for clk1_period/2;
                clk_counter <= clk_counter + 1;
                wait for clk1_period/2;
            end loop;
            
            rst_test <= '0';
            valid_in_test <= '0';
            
            for i in 0 to 15 loop
                wait for clk1_period/2;
                clk_counter <= clk_counter + 1;
                wait for clk1_period/2;
            end loop;
            
            rst_test <= '1';
            valid_in_test <= '1';
            for i in 0 to 16 loop
                wait for clk1_period/2;
                clk_counter <= clk_counter + 1;
                wait for clk1_period/2;
            end loop;
            
            valid_in_test <= '0';
            for i in 0 to 127 loop
                wait for clk1_period/2;
                clk_counter <= clk_counter + 1;
                wait for clk1_period/2;
            end loop;
            
--            for i in 0 to 5 loop
--                wait for clk1_period/2;
--                clk_counter <= clk_counter + 1;
--                wait for clk1_period/2;
--            end loop;
            
--            rst_test <= '1';
--            for i in 0 to 1024 loop
--                wait for clk1_period/2;
--                clk_counter <= clk_counter + 1;
--                wait for clk1_period/2;
--            end loop;
            
            wait;
    end process;
  
    
    clk1_generator: process begin
            clk_test <= '0';
            wait for clk1_period/2;
            clk_test <= '1';
            wait for clk1_period/2;
        end process;
end Behavioral;