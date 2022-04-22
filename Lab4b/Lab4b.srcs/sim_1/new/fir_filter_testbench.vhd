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
        rst_test <= '1';
        valid_in_test <= '1';
        
        for i in 0 to 7 loop
            x_test <= "11111111";
            wait for clk1_period;
        end loop;
        
        for i in 0 to 7 loop
            x_test <= "00000000";
            wait for clk1_period;
        end loop;
            
    end process;
    
    clk1_generator: process begin
            clk_test <= '0';
            wait for clk1_period/2;
            clk_test <= '1';
            wait for clk1_period/2;
    end process;

end fir_test;