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
    signal not_rst: std_logic;
    signal wr_fifo1, wr_fifo2, wr_fifo3 : std_logic;
    signal rd_fifo1, rd_fifo2, rd_fifo3 : std_logic;
    signal valid_fifo1, valid_fifo2, valid_fifo3 : std_logic;
    signal full_fifo1, full_fifo2, full_fifo3 : std_logic;
    signal dontcare1, dontcare2, dontcare3, dontcare4, dontcare5, dontcare6 :std_logic;
    signal new_image_came : std_logic := '0';
    
    signal wr1, rd1, wr2, rd2 , wr3, rd3  : std_logic;
    signal valid_in_vectorized : std_logic_vector(7 downto 0);
    signal counter_fifo1, counter_fifo2, counter_fifo3 : std_logic_vector (11 downto 0) := (others => '0');
    signal out_helper_fifo1, out_helper_fifo2, out_helper_fifo3 : std_logic_vector (7 downto 0);
    signal out_helper_fifo1_reg1, out_helper_fifo2_reg1, out_helper_fifo3_reg1 : std_logic;
    signal out_helper_fifo1_reg2, out_helper_fifo2_reg2, out_helper_fifo3_reg2 : std_logic;
    signal out_helper_fifo1_reg3, out_helper_fifo2_reg3, out_helper_fifo3_reg3 : std_logic;
    
    signal wr1_for_write_signal, rd1_for_write_signal, wr2_for_write_signal, rd2_for_write_signal : std_logic;
    signal counter_fifo1_for_write_signal, counter_fifo2_for_write_signal : std_logic_vector (11 downto 0) := (others => '0');
    signal out_helper_fifo1_for_write_signal, out_helper_fifo2_for_write_signal : std_logic_vector (7 downto 0);
    signal out_helper_fifo1_reg1_for_write_signal, out_helper_fifo2_reg1_for_write_signal : std_logic;
    signal out_helper_fifo1_reg2_for_write_signal, out_helper_fifo2_reg2_for_write_signal: std_logic;
    signal out_helper_fifo1_reg3_for_write_signal, out_helper_fifo2_reg3_for_write_signal : std_logic;
begin

fifo_gen_for_first_fifo: fifo_generator_1 port map (clk=>clk,  srst=>not_rst, din=>valid_in_vectorized, wr_en=>wr1, rd_en =>rd1, 
                dout => out_helper_fifo1, full=>open, almost_full=>open, empty=>open, valid=>valid_fifo1);
fifo_gen_for_second_fifo: fifo_generator_1 port map (clk=>clk,  srst=>not_rst, din=>valid_in_vectorized, wr_en=>wr2, rd_en=>rd2, 
                dout=> out_helper_fifo2, full=>open, almost_full=>open, empty=>open, valid=>valid_fifo2);
fifo_gen_for_third_fifo: fifo_generator_1 port map (clk=>clk,  srst=>not_rst, din=>valid_in_vectorized, wr_en=>wr3, rd_en=>rd3, 
                dout=> out_helper_fifo3, full=>open, almost_full=>open, empty=>open,  valid=>valid_fifo3);

fifo_gen_for_first_fifo_for_write: fifo_generator_1 port map (clk=>clk,  srst=>not_rst, din=>valid_in_vectorized,
                wr_en=>wr1_for_write_signal, rd_en =>rd1_for_write_signal, 
                dout => out_helper_fifo1_for_write_signal, full=>open, almost_full=>open, empty=>open, valid=>valid_fifo1);
fifo_gen_for_second_fifo_for_write: fifo_generator_1 port map (clk=>clk,  srst=>not_rst, din=>valid_in_vectorized, 
                wr_en=>wr2_for_write_signal, rd_en=>rd2_for_write_signal, 
                dout=> out_helper_fifo2_for_write_signal, full=>open, almost_full=>open, empty=>open, valid=>valid_fifo2);

fifo_first_line: fifo_generator_1 port map (clk=>clk,  srst=>not_rst, din=>input, wr_en=>valid_in, rd_en =>out_helper_fifo1(0),
                 dout => output_first_fifo,
                 full=>full_fifo1, almost_full=>dontcare1, empty=>dontcare2, valid=>valid_fifo1);
fifo_second_line: fifo_generator_1 port map (clk=>clk,  srst=>not_rst, din=>output_first_fifo, 
        wr_en=>out_helper_fifo1_for_write_signal(0), rd_en=>out_helper_fifo2(0), dout=>output_second_fifo, 
                 full=>full_fifo2, almost_full=>dontcare3, empty=>dontcare4, valid=>valid_fifo2);
