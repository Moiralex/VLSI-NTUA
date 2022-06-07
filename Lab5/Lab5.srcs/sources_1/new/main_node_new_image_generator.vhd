----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.06.2022 15:11:52
-- Design Name: 
-- Module Name: main_node_new_image_generator - Structural
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

entity main_node_new_image_generator is
    generic (N: std_logic_vector(11 downto 0) := "000000100000");
    port(clk : in std_logic;
        rst, tmp_tvalid: in std_logic;
        input : in std_logic_vector(7 downto 0);
        tdata_output : out std_logic_vector(31 downto 0);
        --debug
        valid_in_test, new_image_test : out std_logic;
        red_test : out std_logic_vector(7 downto 0);
        green_test : out std_logic_vector(7 downto 0);
        blue_test : out std_logic_vector(7 downto 0);
        next_state: out std_logic_vector(1 downto 0);
        counter_in : inout std_logic_vector(10 downto 0);
        --debug
        valid_out, image_finished : out std_logic);
end main_node_new_image_generator;

architecture Structural of main_node_new_image_generator is

component main_node is
      generic (N: std_logic_vector(11 downto 0) := "000000100000");
      Port (clk : in std_logic;
            rst, valid_in, new_image : in std_logic;
            input : in std_logic_vector(7 downto 0);
            red : out std_logic_vector(7 downto 0);
            green : out std_logic_vector(7 downto 0);
            blue : out std_logic_vector(7 downto 0);
            --debug
            next_state: out std_logic_vector(1 downto 0);
            counter_in : inout std_logic_vector(10 downto 0);
            --debug
            valid_out, image_finished : out std_logic);
    end component;
    
    component reg_1bit is
        Port ( D : in STD_LOGIC;
               clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               Q : out STD_LOGIC :='0');
    end component;
    
    component reg_8bit is
        Port ( D : in std_logic_vector(7 downto 0);
               clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               Q : out std_logic_vector(7 downto 0));
    end component;
    
    component reg_1bit_starting_as_one is
        Port ( D : in STD_LOGIC;
               clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               Q : out STD_LOGIC :='1');
    end component;
    
    component reg_1bit_negative_edge is
        Port ( D : in STD_LOGIC;
               clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               Q : out STD_LOGIC :='0');
    end component;
    
    signal tmp_tdata, tmp_data_reg1, tmp_data_reg2, red, green, blue  : std_logic_vector(7 downto 0);
    signal tmp_tkeep  : std_logic_vector(0 downto 0);
    signal tmp_tlast  : std_logic;
    signal valid_in : std_logic;
    signal tmp_valid_reg1, tmp_valid_reg2, new_image, new_image_tmp: std_logic;
    signal not_prev_valid: std_logic;
    signal tdata_output_tmp : std_logic_vector(31 downto 0);

begin
--tdata_output <= "00000000" & red & green & blue;
valid_delay_reg1: reg_1bit port map (D=>tmp_tvalid, clk => clk, rst => rst, Q => tmp_valid_reg1);

input_delay_reg1: reg_8bit port map (D=>tmp_tdata, clk => clk, rst => rst, Q => tmp_data_reg1);

not_prev_valid <= not tmp_valid_reg1;
new_image_tmp <= not_prev_valid and tmp_tvalid;

new_image_reg: reg_1bit port map (D=>new_image_tmp, clk => clk, rst => rst, Q => new_image);
valid_delay_reg: reg_1bit port map (D=>tmp_tvalid, clk => clk, rst => rst, Q => valid_in);
--input_delay_reg2: reg_8bit port map (D=>tmp_data_reg1, clk => clk, rst => rst, Q => tmp_data_reg2);


new_image_test <= new_image;
--tmp_valid_reg2 <= tmp_valid_reg1 --or new_image_tmp;--new_image;
valid_in_test <= valid_in;

main_node_instance: main_node
      --generic map(N => "000000100000")
      Port map (clk => clk,
            rst => rst,
            valid_in => valid_in,
            new_image => new_image,
            input =>tmp_data_reg1,
            red => red_test,
            green =>green_test,
            blue =>blue_test,
            --debug
            next_state => next_state,
            counter_in => counter_in,
            --debug
            valid_out =>valid_out, 
            image_finished =>image_finished );

--red_test <= red;
--green_test <= green;
--blue_test <= blue;
end Structural;
