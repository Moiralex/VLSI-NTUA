library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity testbench_counter_with_signals is
end testbench_counter_with_signals;

architecture Behavioral of testbench_counter_with_signals is
    signal en_test, clk_test, rst_test, equals_zero_test, equals_N_minus_1_test: std_logic;
    signal counter_out_test: STD_LOGIC_VECTOR(9 downto 0);
    signal clk_counter : std_logic_vector (9 downto 0) := (others => '0');
    constant clk1_period : time := 1 ns;
    
    
    component counter_with_signals is
    generic (
        N : STD_LOGIC_VECTOR(11 downto 0)
    );
    Port ( en : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst: in STD_LOGIC;
           equals_zero : out STD_LOGIC := '1';
           equals_N_minus_1 : out STD_LOGIC := '0');
    end component;
begin
    uut : counter_with_signals
    generic map (N => "0000100000")
    PORT MAP (
        en  => en_test,
        clk => clk_test,
        rst => rst_test,
        equals_zero => equals_zero_test,
        equals_N_minus_1 => equals_N_minus_1_test
      );
    
    stimulus: process begin
        rst_test <= '1';
        en_test <= '1';
        for i in 0 to 68 loop
            
            wait for clk1_period;
            clk_counter <= clk_counter +1;
        end loop;
        
        rst_test <='0';
        wait for clk1_period;
        clk_counter <= clk_counter +1;
        rst_test<='1';
        
        for i in 0 to 68 loop
            wait for clk1_period;
            clk_counter <= clk_counter +1;
        end loop;
        --wr_en_test <= '0';
        --wait for 10*clk1_period;
        wait;
    end process;
  
    
    clk1_generator: process begin
            clk_test <= '0';
            wait for clk1_period/2;
            clk_test <= '1';
            wait for clk1_period/2;
        end process;
end Behavioral;