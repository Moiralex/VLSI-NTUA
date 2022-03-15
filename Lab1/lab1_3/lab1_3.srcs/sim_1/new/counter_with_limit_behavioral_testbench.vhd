library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity counter_with_limit_behavioral_testbench is
end counter_with_limit_behavioral_testbench;

architecture B3_test of counter_with_limit_behavioral_testbench is
    
    constant clk1_period : time := 10 ns;
    signal clk_test,rst_test,en_test : std_logic := '0';
    signal sum_test : std_logic_vector(2 downto 0) := (others => '0');
    signal parallel_in_test : std_logic_vector(2 downto 0) := "111";
    signal cout_test : std_logic;
    
    component counter_with_limit_behavioral is
    port( clk,
        resetn,
        count_en : in std_logic;
        parallel_in : in std_logic_vector(2 downto 0);
        sum : out std_logic_vector(2 downto 0);
        cout : out std_logic);
    end component;
begin
    uut: counter_with_limit_behavioral
        port map (
            clk => clk_test,
            resetn => rst_test,
            count_en => en_test,
            parallel_in => parallel_in_test,
            sum => sum_test,
            cout => cout_test
        );

    stimulus: process begin
        for i in 0 to 1 loop
            rst_test <= not rst_test;
            for k in 0 to 1 loop
                en_test <= not en_test;  
                    wait for 120ns;
                    parallel_in_test <= "101";
                    wait for 120ns;
                    parallel_in_test <= "011";
                    wait for 120ns;
            end loop;
        end loop;
        wait;
    end process;
    
    clk1_generator: process begin
            clk_test <= '0';
            wait for clk1_period/2;
            clk_test <= '1';
            wait for clk1_period/2;
    end process;
    
end architecture;

