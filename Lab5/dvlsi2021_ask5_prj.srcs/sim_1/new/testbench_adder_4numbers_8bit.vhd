library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity testbench_adder_4numbers_8bit is
end testbench_adder_4numbers_8bit;

architecture Behavioral of testbench_adder_4numbers_8bit is

    signal A_test, B_test, C_test, D_test, mean_test :STD_LOGIC_VECTOR (7 downto 0);
    signal clk_test, rst_test: std_logic;
    constant clk1_period : time := 1 ns;
    component adder_4numbers_8bit is
        Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
               B : in STD_LOGIC_VECTOR (7 downto 0);
               C : in STD_LOGIC_VECTOR (7 downto 0);
               D : in STD_LOGIC_VECTOR (7 downto 0);
               rst : in STD_LOGIC;
               mean : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
begin
    uut: adder_4numbers_8bit
        port map (
            rst => rst_test,
            A => A_test,
            B => B_test,
            C => C_test,
            D => D_test,
            mean => mean_test
        );
        
    stimulus: process begin
            A_test<=(others=>'1');
            B_test<=(others=>'1');
            C_test<=(others=>'1');
            D_test<=(others=>'1');
            wait for clk1_period;
            
            A_test<="00000101";
            B_test<="00000111";
            C_test<="00001101";
            D_test<="00000111";
            wait for clk1_period;
            
            A_test<="00000100";
            B_test<="00000111";
            C_test<="00001101";
            D_test<="00000111";
            wait for clk1_period;
    end process;
end Behavioral;