fifo_third_line: fifo_generator_1 port map (clk=>clk,  srst=>not_rst, din=>output_second_fifo, 
            wr_en=>out_helper_fifo2_for_write_signal(0), rd_en=>out_helper_fifo3(0), dout=>output_third_fifo, 
                 full=>full_fifo3, almost_full=>dontcare5, empty=>dontcare6,  valid=>valid_fifo3);

first_reg: reg_1bit port map(D => out_helper_fifo1(0), clk => clk, rst => rst, Q => out_helper_fifo1_reg1);    
second_reg: reg_1bit port map(D => out_helper_fifo1_reg1, clk => clk, rst => rst, Q => out_helper_fifo1_reg2);
third_reg: reg_1bit port map(D => out_helper_fifo1_reg2, clk => clk, rst => rst, Q => out_helper_fifo1_reg3);

first_line_first_reg:  reg_clk_and_valid_in port map (D=>output_first_fifo, clk=>clk, valid_in=>out_helper_fifo1_reg1, rst=>rst, Q=>output_reg_1_1);
first_line_second_reg:  reg_clk_and_valid_in port map (D=>output_reg_1_1, clk=>clk, valid_in=>out_helper_fifo1_reg2, rst=>rst, Q=>output_reg_1_2);
first_line_third_reg:  reg_clk_and_valid_in port map (D=>output_reg_1_2, clk=>clk, valid_in=>out_helper_fifo1_reg3, rst=>rst, Q=>reg_output_1_3);


first_reg2: reg_1bit port map(D => out_helper_fifo2(0), clk => clk, rst => rst, Q => out_helper_fifo2_reg1);
second_reg2: reg_1bit port map(D => out_helper_fifo2_reg1, clk => clk, rst => rst, Q => out_helper_fifo2_reg2);
third_reg2: reg_1bit port map(D => out_helper_fifo2_reg2, clk => clk, rst => rst, Q => out_helper_fifo2_reg3);

second_line_first_reg:  reg_clk_and_valid_in port map (D=>output_second_fifo, clk=>clk, valid_in=>out_helper_fifo2_reg1, rst=>rst, Q=>output_reg_2_1);
second_line_second_reg:  reg_clk_and_valid_in port map (D=>output_reg_2_1, clk=>clk, valid_in=>out_helper_fifo2_reg2, rst=>rst, Q=>output_reg_2_2);
second_line_third_reg:  reg_clk_and_valid_in port map (D=>output_reg_2_2, clk=>clk, valid_in=>out_helper_fifo2_reg3, rst=>rst, Q=>reg_output_2_3);


first_reg3: reg_1bit port map(D => out_helper_fifo3(0), clk => clk, rst => rst, Q => out_helper_fifo3_reg1);
second_reg3: reg_1bit port map(D => out_helper_fifo3_reg1, clk => clk, rst => rst, Q => out_helper_fifo3_reg2);
third_reg3: reg_1bit port map(D => out_helper_fifo3_reg2, clk => clk, rst => rst, Q => out_helper_fifo3_reg3);

third_line_first_reg:  reg_clk_and_valid_in port map (D=>output_third_fifo, clk=>clk, valid_in=>out_helper_fifo3_reg1, rst=>rst, Q=>output_reg_3_1);
third_line_second_reg:  reg_clk_and_valid_in port map (D=>output_reg_3_1, clk=>clk, valid_in=>out_helper_fifo3_reg2, rst=>rst, Q=>output_reg_3_2);
third_line_third_reg:  reg_clk_and_valid_in port map (D=>output_reg_3_2, clk=>clk, valid_in=>out_helper_fifo3_reg3, rst=>rst, Q=>reg_output_3_3);

reg_output_1_1 <= output_reg_1_1;
reg_output_1_2 <= output_reg_1_2;
reg_output_2_1 <= output_reg_2_1;
reg_output_2_2 <= output_reg_2_2;
reg_output_3_1 <= output_reg_3_1;
reg_output_3_2 <= output_reg_3_2;
full <= full_fifo2;
not_rst <= not rst;
valid_in_vectorized(0) <= valid_in;

