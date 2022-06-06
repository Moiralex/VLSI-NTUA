library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity testbench_adder_2numbers_8bit is
end testbench_adder_2numbers_8bit;

architecture Behavioral of testbench_adder_2numbers_8bit is

    signal A_test, B_test, C_test, D_test, mean_test :STD_LOGIC_VECTOR (7 downto 0);
    signal clk_test, rst_test: std_logic;
    constant clk1_period : time := 1 ns;
    component adder_2numbers_8bit is
        Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
               B : in STD_LOGIC_VECTOR (7 downto 0);

               mean : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
begin
    uut: adder_2numbers_8bit
        port map (
            A => A_test,
            B => B_test,
            mean => mean_test
        );
        
    stimulus: process begin
            A_test<=(others=>'1');
            B_test<=(others=>'1');
            wait for clk1_period;
            
            A_test<="00000101";
            B_test<="00000111";
            wait for clk1_period;
            
            A_test<="00000100";
            B_test<="00000111";
            wait for clk1_period;
    end process;
    
end Behavioral;