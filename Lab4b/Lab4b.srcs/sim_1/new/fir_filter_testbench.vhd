library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity fir_filter_testbench is
end fir_filter_testbench;

architecture fir_test of fir_filter_testbench is
    
    signal count : std_logic_vector(7 downto 0) := (others => '1');
    constant clk1_period: time := 10ns;
    signal clk_test, rst_test, valid_in_test, valid_out_test : std_logic;
    signal x_test : std_logic_vector(7 downto 0);
    signal fir_output_test : std_logic_vector(20 downto 0);
    
    component fir_filter is
      port (clk  : in std_logic;
          rst : in std_logic;
          x : in std_logic_vector(7 downto 0);
          valid_in : in std_logic;
          valid_out : out std_logic;
          result : out std_logic_vector(20 downto 0));	
    end component;
begin
    
    uut: fir_filter 
        port map(
            clk=>clk_test,
            rst=>rst_test,
            x=>x_test,
            valid_in=>valid_in_test,
            valid_out=>valid_out_test,
            result=>fir_output_test);
    
    stimulus: process begin
        
        rst_test <= '0';
        wait for clk1_period/4;
        
        rst_test <= '1';
        valid_in_test <= '1';
        
        for i in 0 to 7 loop
            x_test <= "11111111";
            wait for clk1_period;
        end loop;
        
        wait for 10*clk1_period;
        
        --reset test
        rst_test<='0';
        for i in 0 to 7 loop
            x_test <= "00000001";
            wait for clk1_period;
        end loop;
        
        rst_test<='1';
        
        --valid_in testbench
        for i in 0 to 7 loop
            valid_in_test <= '0';
            wait for 3*clk1_period;
            valid_in_test <= '1';
            wait for clk1_period;
            x_test <= x_test + 1;
        end loop;
        
        for i in 0 to 7 loop
            x_test <= "00000000";
            wait for clk1_period;
        end loop;
        
        --LAB NUMBERS
        valid_in_test <= '1';
        x_test <= "11000010"; --194
        wait for clk1_period;
        
        x_test <= "10111110"; --190
        wait for clk1_period;
        
        x_test <= "01100101"; --101
        wait for clk1_period;
        
        x_test <= "10101000"; --168
        wait for clk1_period;
        
        x_test <= "00101100"; --44
        wait for clk1_period;
        
        x_test <= "10110101"; --181
        wait for clk1_period;
        
        x_test <= "00001001"; --9
        wait for clk1_period;
        
        x_test <= "01000111"; --71
        wait for clk1_period;
        
        x_test <= "00001100"; --12
        wait for clk1_period;
        
        x_test <= "00011001"; --25
        wait for clk1_period;
        
        x_test <= "11010010"; --210
        wait for clk1_period;
        
        x_test <= "10110010"; --178
        wait for clk1_period;
        
        x_test <= "01010001"; --81
        wait for clk1_period;
        
        x_test <= "11110011"; --243
        wait for clk1_period;
        
        x_test <= "00001001"; --9
        wait for clk1_period;
        
        for i in 0 to 7 loop
            x_test <= "00000000";
            wait for clk1_period;
        end loop;
        --END LAB NUMBERS
    end process;
    
    clk1_generator: process begin
            clk_test <= '0';
            wait for clk1_period/2;
            clk_test <= '1';
            wait for clk1_period/2;
    end process;

end fir_test;