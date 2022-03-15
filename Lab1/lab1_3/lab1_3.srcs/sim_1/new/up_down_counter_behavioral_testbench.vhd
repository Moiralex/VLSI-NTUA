library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity up_down_counter_behavioral_testbench is
end up_down_counter_behavioral_testbench;

architecture B3_test of up_down_counter_behavioral_testbench is
    
    constant clk1_period : time := 20 ns;
    signal clk_test,rst_test,en_test,control_test : std_logic := '0';
    signal sum_test : std_logic_vector(2 downto 0) := (others => '0');
    signal cout_test : std_logic;
    
    component up_down_counter_behavioral is
    port( clk,
        resetn,
        count_en : in std_logic;
        sum : out std_logic_vector(2 downto 0);
        control: in std_logic;
        cout : out std_logic);
    end component;
begin
    uut: up_down_counter_behavioral
        port map (
            clk => clk_test,
            resetn => rst_test,
            count_en => en_test,
            control => control_test,
            sum => sum_test,
            cout => cout_test
        );

    stimulus: process begin
        for i in 0 to 1 loop
            rst_test <= not rst_test;
            for k in 0 to 1 loop
                en_test <= not en_test;  
                for m in 0 to 1 loop
                    control_test <= not control_test; 
                    wait for 180ns;
                end loop;
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

