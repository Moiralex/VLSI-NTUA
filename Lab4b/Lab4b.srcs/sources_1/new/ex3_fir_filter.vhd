----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/23/2022 10:50:17 PM
-- Design Name: 
-- Module Name: ex3_fir_filter - Behavioral
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
use ieee.std_logic_unsigned.all;

entity ex3_fir_filter is
    port (clk  : in std_logic;
          rst : in std_logic;
          x_1 : in std_logic_vector(7 downto 0);
          x_2 : in std_logic_vector(7 downto 0);
          valid_in : in std_logic;
          valid_out : out std_logic;
          first_result : out std_logic_vector(20 downto 0);
          second_result : out std_logic_vector(20 downto 0));	
end ex3_fir_filter;

architecture ex3_fir_filter_arch of ex3_fir_filter is


    component reg_clk_and_valid_in is
        Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           valid_in : in std_logic;
           rst : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component adder is
        Port ( A : in STD_LOGIC_VECTOR (20 downto 0);
               B : in STD_LOGIC_VECTOR (20 downto 0);
               clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               result : out STD_LOGIC_VECTOR (20 downto 0));
    end component;
    
    component multiplier is
        Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
               coeff : in STD_LOGIC_VECTOR (7 downto 0);
               clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               result : out STD_LOGIC_VECTOR (20 downto 0));
    end component;
    
    component signal_register_20_bit is
        Port ( D : in STD_LOGIC_VECTOR (20 downto 0);
               clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               Q : out STD_LOGIC_VECTOR (20 downto 0));
    end component;
    
    component reg2 is
        Port ( D : in STD_LOGIC;
               clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               Q : out STD_LOGIC);
    end component;
 
signal input_reg1, input_reg2, input_reg3, input_reg4, input_reg5, input_reg6, input_reg7, input_reg8, input_reg9 : std_logic_vector(7 downto 0);

--signals used for first result
signal result_first_multiplier, result_second_multiplier, result_third_multiplier, result_fourth_multiplier, 
        result_fifth_multiplier, result_sixth_multiplier, result_seventh_multiplier, result_eighth_multiplier : std_logic_vector(20 downto 0) := (others => '0');

signal result_first_multiplier_reg1, result_second_multiplier_reg1, result_third_multiplier_reg1 , result_third_multiplier_reg2, result_fourth_multiplier_reg1 , result_fourth_multiplier_reg2, result_fourth_multiplier_reg3, 
        result_fifth_multiplier_reg1, result_fifth_multiplier_reg2, result_fifth_multiplier_reg3, result_fifth_multiplier_reg4, 
        result_sixth_multiplier_reg1, result_sixth_multiplier_reg2, result_sixth_multiplier_reg3, result_sixth_multiplier_reg4, result_sixth_multiplier_reg5, 
        result_seventh_multiplier_reg1, result_seventh_multiplier_reg2, result_seventh_multiplier_reg3, result_seventh_multiplier_reg4, result_seventh_multiplier_reg5, result_seventh_multiplier_reg6,
        result_eighth_multiplier_reg1, result_eighth_multiplier_reg2, result_eighth_multiplier_reg3, result_eighth_multiplier_reg4, result_eighth_multiplier_reg5, result_eighth_multiplier_reg6, result_eighth_multiplier_reg7 : std_logic_vector(20 downto 0);
        
signal result_first_adder, result_second_adder, result_third_adder, result_fourth_adder, 
        result_fifth_adder, result_sixth_adder: std_logic_vector(20 downto 0);

--signals used for second result

signal second_result_first_multiplier, second_result_second_multiplier, second_result_third_multiplier, second_result_fourth_multiplier, 
        second_result_fifth_multiplier, second_result_sixth_multiplier, second_result_seventh_multiplier, second_result_eighth_multiplier : std_logic_vector(20 downto 0) := (others => '0');

