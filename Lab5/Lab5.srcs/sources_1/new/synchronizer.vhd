----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.05.2022 02:22:04
-- Design Name: 
-- Module Name: synchronizer - Structural
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity synchronizer is
    generic (
        N : STD_LOGIC_VECTOR(11 downto 0) := "000000100000"
    );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           early_valid : in STD_LOGIC;
           first_col : out STD_LOGIC;
           last_col : out STD_LOGIC;
           new_line : out STD_LOGIC;
           first_line : out STD_LOGIC;
           last_line : out STD_LOGIC;
           image_finished : out STD_LOGIC);
end synchronizer;

architecture Structural of synchronizer is

component reg_1bit is
    Port ( D : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           Q : out STD_LOGIC);
end component;

component and_gate is
    Port ( X_and : in STD_LOGIC;
           Y_and : in STD_LOGIC;
           Z_and : out STD_LOGIC);
end component;

component and_gate_3inputs is
    Port ( A_and : in STD_LOGIC;
           B_and : in STD_LOGIC;
           C_and : in STD_LOGIC;
           Z_and : out STD_LOGIC);
end component;

component counter_with_signals is
    generic (
        N : STD_LOGIC_VECTOR(11 downto 0)
    );
    Port ( en : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst: in STD_LOGIC;
           equals_zero : out STD_LOGIC := '1';
           equals_N_minus_1 : out STD_LOGIC := '0');
end component;

signal intermediate_last_col, line_counter_en, intermediate_last_line, last_pixel: std_logic;

begin

column_counter: counter_with_signals
    generic map (N=>N) 
    port map (en => early_valid, clk => clk, rst => rst, equals_zero => first_col, equals_N_minus_1 => intermediate_last_col);
    
last_col <= intermediate_last_col;

line_counter_en_gate: and_gate port map (X_and => intermediate_last_col, Y_and => early_valid, Z_and => line_counter_en);
new_line <= line_counter_en;
    
line_counter: counter_with_signals
    generic map (N=>N) 
    port map (en => line_counter_en, clk =>clk, rst => rst, equals_zero => first_line, equals_N_minus_1 => intermediate_last_line);
    
last_line <= intermediate_last_line;

last_pixel_gate: and_gate_3inputs port map (A_and => intermediate_last_col, B_and => intermediate_last_line, C_and => early_valid, Z_and => last_pixel);

image_finished_buffer: reg_1bit port map (D => last_pixel, clk => clk, rst => rst, Q => image_finished);


end Structural;