----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.05.2022 22:35:24
-- Design Name: 
-- Module Name: valid_generator - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity valid_generator is
    generic (N: std_logic_vector (11 downto 0) := "000000100000");
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           valid_in : in STD_LOGIC;
           rd_check : out STD_LOGIC;
           early_valid : out STD_LOGIC;
           valid_out : out STD_LOGIC);
end valid_generator;

architecture Behavioral of valid_generator is

--COMPONENT c_shift_ram_0
--  PORT (
--    D : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
--    CLK : IN STD_LOGIC;
--    SCLR : IN STD_LOGIC;
--    Q : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
--  );
--END COMPONENT;

COMPONENT fifo_generator_0
  PORT (
    clk : IN STD_LOGIC;
    srst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC
  );
END COMPONENT;

component reg_1bit is
    Port ( D : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           Q : out STD_LOGIC);
end component;

signal not_rst, shift_out_normalized, first_reg_out, early_valid_temp : std_logic;
signal valid_in_vectorized, first_shift_out, shift_out : std_logic_vector(0 downto 0);
signal counter : std_logic_vector (11 downto 0) := (others => '0');
signal wr: std_logic :='1';
signal rd: std_logic :='0';

begin
    process (clk, rst) begin
        if rst='0' then
            counter <= (others => '0');
            wr <= '0';
            rd <= '0';
        elsif rising_edge(clk) then
            if counter<(N+N-2) then
                counter <= counter + 1;
                wr <= '1';
                rd <= '0';
            else
                wr <= '1';
                rd <= '1';
            end if;
        end if;
   end process;

rd_check <= rd;   
not_rst <= not rst;
-- we need total delay of 2N+2 for early valid, 2N+3 for valid_out

valid_in_vectorized(0) <= valid_in;
--first_shift_register: c_shift_ram_0 port map(D=>valid_in_vectorized, CLK => clk, SCLR => not_rst, Q => first_shift_out);
--second_shift_register: c_shift_ram_0 port map(D=>first_shift_out, CLK => clk, SCLR => not_rst, Q => second_shift_out);
our_fifo: fifo_generator_0 port map(clk => clk, srst => not_rst, din => valid_in_vectorized, wr_en => wr, rd_en => rd, dout => shift_out, full => open, empty => open);
shift_out_normalized <= shift_out(0);

first_reg: reg_1bit port map(D => shift_out_normalized, clk => clk, rst => rst, Q => first_reg_out);
second_reg: reg_1bit port map(D => first_reg_out, clk => clk, rst => rst, Q => early_valid_temp);

early_valid <= early_valid_temp;
last_reg: reg_1bit port map(D => early_valid_temp, clk => clk, rst => rst, Q => valid_out);

end Behavioral;