signal second_result_first_multiplier_reg1, second_result_second_multiplier_reg1, second_result_third_multiplier_reg1 , second_result_third_multiplier_reg2, 
        second_result_fourth_multiplier_reg1 , second_result_fourth_multiplier_reg2, second_result_fourth_multiplier_reg3, 
        second_result_fifth_multiplier_reg1, second_result_fifth_multiplier_reg2, second_result_fifth_multiplier_reg3, second_result_fifth_multiplier_reg4, 
        second_result_sixth_multiplier_reg1, second_result_sixth_multiplier_reg2, second_result_sixth_multiplier_reg3, second_result_sixth_multiplier_reg4, 
        second_result_sixth_multiplier_reg5, second_result_seventh_multiplier_reg1, second_result_seventh_multiplier_reg2, second_result_seventh_multiplier_reg3, 
        second_result_seventh_multiplier_reg4, second_result_seventh_multiplier_reg5, second_result_seventh_multiplier_reg6, second_result_eighth_multiplier_reg1, 
        second_result_eighth_multiplier_reg2, second_result_eighth_multiplier_reg3, second_result_eighth_multiplier_reg4, second_result_eighth_multiplier_reg5, 
        second_result_eighth_multiplier_reg6, second_result_eighth_multiplier_reg7 : std_logic_vector(20 downto 0);
  
signal second_result_first_adder, second_result_second_adder, second_result_third_adder, second_result_fourth_adder, 
        second_result_fifth_adder, second_result_sixth_adder: std_logic_vector(20 downto 0);
          
signal valid_out_reg1, valid_out_reg2, valid_out_reg3, valid_out_reg4, valid_out_reg5, valid_out_reg6, valid_out_reg7, valid_out_reg8, valid_out_reg9: std_logic;
begin

--regs
first_read_reg: reg_clk_and_valid_in port map(D=>x_1, clk=>clk, valid_in=>valid_in, rst=>rst, Q=>input_reg1);
second_read_reg: reg_clk_and_valid_in port map(D=>x_2, clk=>clk, valid_in=>valid_in, rst=>rst, Q=>input_reg2);

third_reg: reg_clk_and_valid_in port map(D=>input_reg1, clk=>clk, valid_in=>valid_in, rst=>rst, Q=>input_reg3);
fourth_reg: reg_clk_and_valid_in port map(D=>input_reg2, clk=>clk, valid_in=>valid_in, rst=>rst, Q=>input_reg4);

fifth_reg: reg_clk_and_valid_in port map(D=>input_reg3, clk=>clk, valid_in=>valid_in, rst=>rst, Q=>input_reg5);
sixth_reg: reg_clk_and_valid_in port map(D=>input_reg4, clk=>clk, valid_in=>valid_in, rst=>rst, Q=>input_reg6);

seventh_reg: reg_clk_and_valid_in port map(D=>input_reg5, clk=>clk, valid_in=>valid_in, rst=>rst, Q=>input_reg7);
eighth_reg: reg_clk_and_valid_in port map(D=>input_reg6, clk=>clk, valid_in=>valid_in, rst=>rst, Q=>input_reg8);

nineth_reg: reg_clk_and_valid_in port map(D=>input_reg7, clk=>clk, valid_in=>valid_in, rst=>rst, Q=>input_reg9);

--multipliers for first result

first_multiplier: multiplier port map(A=>input_reg1, coeff=>"00000001", clk=>clk, rst=>rst, result=>result_first_multiplier);
reg1: signal_register_20_bit port map(D=>result_first_multiplier, clk=>clk, rst=>rst, Q=>result_first_multiplier_reg1);

second_multiplier: multiplier port map(A=>input_reg2, coeff=>"00000010", clk=>clk, rst=>rst, result=>result_second_multiplier);
reg2a: signal_register_20_bit port map(D=>result_second_multiplier, clk=>clk, rst=>rst, Q=>result_second_multiplier_reg1);

