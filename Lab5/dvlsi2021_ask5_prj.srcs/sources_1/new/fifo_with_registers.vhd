----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/31/2022 08:06:42 PM
-- Design Name: 
-- Module Name: fifo_with_registers - Behavioral
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

entity fifo_with_registers is
  generic (N: std_logic_vector(11 downto 0) := "000000100000");
  Port ( clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        valid_in : IN STD_LOGIC;
        input : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        new_image : IN STD_LOGIC;
        full : out STD_LOGIC;
        early_valid: out STD_LOGIC;
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
end fifo_with_registers;

architecture Behavioral of fifo_with_registers is
    
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
    
    component reg_clk_and_valid_in is
        Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
               clk : in STD_LOGIC;
               valid_in : in std_logic;
               rst : in STD_LOGIC;
               Q : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component reg_1bit is
    Port ( D : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           Q : out STD_LOGIC :='0');
    end component;
    
    --signal output_first_fifo, 
    signal output_second_fifo, output_third_fifo : std_logic_vector(7 downto 0);
    signal output_reg_1_1,output_reg_1_2, output_reg_2_1, output_reg_2_2, output_reg_3_1, output_reg_3_2 : std_logic_vector(7 downto 0);
    --signal counter_in, counter_out : std_logic_vector(10 downto 0) := (others=>'0');
    --signal dontcare1, dontcare1, 
    signal not_rst, mid_data_valid, pre_early_valid: std_logic;
    signal wr_fifo1, wr_fifo2, wr_fifo3 : std_logic;
    signal rd_fifo1, rd_fifo2, rd_fifo3 : std_logic;
    signal valid_fifo1, valid_fifo2, valid_fifo3 : std_logic;
    signal full_fifo1, full_fifo2, full_fifo3 : std_logic;
    signal dontcare1, dontcare2, dontcare3, dontcare4, dontcare5, dontcare6 :std_logic;
    signal valid_reg1, valid_reg2, valid_reg3, valid_reg4, valid_reg5, valid_reg6, valid_reg7, valid_reg8, valid_reg9: std_logic;
    signal new_image_came : std_logic := '0';
    signal all_data_read: std_logic:='0';
    signal second_image_counter : std_logic_vector(10 downto 0) := (others=>'0');
begin

fifo_first_line: fifo_generator_1 port map (clk=>clk,  srst=>not_rst, din=>input, wr_en=>wr_fifo1, rd_en =>rd_fifo1, dout => output_first_fifo,
                 full=>full_fifo1, almost_full=>dontcare1, empty=>dontcare2, valid=>valid_fifo1);
fifo_second_line: fifo_generator_1 port map (clk=>clk,  srst=>not_rst, din=>output_first_fifo, wr_en=>wr_fifo2, rd_en=>rd_fifo2, dout=>output_second_fifo, 
                 full=>full_fifo2, almost_full=>dontcare3, empty=>dontcare4, valid=>valid_fifo2);
fifo_third_line: fifo_generator_1 port map (clk=>clk,  srst=>not_rst, din=>output_second_fifo, wr_en=>wr_fifo3, rd_en=>rd_fifo3, dout=>output_third_fifo, 
                 full=>full_fifo3, almost_full=>dontcare5, empty=>dontcare6,  valid=>valid_fifo3);

--anti gia valid_in evala valid_fifo
valid_reg1 <= valid_fifo1 or all_data_read;               
valid_reg2 <= valid_fifo1 or all_data_read;
valid_reg3 <= valid_fifo1 or all_data_read;
valid_reg4 <= valid_fifo2 or all_data_read;
valid_reg5 <= valid_fifo2 or all_data_read;
valid_reg6 <= valid_fifo2 or all_data_read;
valid_reg7 <= valid_fifo3 or all_data_read;
valid_reg8 <= valid_fifo3 or all_data_read;
valid_reg9 <= valid_fifo3 or all_data_read;
                 
first_line_first_reg:  reg_clk_and_valid_in port map (D=>output_first_fifo, clk=>clk, valid_in=>valid_reg1, rst=>rst, Q=>output_reg_1_1);
--second_reg_valid: reg_1bit port map (D=>valid_fifo1, clk => clk, rst => rst, Q => valid_reg2);
first_line_second_reg:  reg_clk_and_valid_in port map (D=>output_reg_1_1, clk=>clk, valid_in=>valid_reg2, rst=>rst, Q=>output_reg_1_2);
--third_reg_valid: reg_1bit port map (D=>valid_reg2, clk => clk, rst => rst, Q => valid_reg3);
first_line_third_reg:  reg_clk_and_valid_in port map (D=>output_reg_1_2, clk=>clk, valid_in=>valid_reg3, rst=>rst, Q=>reg_output_1_3);

second_line_first_reg:  reg_clk_and_valid_in port map (D=>output_second_fifo, clk=>clk, valid_in=>valid_reg4, rst=>rst, Q=>output_reg_2_1);
--fifth_reg_valid: reg_1bit port map (D=>valid_fifo2, clk => clk, rst => rst, Q => valid_reg5);
mid_data_reg_valid: reg_1bit port map (D=>valid_fifo2, clk => clk, rst => rst, Q => mid_data_valid);
second_line_second_reg:  reg_clk_and_valid_in port map (D=>output_reg_2_1, clk=>clk, valid_in=>valid_reg5, rst=>rst, Q=>output_reg_2_2);
--sixth_reg_valid: reg_1bit port map (D=>valid_reg5, clk => clk, rst => rst, Q => valid_reg6);
second_line_third_reg:  reg_clk_and_valid_in port map (D=>output_reg_2_2, clk=>clk, valid_in=>valid_reg6, rst=>rst, Q=>reg_output_2_3);

third_line_first_reg:  reg_clk_and_valid_in port map (D=>output_third_fifo, clk=>clk, valid_in=>valid_reg7, rst=>rst, Q=>output_reg_3_1);
--eigth_reg_valid: reg_1bit port map (D=>valid_fifo3, clk => clk, rst => rst, Q => valid_reg8);
third_line_second_reg:  reg_clk_and_valid_in port map (D=>output_reg_3_1, clk=>clk, valid_in=>valid_reg8, rst=>rst, Q=>output_reg_3_2);
--nineth_reg_valid: reg_1bit port map (D=>valid_reg8, clk => clk, rst => rst, Q => valid_reg9);
third_line_third_reg:  reg_clk_and_valid_in port map (D=>output_reg_3_2, clk=>clk, valid_in=>valid_reg9, rst=>rst, Q=>reg_output_3_3);

reg_output_1_1 <= output_reg_1_1;
reg_output_1_2 <= output_reg_1_2;
reg_output_2_1 <= output_reg_2_1;
reg_output_2_2 <= output_reg_2_2;
reg_output_3_1 <= output_reg_3_1;
reg_output_3_2 <= output_reg_3_2;
full <= full_fifo2;
not_rst <= not rst;

--changed valid_reg5 to mid_data_valid
pre_early_valid <= (rd_fifo2 and mid_data_valid) or all_data_read;
early_valid_reg: reg_1bit port map (D=>pre_early_valid, clk => clk, rst => rst, Q => early_valid);

process (clk, rst, new_image) begin
    if rst ='0' then
        second_image_counter <= (others => '0');
        new_image_came <= '0';
        all_data_read <= '0';
        counter_in <= (others => '0');
        
    elsif rst = '1' then 
        if new_image = '1' then
            new_image_came <= '1';
            wr_fifo1 <= valid_in ;
            --if valid_in = '1' then 
              --  counter_in <= counter_in + 1;
            --end if;
        end if;
        
        if rising_edge(clk) then
            if new_image_came = '1' then 
                if counter_in < N-2 then
                    wr_fifo1 <= valid_in ;
                    if valid_in = '1' then 
                        counter_in <= counter_in + 1;
                    end if;
                elsif counter_in = N-2 then
                    wr_fifo1 <= valid_in;
                    rd_fifo1 <= valid_in;
                    if valid_in = '1' then 
                        counter_in <= counter_in + 1;
                    end if;
                elsif counter_in < N+N-2 then
                    wr_fifo1 <= valid_in;
                    rd_fifo1 <= valid_in;
                    wr_fifo2 <= valid_in;
                    if valid_in = '1' then 
                        counter_in <= counter_in + 1;
                    end if;
                elsif counter_in = N+N-2 then
                    wr_fifo1 <= valid_in;
                    rd_fifo1 <= valid_in;
                    wr_fifo2 <= valid_in;
                    rd_fifo2 <= valid_in;
                    if valid_in = '1' then 
                        counter_in <= counter_in + 1;
                    end if;
                elsif counter_in < N+N+N-2 then
                    wr_fifo1 <= valid_in;
                    rd_fifo1 <= valid_in;
                    wr_fifo2 <= valid_in;
                    rd_fifo2 <= valid_in;
                    wr_fifo3 <= valid_in;
                    if valid_in = '1' then 
                        counter_in <= counter_in + 1;
                    end if;
                elsif counter_in <= N*N then
                    wr_fifo1 <= valid_in;
                    rd_fifo1 <= valid_in;
                    wr_fifo2 <= valid_in;
                    rd_fifo2 <= valid_in;
                    wr_fifo3 <= valid_in;
                    rd_fifo3 <= valid_in;
                    if rd_fifo3 = '1' then 
                        counter_out_fifo3 <= counter_out_fifo3 + 1;
                    end if;
                    if valid_in = '1' then 
                        counter_in <= counter_in + 1;
                    end if;
                    if counter_in = N*N-1 then --in order to become true when the counter has reached N*N
                        --counter_in <= (others=>'0');
                        new_image_came <= '0';
                        all_data_read <= '1';
                        wr_fifo1 <= '0';
                    end if;
                end if;
           end if;
           
            if(counter_in >= N*N) then
               if counter_in < (N*N+N-2)  then 
                    --counter_out_fifo3 <= (others => '0');
                    --new_image_came <= '0';
                    wr_fifo1 <= '0' or valid_in;
                    rd_fifo1 <= '1';
                    wr_fifo2 <= '1';
                    rd_fifo2 <= '1';
                    wr_fifo3 <= '1';
                    rd_fifo3 <= '1';
                    counter_in <= counter_in + 1;
                    if valid_in = '1' then 
                        second_image_counter <= second_image_counter + 1;
                    end if;
                elsif counter_in = (N*N+N-2)  then 
                    --counter_out_fifo3 <= (others => '0');
                    --new_image_came <= '0';
                    wr_fifo1 <= '0' or valid_in;
                    rd_fifo1 <= '0' or valid_in;
                    wr_fifo2 <= '1';
                    rd_fifo2 <= '1';
                    wr_fifo3 <= '1';
                    rd_fifo3 <= '1';
                    counter_in <= counter_in + 1;
                    if valid_in = '1' then 
                        second_image_counter <= second_image_counter + 1;
                    end if;
                elsif counter_in < (N*N+N+N-2) then
                    wr_fifo1 <= '0' or valid_in;
                    rd_fifo1 <= '0' or valid_in;
                    wr_fifo2 <= '0' or valid_in;
                    rd_fifo2 <= '1';
                    wr_fifo3 <= '1';
                    rd_fifo3 <= '1';
                    counter_in <= counter_in + 1;
                    if valid_in = '1' then 
                        second_image_counter <= second_image_counter + 1;
                    end if;
                elsif counter_in = (N*N+N+N-2) or counter_in = (N*N+N+N-1) then
                    wr_fifo1 <= '0' or valid_in;
                    rd_fifo1 <= '0' or valid_in;
                    wr_fifo2 <= '0' or valid_in;
                    rd_fifo2 <= '0' or valid_in;
                    wr_fifo3 <= '1';
                    rd_fifo3 <= '1';
                    counter_in <= counter_in + 1;
                    if valid_in = '1' then 
                        second_image_counter <= second_image_counter + 1;
                    end if;
                elsif counter_in = (N*N+N+N) then
                    wr_fifo1 <= '0' or valid_in;
                    rd_fifo1 <= '0' or valid_in;
                    wr_fifo2 <= '0' or valid_in;
                    rd_fifo2 <= '0' or valid_in;
                    wr_fifo3 <= '1';
                    rd_fifo3 <= '1';
                    counter_in <= counter_in + 1;
                    all_data_read <= '0';
                    if valid_in = '1' then 
                        second_image_counter <= second_image_counter + 1;
                    end if;
                elsif counter_in < (N*N+N+N+N-2) then
                    wr_fifo1 <= '0' or valid_in;
                    rd_fifo1 <= '0' or valid_in;
                    wr_fifo2 <= '0' or valid_in;
                    rd_fifo2 <= '0' or valid_in;
                    wr_fifo3 <= '0' or valid_in;
                    rd_fifo3 <= '1';
                    counter_in <= counter_in + 1;
                    if valid_in = '1' then 
                        second_image_counter <= second_image_counter + 1;
                    end if;
                elsif counter_in = (N*N+N+N+N-2) then
                    wr_fifo1 <= '0' or valid_in;
                    rd_fifo1 <= '0' or valid_in;
                    wr_fifo2 <= '0' or valid_in;
                    rd_fifo2 <= '0' or valid_in;
                    wr_fifo3 <= '0' or valid_in;
                    rd_fifo3 <= '0' or valid_in;
                    counter_in <= second_image_counter;
                    if valid_in = '1' then 
                        second_image_counter <= second_image_counter + 1;
                    end if;
                end if;
            end if;
        end if;
    end if;
    
    
   
end process;
    
end Behavioral;