process (clk, new_image) begin
    if rst = '0' then 
        counter_fifo1 <= (others => '0');
        counter_fifo2 <= (others => '0');
        counter_fifo3 <= (others => '0');
        wr1 <= '0';
        rd1 <= '0';
        wr2 <= '0';
        rd2 <= '0';
        wr3 <= '0';
        rd3 <= '0';
        counter_fifo1_for_write_signal <= (others => '0');
        counter_fifo2_for_write_signal <= (others => '0');
        wr1_for_write_signal <= '0';
        rd1_for_write_signal <= '0';
        wr2_for_write_signal <= '0';
        rd2_for_write_signal <= '0';
    else 
        if new_image = '1' then
            new_image_came <= '1';
            wr_fifo1 <= valid_in ;
            --if valid_in = '1' then 
              --  counter_in <= counter_in + 1;
            --end if;
        end if;
        
        if rising_edge(clk) then
        
            if counter_fifo1<N-3 then --should be N+N-2 if we do not wanna miss first data (wr=1 at the beginning)
                counter_fifo1 <= counter_fifo1 + 1;
                wr1 <= '1';
                rd1 <= '0';
            else
                wr1 <= '1';
                rd1 <= '1';
            end if;
            
            if counter_fifo2<(N+N-3) then --should be N+N-2 if we do not wanna miss first data (wr=1 at the beginning)
                counter_fifo2 <= counter_fifo2 + 1;
                wr2 <= '1';
                rd2 <= '0';
            else
                wr2 <= '1';
                rd2 <= '1';
            end if;
            
            if counter_fifo3<(N+N+N-3) then --should be N+N-2 if we do not wanna miss first data (wr=1 at the beginning)
                counter_fifo3 <= counter_fifo3 + 1;
                wr3 <= '1';
                rd3 <= '0';
            else
                wr3 <= '1';
                rd3 <= '1';
            end if;
            
            if counter_fifo1_for_write_signal<N-2 then --should be N+N-2 if we do not wanna miss first data (wr=1 at the beginning)
                counter_fifo1_for_write_signal <= counter_fifo1_for_write_signal + 1;
                wr1_for_write_signal <= '1';
                rd1_for_write_signal <= '0';
            else
                wr1_for_write_signal <= '1';
                rd1_for_write_signal <= '1';
            end if;
            
            if counter_fifo2_for_write_signal<(N+N-2) then --should be N+N-2 if we do not wanna miss first data (wr=1 at the beginning)
                counter_fifo2_for_write_signal <= counter_fifo2_for_write_signal + 1;
                wr2_for_write_signal <= '1';
                rd2_for_write_signal <= '0';
            else
                wr2_for_write_signal <= '1';
                rd2_for_write_signal <= '1';
            end if;
            
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
                elsif (counter_in <= N*N-1) and (valid_in= '1') then
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
                    if counter_in = N*N-1 then 
                        counter_in <= (others=>'0');
                        new_image_came <= '0';
                        wr_fifo1 <= '0';
                    end if;
                end if;
            end if;
            if counter_out_fifo3 = N*N then 
                counter_out_fifo3 <= (others => '0');
                --new_image_came <= '0';
                --wr_fifo1 <= '0';
                --rd_fifo1 <= '0';
                --wr_fifo2 <= '0';
                --rd_fifo2 <= '0';
                --wr_fifo3 <= '0';
                rd_fifo3 <= '0';
            --elsif counter_out_fifo3 = N*N - 1 then 
                --if (rising_edge(clk)) then 
                --    counter_out_fifo3 <= counter_out_fifo3 + 1;
                --end if;
                --rd_fifo3 <= '0';
            elsif counter_out_fifo3 = (N*N-(N-1)) +1  then --31 stin 3h fifo
                rd_fifo3 <= '1';
                rd_fifo2 <= '0';
                wr_fifo3 <= '0';
                if (rising_edge(clk)) then 
                    counter_out_fifo3 <= counter_out_fifo3 + 1;
                end if;
            elsif counter_out_fifo3 > (N*N-(N-1)) then --31 stin 3h fifo(>
                rd_fifo3 <= '1';
                --rd_fifo2 <= '0';
                --wr_fifo3 <= '0';
                if (rising_edge(clk)) then 
                    counter_out_fifo3 <= counter_out_fifo3 + 1;
                end if;
            elsif counter_out_fifo3 = (N*N-(N+N-1)) + 1  then --31 stin 3h fifo kai 31 stin 2h fifo
                rd_fifo1 <= '0';
                rd_fifo2 <= '1';
                wr_fifo2 <= '0';
                if (rising_edge(clk)) then 
                    counter_out_fifo3 <= counter_out_fifo3 + 1;
                end if;
            elsif counter_out_fifo3 > (N*N-(N+N-1)) then --31 stin 3h fifo kai 31 stin 2h fifo(>961)
                --rd_fifo1 <= '0';
                rd_fifo2 <= '1';
                --wr_fifo2 <= '0';
                if (rising_edge(clk)) then 
                    counter_out_fifo3 <= counter_out_fifo3 + 1;
                end if;
            elsif counter_out_fifo3 > N*N-(N+N+N-1) - 1 then --31 stin 3h fifo kai 31 stin 2h fifo kai 31 sthn 1h(>929)
                rd_fifo1 <= '1';
                --counter_in <= "00000100000";
                if (rising_edge(clk)) then 
                    counter_out_fifo3 <= counter_out_fifo3 + 1;
                end if;
            end if; 
            
        end if;
    end if;
    
end process;
    
end Behavioral;