third_multiplier: multiplier port map(A=>input_reg3, coeff=>"00000011", clk=>clk, rst=>rst, result=>result_third_multiplier);
reg3a: signal_register_20_bit port map(D=>result_third_multiplier, clk=>clk, rst=>rst, Q=>result_third_multiplier_reg1);
reg3b: signal_register_20_bit port map(D=>result_third_multiplier_reg1, clk=>clk, rst=>rst, Q=>result_third_multiplier_reg2);

fourth_multiplier: multiplier port map(A=>input_reg4, coeff=>"00000100", clk=>clk, rst=>rst, result=>result_fourth_multiplier);
reg4a: signal_register_20_bit port map(D=>result_fourth_multiplier, clk=>clk, rst=>rst, Q=>result_fourth_multiplier_reg1);
reg4b: signal_register_20_bit port map(D=>result_fourth_multiplier_reg1, clk=>clk, rst=>rst, Q=>result_fourth_multiplier_reg2);
reg4c: signal_register_20_bit port map(D=>result_fourth_multiplier_reg2, clk=>clk, rst=>rst, Q=>result_fourth_multiplier_reg3);

fifth_multiplier: multiplier port map(A=>input_reg5, coeff=>"00000101", clk=>clk, rst=>rst, result=>result_fifth_multiplier);
reg5a: signal_register_20_bit port map(D=>result_fifth_multiplier, clk=>clk, rst=>rst, Q=>result_fifth_multiplier_reg1);
reg5b: signal_register_20_bit port map(D=>result_fifth_multiplier_reg1, clk=>clk, rst=>rst, Q=>result_fifth_multiplier_reg2);
reg5c: signal_register_20_bit port map(D=>result_fifth_multiplier_reg2, clk=>clk, rst=>rst, Q=>result_fifth_multiplier_reg3);
reg5d: signal_register_20_bit port map(D=>result_fifth_multiplier_reg3, clk=>clk, rst=>rst, Q=>result_fifth_multiplier_reg4);

sixth_multiplier: multiplier port map(A=>input_reg6, coeff=>"00000110", clk=>clk, rst=>rst, result=>result_sixth_multiplier);
reg6a: signal_register_20_bit port map(D=>result_sixth_multiplier, clk=>clk, rst=>rst, Q=>result_sixth_multiplier_reg1);
reg6b: signal_register_20_bit port map(D=>result_sixth_multiplier_reg1, clk=>clk, rst=>rst, Q=>result_sixth_multiplier_reg2);
reg6c: signal_register_20_bit port map(D=>result_sixth_multiplier_reg2, clk=>clk, rst=>rst, Q=>result_sixth_multiplier_reg3);
reg6d: signal_register_20_bit port map(D=>result_sixth_multiplier_reg3, clk=>clk, rst=>rst, Q=>result_sixth_multiplier_reg4);
reg6e: signal_register_20_bit port map(D=>result_sixth_multiplier_reg4, clk=>clk, rst=>rst, Q=>result_sixth_multiplier_reg5);

seventh_multiplier: multiplier port map(A=>input_reg7, coeff=>"00000111", clk=>clk, rst=>rst, result=>result_seventh_multiplier);
reg7a: signal_register_20_bit port map(D=>result_seventh_multiplier, clk=>clk, rst=>rst, Q=>result_seventh_multiplier_reg1);
reg7b: signal_register_20_bit port map(D=>result_seventh_multiplier_reg1, clk=>clk, rst=>rst, Q=>result_seventh_multiplier_reg2);
reg7c: signal_register_20_bit port map(D=>result_seventh_multiplier_reg2, clk=>clk, rst=>rst, Q=>result_seventh_multiplier_reg3);
reg7d: signal_register_20_bit port map(D=>result_seventh_multiplier_reg3, clk=>clk, rst=>rst, Q=>result_seventh_multiplier_reg4);
reg7e: signal_register_20_bit port map(D=>result_seventh_multiplier_reg4, clk=>clk, rst=>rst, Q=>result_seventh_multiplier_reg5);
reg7f: signal_register_20_bit port map(D=>result_seventh_multiplier_reg5, clk=>clk, rst=>rst, Q=>result_seventh_multiplier_reg6);

