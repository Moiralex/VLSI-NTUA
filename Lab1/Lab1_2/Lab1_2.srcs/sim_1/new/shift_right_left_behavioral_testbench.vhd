library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity shift_right_left_behavioral_testbench is
end shift_right_left_behavioral_testbench;

architecture B2_test of shift_right_left_behavioral_testbench is
    
    constant clk1_period : time := 1 ns;
    signal clk_test,rst_test,si_test,en_test,pl_test,control_test : std_logic := '0';
    signal din_test : std_logic_vector(3 downto 0) := (others => '0');
    signal so_test : std_logic := '0';
    
    component shift_right_left_behavioral is
        port (
            clk,rst,si,en,pl, control: in std_logic;
            din: in std_logic_vector(3 downto 0);
            so: out std_logic);
    end component;
begin
    uut: shift_right_left_behavioral
        port map (
            clk => clk_test,
            rst => rst_test,
            si => si_test,
            en => en_test,
            pl => pl_test,
            control => control_test,
            din => din_test,
            so => so_test
        );

    stimulus: process begin
        for i in 0 to 1 loop
            rst_test <= not rst_test;
            for j in 0 to 1 loop
                si_test <= not si_test;
                for k in 0 to 1 loop
                    en_test <= not en_test; 
                    for l in 0 to 1 loop
                        pl_test <= not pl_test;    
                        for m in 0 to 1 loop
                            control_test <= not control_test; 
                            for n in 0 to 15 loop
                                 din_test <= std_logic_vector( unsigned(din_test) + 1 );
                                 wait for 1500ps;
                            end loop;
                        end loop;
                    end loop;
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
