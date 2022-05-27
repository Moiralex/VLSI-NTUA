library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity testbench_fifo_with_almost_full_flag_N_32 is
end testbench_fifo_with_almost_full_flag_N_32;

architecture Behavioral of testbench_fifo_with_almost_full_flag_N_32 is
    signal clk_test, srst_test, wr_en_test, valid_test : std_logic;
    --signal rd_en_test, full_test, empty_test, almost_full_test: std_logic;
    signal din_test : std_logic_vector(7 downto 0) := (others=>'1');
    signal system_out_test : std_logic_vector(7 downto 0);
    constant clk1_period : time := 1 ns;
    signal counter_test : std_logic_vector(11 downto 0) := (others=>'0');
    
    COMPONENT custom_fifo_with_almost_full_flag_N_32 is
        PORT (
            clk : IN STD_LOGIC;
            srst : IN STD_LOGIC;
            din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            wr_en : IN STD_LOGIC;
            system_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            valid : OUT STD_LOGIC;
            counter : inout std_logic_vector(11 downto 0) := (others=>'0')
          );
    END COMPONENT;
begin
    uut : custom_fifo_with_almost_full_flag_N_32
    PORT MAP (
        clk => clk_test,
        srst => srst_test,
        din => din_test,
        wr_en => wr_en_test,
        system_out => system_out_test,
        valid => valid_test,
        counter => counter_test
      );
    
    stimulus: process begin
        wr_en_test <= '1';
        for i in 0 to 1023 loop
            wr_en_test <= '1';
            din_test <= din_test + 1;
            wait for clk1_period;
            wr_en_test <= '0';
            wait for 2*clk1_period;
        end loop;
        wr_en_test <= '0';
        wait for clk1_period;
        
        for i in 0 to 40 loop
            wr_en_test <= '1';
            din_test <= din_test + 1;
            wait for clk1_period;
            wr_en_test <= '0';
            wait for 2*clk1_period;
        end loop;
        
        srst_test <= '1';
        wait for clk1_period;
        srst_test <= '0';
        
        for i in 0 to 40 loop
            wr_en_test <= '1';
            din_test <= din_test + 1;
            wait for clk1_period;
            wr_en_test <= '0';
            wait for 2*clk1_period;
        end loop;
        wait;
        --wr_en_test <= '0';
        --wait for 10*clk1_period;
    end process;
    
    clk1_generator: process begin
            clk_test <= '0';
            wait for clk1_period/2;
            clk_test <= '1';
            wait for clk1_period/2;
        end process;
end Behavioral;
