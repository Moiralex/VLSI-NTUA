library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity testbench_fifo_with_almost_full_flag_N_32 is
end testbench_fifo_with_almost_full_flag_N_32;

architecture Behavioral of testbench_fifo_with_almost_full_flag_N_32 is
    signal clk_test, srst_test, wr_en_test, valid_test, new_image_test : std_logic;
    --signal rd_en_test, full_test, empty_test, almost_full_test: std_logic;
    signal din_test : std_logic_vector(7 downto 0) := (others=>'1');
    signal system_out_test : std_logic_vector(7 downto 0);
    constant clk1_period : time := 10 ns;
    signal counter_test, counter_in_test : std_logic_vector(11 downto 0) := (others=>'0');
    
    COMPONENT custom_fifo_with_almost_full_flag_N_32 is
        PORT (
            clk : IN STD_LOGIC;
            srst : IN STD_LOGIC;
            din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            wr_en : IN STD_LOGIC;
            new_image2 : in std_logic;
            --wr_enabled : out std_logic;
            system_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            valid_out : OUT STD_LOGIC;
            counter : inout std_logic_vector(11 downto 0) := (others=>'0');
            counter_in : inout std_logic_vector(11 downto 0) := (others=>'0')
          );
    END COMPONENT;
begin
    uut : custom_fifo_with_almost_full_flag_N_32
    PORT MAP (
        clk => clk_test,
        srst => srst_test,
        din => din_test,
        wr_en => wr_en_test,
        new_image2 => new_image_test,
        --wr_enabled => wr_enabled_test,
        system_out => system_out_test,
        valid_out => valid_test,
        counter => counter_test,
        counter_in => counter_in_test
      );
    
    stimulus: process begin
        srst_test <= '0';
        new_image_test <= '0';
        wait for clk1_period;
        new_image_test <= '1';
        wait for clk1_period;
        new_image_test <= '0';
        wr_en_test <= '1';
        
        for i in 0 to 1023 loop
            --wr_en_test <= '1';
            din_test <= din_test + 1;
            wait for clk1_period;
            --wr_en_test <= '0';
            --wait for 2*clk1_period;
        end loop;
        --wr_en_test <= '0';
        
        din_test <= din_test + 2;
        wait for clk1_period;
        din_test <= din_test + 2;
        --new_image_test <= '1';
        --wait for 40*clk1_period;
        --new_image_test <= '0';
        
        new_image_test <= '1';
        wait for clk1_period;
        new_image_test <= '0';
        
        for i in 0 to 40 loop
            --wr_en_test <= '1';
            din_test <= din_test + 1;
            wait for clk1_period;
            --wr_en_test <= '0';
            --wait for 2*clk1_period;
        end loop;
        
        ---sychronous rst test
        srst_test <= '1';
        wait for clk1_period;
        din_test <= (others => '1');
        srst_test <= '0';
        
        new_image_test <= '1';
        wait for clk1_period;
        new_image_test <= '0';
        for i in 0 to 1023 loop
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