eighth_multiplier: multiplier port map(A=>input_reg8, coeff=>"00001000", clk=>clk, rst=>rst, result=>result_eighth_multiplier);
reg8a: signal_register_20_bit port map(D=>result_eighth_multiplier, clk=>clk, rst=>rst, Q=>result_eighth_multiplier_reg1);
reg8b: signal_register_20_bit port map(D=>result_eighth_multiplier_reg1, clk=>clk, rst=>rst, Q=>result_eighth_multiplier_reg2);
reg8c: signal_register_20_bit port map(D=>result_eighth_multiplier_reg2, clk=>clk, rst=>rst, Q=>result_eighth_multiplier_reg3);
reg8d: signal_register_20_bit port map(D=>result_eighth_multiplier_reg3, clk=>clk, rst=>rst, Q=>result_eighth_multiplier_reg4);
reg8e: signal_register_20_bit port map(D=>result_eighth_multiplier_reg4, clk=>clk, rst=>rst, Q=>result_eighth_multiplier_reg5);
reg8f: signal_register_20_bit port map(D=>result_eighth_multiplier_reg5, clk=>clk, rst=>rst, Q=>result_eighth_multiplier_reg6);
reg8g: signal_register_20_bit port map(D=>result_eighth_multiplier_reg6, clk=>clk, rst=>rst, Q=>result_eighth_multiplier_reg7);

--adders for first result

first_adder: adder port map(A=>result_first_multiplier_reg1, B=>result_second_multiplier_reg1, clk=>clk, rst=>rst, result=>result_first_adder);
second_adder: adder port map(A=>result_third_multiplier_reg2, B=>result_first_adder, clk=>clk, rst=>rst, result=>result_second_adder);
third_adder: adder port map(A=>result_fourth_multiplier_reg3, B=>result_second_adder, clk=>clk, rst=>rst, result=>result_third_adder);
fourth_adder: adder port map(A=>result_fifth_multiplier_reg4, B=>result_third_adder, clk=>clk, rst=>rst, result=>result_fourth_adder);
fifth_adder: adder port map(A=>result_sixth_multiplier_reg5, B=>result_fourth_adder, clk=>clk, rst=>rst, result=>result_fifth_adder);
sixth_adder: adder port map(A=>result_seventh_multiplier_reg6, B=>result_fifth_adder, clk=>clk, rst=>rst, result=>result_sixth_adder);
seventh_adder: adder port map(A=>result_eighth_multiplier_reg7, B=>result_sixth_adder, clk=>clk, rst=>rst, result=>first_result);

--multipliers for second result

again_first_multipliers: multiplier port map(A=>input_reg2, coeff=>"00000001", clk=>clk, rst=>rst, result=>second_result_first_multiplier);
again_reg1: signal_register_20_bit port map(D=>second_result_first_multiplier, clk=>clk, rst=>rst, Q=>second_result_first_multiplier_reg1);

again_second_multiplier: multiplier port map(A=>input_reg3, coeff=>"00000010", clk=>clk, rst=>rst, result=>second_result_second_multiplier);
again_reg2a: signal_register_20_bit port map(D=>second_result_second_multiplier, clk=>clk, rst=>rst, Q=>second_result_second_multiplier_reg1);

again_third_multiplier: multiplier port map(A=>input_reg4, coeff=>"00000011", clk=>clk, rst=>rst, result=>second_result_third_multiplier);
again_reg3a: signal_register_20_bit port map(D=>second_result_third_multiplier, clk=>clk, rst=>rst, Q=>second_result_third_multiplier_reg1);
again_reg3b: signal_register_20_bit port map(D=>second_result_third_multiplier_reg1, clk=>clk, rst=>rst, Q=>second_result_third_multiplier_reg2);

