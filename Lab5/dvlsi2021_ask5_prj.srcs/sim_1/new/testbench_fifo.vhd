library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity testbench_fifo is
end testbench_fifo;

architecture Behavioral of testbench_fifo is
    signal clk_test, srst_test, wr_en_test, rd_en_test, full_test, empty_test, valid_test: std_logic;
    signal din_test : std_logic_vector(7 downto 0) := (others=>'0');
    signal dout_test : std_logic_vector(7 downto 0);
    constant clk1_period : time := 1 ns;
    
    --signal dontcare1, dontcare2 : std_logic;
    
    COMPONENT fifo_generator_1
      PORT (
        clk : IN STD_LOGIC;
        srst : IN STD_LOGIC;
        din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        wr_en : IN STD_LOGIC;
        rd_en : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        full : OUT STD_LOGIC;
        almost_full : OUT STD_LOGIC;
        empty : OUT STD_LOGIC;
        valid : OUT STD_LOGIC
      );
    END COMPONENT;
begin
    uut : fifo_generator_1
    PORT MAP (
        clk => clk_test,
        srst => srst_test,
        din => din_test,
        wr_en => wr_en_test,
        rd_en => rd_en_test,
        dout => dout_test,
        full => full_test,
        empty => empty_test,
        valid => valid_test
      );
    
    stimulus: process begin
        wr_en_test <= '1';
        for i in 0 to 68 loop
            din_test <= din_test + 1;
            wait for clk1_period;
        end loop;
        
        srst_test <= '1';
        wait for clk1_period;
        srst_test <= '0';
        
        for i in 0 to 68 loop
            din_test <= din_test + 1;
            wait for clk1_period;
        end loop;
        --wr_en_test <= '0';
        --wait for 10*clk1_period;
    end process;
    
    rd_process: process(full_test) 
                begin
                    rd_en_test <= full_test;
                end process;
    
    clk1_generator: process begin
            clk_test <= '0';
            wait for clk1_period/2;
            clk_test <= '1';
            wait for clk1_period/2;
        end process;
end Behavioral;
