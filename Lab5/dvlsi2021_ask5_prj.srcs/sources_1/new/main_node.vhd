
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity main_node is
  Port (clk : in std_logic;
        rst, valid_in, rd_check, new_image : in std_logic;
        input : in std_logic_vector(7 downto 0);
        red : out std_logic_vector(7 downto 0);
        blue : out std_logic_vector(7 downto 0);
        green : out std_logic_vector(7 downto 0);
        valid_out, image_finished : out std_logic);
end main_node;

architecture Behavioral of main_node is
    component fifo_with_registers is
      Port ( clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            valid_in : IN STD_LOGIC;
            input : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            new_image : IN STD_LOGIC;
            full : out STD_LOGIC;
            reg_output_1_1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            reg_output_1_2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            reg_output_1_3 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            reg_output_2_1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            reg_output_2_2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            reg_output_2_3 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            reg_output_3_1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            reg_output_3_2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            reg_output_3_3 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            counter_in : inout std_logic_vector(10 downto 0) := (others=>'0'); 
            counter_out_fifo3 : inout std_logic_vector(10 downto 0) := (others=>'0');
            output_first_fifo : inout std_logic_vector(7 downto 0)
          );
    end component;
    
    component finite_state_machine is
        port ( early_valid, line0, rst, clk : in std_logic;
               y : out std_logic_vector(1 downto 0) := "00");
    end component;
    
    
    component computation_module is
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
    end component;
    
    component synchronizer is
        generic (
            N : STD_LOGIC_VECTOR(11 downto 0) := "10000"
        );
        Port ( clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               early_valid : in STD_LOGIC;
               first_col : out STD_LOGIC;
               last_col : out STD_LOGIC;
               new_line : out STD_LOGIC;
               first_line : out STD_LOGIC;
               last_line : out STD_LOGIC;
               image_finished : out STD_LOGIC := '0');
    end component;
    
    component valid_generator is
        generic (N: std_logic_vector (11 downto 0) := "000000100000");
        Port ( clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               valid_in : in STD_LOGIC;
               rd_check : out STD_LOGIC;
               early_valid : out STD_LOGIC;
               valid_out : out STD_LOGIC);
    end component;
    
    signal early_valid, first_col, last_col, new_line, first_row, last_row : std_logic;
    signal states : std_logic_vector(1 downto 0);
    signal output_reg_1_1, output_reg_1_2,  output_reg_1_3, output_reg_2_1, output_reg_2_2, 
     output_reg_2_3, output_reg_3_1, output_reg_3_2, output_reg_3_3 : std_logic_vector(7 downto 0);

begin

valid_generator2: valid_generator
        generic map (N => "000000100000")
        Port map(clk => clk,
               rst => rst,
               valid_in => valid_in,
               rd_check => open,
               early_valid => early_valid,
               valid_out => valid_out);

sync:  synchronizer 
        generic map (
            N => "10000"
        )
        Port map( clk => clk,
               rst => rst,
               early_valid => early_valid,
               first_col => first_col,
               last_col => last_col,
               new_line => new_line,
               first_line => first_row,
               last_line => last_row,
               image_finished => image_finished);       
               
fsm: finite_state_machine
        port map ( early_valid => early_valid, line0=> new_line, rst=>rst, clk => clk, y => states);

fifo: fifo_with_registers 
      Port map( clk => clk,
            rst => rst,
            valid_in => valid_in,
            input => input,
            new_image => new_image,
            full => open,
            reg_output_1_1 => output_reg_1_1,
            reg_output_1_2 => output_reg_1_2,
            reg_output_1_3 => output_reg_1_3,
            reg_output_2_1 => output_reg_2_1,
            reg_output_2_2 => output_reg_2_2,
            reg_output_2_3 => output_reg_2_3,
            reg_output_3_1 => output_reg_3_1,
            reg_output_3_2 => output_reg_3_2,
            reg_output_3_3 => output_reg_3_3,
            counter_in => open,
            counter_out_fifo3 => open,
            output_first_fifo => open ); 
            
comp: computation_module 
        Port map( clk => clk,
               rst => rst,
               state => states,
               pixel_0 => output_reg_1_1,
               pixel_1 => output_reg_1_2,
               pixel_2 => output_reg_1_3,
               pixel_3 => output_reg_2_1,
               pixel_4 => output_reg_2_2,
               pixel_5 => output_reg_2_3,
               pixel_6 => output_reg_3_1,
               pixel_7 => output_reg_3_2,
               pixel_8 => output_reg_3_3,
               first_col => first_col,
               last_col => last_col,
               first_row => first_row,
               last_row => last_row,
               red => red,
               green => green,
               blue => blue);
end Behavioral;