again_fourth_multiplier: multiplier port map(A=>input_reg5, coeff=>"00000100", clk=>clk, rst=>rst, result=>second_result_fourth_multiplier);
again_reg4a: signal_register_20_bit port map(D=>second_result_fourth_multiplier, clk=>clk, rst=>rst, Q=>second_result_fourth_multiplier_reg1);
again_reg4b: signal_register_20_bit port map(D=>second_result_fourth_multiplier_reg1, clk=>clk, rst=>rst, Q=>second_result_fourth_multiplier_reg2);
again_reg4c: signal_register_20_bit port map(D=>second_result_fourth_multiplier_reg2, clk=>clk, rst=>rst, Q=>second_result_fourth_multiplier_reg3);

again_fifth_multiplier: multiplier port map(A=>input_reg6, coeff=>"00000101", clk=>clk, rst=>rst, result=>second_result_fifth_multiplier);
again_reg5a: signal_register_20_bit port map(D=>second_result_fifth_multiplier, clk=>clk, rst=>rst, Q=>second_result_fifth_multiplier_reg1);
again_reg5b: signal_register_20_bit port map(D=>second_result_fifth_multiplier_reg1, clk=>clk, rst=>rst, Q=>second_result_fifth_multiplier_reg2);
again_reg5c: signal_register_20_bit port map(D=>second_result_fifth_multiplier_reg2, clk=>clk, rst=>rst, Q=>second_result_fifth_multiplier_reg3);
again_reg5d: signal_register_20_bit port map(D=>second_result_fifth_multiplier_reg3, clk=>clk, rst=>rst, Q=>second_result_fifth_multiplier_reg4);

again_sixth_multiplier: multiplier port map(A=>input_reg7, coeff=>"00000110", clk=>clk, rst=>rst, result=>second_result_sixth_multiplier);
again_reg6a: signal_register_20_bit port map(D=>second_result_sixth_multiplier, clk=>clk, rst=>rst, Q=>second_result_sixth_multiplier_reg1);
again_reg6b: signal_register_20_bit port map(D=>second_result_sixth_multiplier_reg1, clk=>clk, rst=>rst, Q=>second_result_sixth_multiplier_reg2);
again_reg6c: signal_register_20_bit port map(D=>second_result_sixth_multiplier_reg2, clk=>clk, rst=>rst, Q=>second_result_sixth_multiplier_reg3);
again_reg6d: signal_register_20_bit port map(D=>second_result_sixth_multiplier_reg3, clk=>clk, rst=>rst, Q=>second_result_sixth_multiplier_reg4);
again_reg6e: signal_register_20_bit port map(D=>second_result_sixth_multiplier_reg4, clk=>clk, rst=>rst, Q=>second_result_sixth_multiplier_reg5);

again_seventh_multiplier: multiplier port map(A=>input_reg8, coeff=>"00000111", clk=>clk, rst=>rst, result=>second_result_seventh_multiplier);
again_reg7a: signal_register_20_bit port map(D=>second_result_seventh_multiplier, clk=>clk, rst=>rst, Q=>second_result_seventh_multiplier_reg1);
again_reg7b: signal_register_20_bit port map(D=>second_result_seventh_multiplier_reg1, clk=>clk, rst=>rst, Q=>second_result_seventh_multiplier_reg2);
again_reg7c: signal_register_20_bit port map(D=>second_result_seventh_multiplier_reg2, clk=>clk, rst=>rst, Q=>second_result_seventh_multiplier_reg3);
again_reg7d: signal_register_20_bit port map(D=>second_result_seventh_multiplier_reg3, clk=>clk, rst=>rst, Q=>second_result_seventh_multiplier_reg4);
again_reg7e: signal_register_20_bit port map(D=>second_result_seventh_multiplier_reg4, clk=>clk, rst=>rst, Q=>second_result_seventh_multiplier_reg5);
again_reg7f: signal_register_20_bit port map(D=>second_result_seventh_multiplier_reg5, clk=>clk, rst=>rst, Q=>second_result_seventh_multiplier_reg6);

