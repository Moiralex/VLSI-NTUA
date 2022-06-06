----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.05.2022 20:22:20
-- Design Name: 
-- Module Name: computation_module - Behavioral
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

entity computation_module is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           state : in STD_LOGIC_VECTOR (1 downto 0);
           pixel_0 : in STD_LOGIC_VECTOR (7 downto 0);
           pixel_1 : in STD_LOGIC_VECTOR (7 downto 0);
           pixel_2 : in STD_LOGIC_VECTOR (7 downto 0);
           pixel_3 : in STD_LOGIC_VECTOR (7 downto 0);
           pixel_4 : in STD_LOGIC_VECTOR (7 downto 0);
           pixel_5 : in STD_LOGIC_VECTOR (7 downto 0);
           pixel_6 : in STD_LOGIC_VECTOR (7 downto 0);
           pixel_7 : in STD_LOGIC_VECTOR (7 downto 0);
           pixel_8 : in STD_LOGIC_VECTOR (7 downto 0);
           first_col : in STD_LOGIC;
           last_col : in STD_LOGIC;
           first_row : in STD_LOGIC;
           last_row : in STD_LOGIC;
           red : out STD_LOGIC_VECTOR (7 downto 0);
           green : out STD_LOGIC_VECTOR (7 downto 0);
           blue : out STD_LOGIC_VECTOR (7 downto 0));
end computation_module;

architecture Structural of computation_module is

component multiplexer2x1_8bit is
    Port ( D1 : in std_logic_vector(7 downto 0);
           D2 : in std_logic_vector(7 downto 0);
           choose : in STD_LOGIC;
           output : out std_logic_vector(7 downto 0));
end component;

component multiplexer4x1_8bit is
    Port ( D1 : in std_logic_vector(7 downto 0);
           D2 : in std_logic_vector(7 downto 0);
           D3 : in std_logic_vector(7 downto 0);
           D4 : in std_logic_vector(7 downto 0);
           choose : in std_logic_vector(1 downto 0);
           output : out std_logic_vector(7 downto 0));
end component;

component adder_2numbers_8bit is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           mean : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component adder_4numbers_8bit is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0):=(others=>'0');
           B : in STD_LOGIC_VECTOR (7 downto 0):=(others=>'0');
           C : in STD_LOGIC_VECTOR (7 downto 0):=(others=>'0');
           D : in STD_LOGIC_VECTOR (7 downto 0):=(others=>'0');
           mean : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component reg_8bit is
    Port ( D : in std_logic_vector(7 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           Q : out std_logic_vector(7 downto 0));
end component;

component or_gate is
    Port ( X : in STD_LOGIC;
           Y : in STD_LOGIC;
           Z : out STD_LOGIC);
end component;

signal left_pixel, right_pixel, top_pixel, bottom_pixel, top_left_pixel, top_right_pixel, bottom_left_pixel, bottom_right_pixel, cross_left_pixel, cross_right_pixel, cross_top_pixel, cross_bottom_pixel : std_logic_vector (7 downto 0);
signal row_result, column_result, corners_result, cross_result : std_logic_vector (7 downto 0);
signal red_result, green_result, blue_result : std_logic_vector (7 downto 0);
signal or1, or2, or3, or4: std_logic;

begin

-- neighborhood_check_muxes

left_pixel_mux: multiplexer2x1_8bit port map (D1 => pixel_3, D2 => "00000000",  choose => last_col, output => left_pixel);
right_pixel_mux: multiplexer2x1_8bit port map (D1 => pixel_5, D2 => "00000000",  choose => first_col, output => right_pixel);

top_pixel_mux: multiplexer2x1_8bit port map (D1 => pixel_1, D2 => "00000000",  choose => last_row, output => top_pixel);
bottom_pixel_mux: multiplexer2x1_8bit port map (D1 => pixel_7, D2 => "00000000",  choose => first_row, output => bottom_pixel);

or_gate_1: or_gate port map (X=>last_col, Y=>last_row, Z=>or1);
or_gate_2: or_gate port map (X=>last_col, Y=>first_row, Z=>or2);
or_gate_3: or_gate port map (X=>first_col, Y=>last_row, Z=>or3);
or_gate_4: or_gate port map (X=>first_col, Y=>first_row, Z=>or4);
top_left_pixel_mux: multiplexer2x1_8bit port map (D1 => pixel_0, D2 => "00000000",  choose => or1, output => top_left_pixel);
bottom_left_pixel_mux: multiplexer2x1_8bit port map (D1 => pixel_6, D2 => "00000000",  choose => or2, output => bottom_left_pixel);
top_right_pixel_mux: multiplexer2x1_8bit port map (D1 => pixel_2, D2 => "00000000",  choose => or3, output => top_right_pixel);
bottom_right_pixel_mux: multiplexer2x1_8bit port map (D1 => pixel_8, D2 => "00000000",  choose => or4, output => bottom_right_pixel);

cross_left_pixel_mux: multiplexer2x1_8bit port map (D1 => pixel_3, D2 => "00000000",  choose => last_col, output => cross_left_pixel);
cross_right_pixel_mux: multiplexer2x1_8bit port map (D1 => pixel_5, D2 => "00000000",  choose => first_col, output => cross_right_pixel);
cross_top_pixel_mux: multiplexer2x1_8bit port map (D1 => pixel_1, D2 => "00000000",  choose => last_row, output => cross_top_pixel);
cross_bottom_pixel_mux: multiplexer2x1_8bit port map (D1 => pixel_7, D2 => "00000000",  choose => first_row, output => cross_bottom_pixel);

-- calculation modules

row_adder: adder_2numbers_8bit port map (A => left_pixel, B => right_pixel, mean => row_result);
column_adder: adder_2numbers_8bit port map (A => top_pixel, B => bottom_pixel, mean => column_result);
corners_adder: adder_4numbers_8bit port map (A => top_left_pixel, B => bottom_left_pixel, C => top_right_pixel, D => bottom_right_pixel, mean => corners_result);
cross_adder: adder_4numbers_8bit port map (A => cross_left_pixel, B => cross_right_pixel, C => cross_top_pixel, D => cross_bottom_pixel, mean => cross_result);

-- result muxes

red_mux: multiplexer4x1_8bit port map (D1 => column_result, D2 => corners_result, D3 => pixel_4, D4 => row_result, choose => state, output => red_result);
green_mux: multiplexer4x1_8bit port map (D1 => pixel_4, D2 => cross_result, D3 => cross_result, D4 => pixel_4, choose => state, output => green_result);
blue_mux: multiplexer4x1_8bit port map (D1 => row_result, D2 => pixel_4, D3 => corners_result, D4 => column_result, choose => state, output => blue_result);

-- output buffers for circuit sync

red_buf: reg_8bit port map (D => red_result, clk => clk, rst => rst, Q => red);
green_buf: reg_8bit port map (D => green_result, clk => clk, rst => rst, Q => green);
blue_buf: reg_8bit port map (D => blue_result, clk => clk, rst => rst, Q => blue);


end Structural;