again_eighth_multiplier: multiplier port map(A=>input_reg9, coeff=>"00001000", clk=>clk, rst=>rst, result=>second_result_eighth_multiplier);
again_reg8a: signal_register_20_bit port map(D=>second_result_eighth_multiplier, clk=>clk, rst=>rst, Q=>second_result_eighth_multiplier_reg1);
again_reg8b: signal_register_20_bit port map(D=>second_result_eighth_multiplier_reg1, clk=>clk, rst=>rst, Q=>second_result_eighth_multiplier_reg2);
again_reg8c: signal_register_20_bit port map(D=>second_result_eighth_multiplier_reg2, clk=>clk, rst=>rst, Q=>second_result_eighth_multiplier_reg3);
again_reg8d: signal_register_20_bit port map(D=>second_result_eighth_multiplier_reg3, clk=>clk, rst=>rst, Q=>second_result_eighth_multiplier_reg4);
again_reg8e: signal_register_20_bit port map(D=>second_result_eighth_multiplier_reg4, clk=>clk, rst=>rst, Q=>second_result_eighth_multiplier_reg5);
again_reg8f: signal_register_20_bit port map(D=>second_result_eighth_multiplier_reg5, clk=>clk, rst=>rst, Q=>second_result_eighth_multiplier_reg6);
again_reg8g: signal_register_20_bit port map(D=>second_result_eighth_multiplier_reg6, clk=>clk, rst=>rst, Q=>second_result_eighth_multiplier_reg7);

--adders for second result

again_first_adder: adder port map(A=>second_result_first_multiplier_reg1, B=>second_result_second_multiplier_reg1, clk=>clk, rst=>rst, result=>second_result_first_adder);
again_second_adder: adder port map(A=>second_result_third_multiplier_reg2, B=>second_result_first_adder, clk=>clk, rst=>rst, result=>second_result_second_adder);
again_third_adder: adder port map(A=>second_result_fourth_multiplier_reg3, B=>second_result_second_adder, clk=>clk, rst=>rst, result=>second_result_third_adder);
again_fourth_adder: adder port map(A=>second_result_fifth_multiplier_reg4, B=>second_result_third_adder, clk=>clk, rst=>rst, result=>second_result_fourth_adder);
again_fifth_adder: adder port map(A=>second_result_sixth_multiplier_reg5, B=>second_result_fourth_adder, clk=>clk, rst=>rst, result=>second_result_fifth_adder);
again_sixth_adder: adder port map(A=>second_result_seventh_multiplier_reg6, B=>second_result_fifth_adder, clk=>clk, rst=>rst, result=>second_result_sixth_adder);
again_seventh_adder: adder port map(A=>second_result_eighth_multiplier_reg7, B=>second_result_sixth_adder, clk=>clk, rst=>rst, result=>second_result);

valid_out1: reg2 port map(D=>valid_in, clk=>clk, rst=>rst, Q=>valid_out_reg1);
valid_out2: reg2 port map(D=>valid_out_reg1, clk=>clk, rst=>rst, Q=>valid_out_reg2);
valid_out3: reg2 port map(D=>valid_out_reg2, clk=>clk, rst=>rst, Q=>valid_out_reg3);
valid_out4: reg2 port map(D=>valid_out_reg3, clk=>clk, rst=>rst, Q=>valid_out_reg4);
valid_out5: reg2 port map(D=>valid_out_reg4, clk=>clk, rst=>rst, Q=>valid_out_reg5);
valid_out6: reg2 port map(D=>valid_out_reg5, clk=>clk, rst=>rst, Q=>valid_out_reg6);
valid_out7: reg2 port map(D=>valid_out_reg6, clk=>clk, rst=>rst, Q=>valid_out_reg7);
valid_out8: reg2 port map(D=>valid_out_reg7, clk=>clk, rst=>rst, Q=>valid_out_reg8);
valid_out9: reg2 port map(D=>valid_out_reg8, clk=>clk, rst=>rst, Q=>valid_out_reg9);
valid_out10: reg2 port map(D=>valid_out_reg9, clk=>clk, rst=>rst, Q=>valid_out);

end ex3_fir_filter_arch;