library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity delay_line_32 is
    generic (
		line_size : STD_LOGIC_VECTOR := "100000"
	 );
    PORT (
        clk : IN STD_LOGIC;
        srst : IN STD_LOGIC;
        din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        wr_en : IN STD_LOGIC;
        system_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        valid : OUT STD_LOGIC;
        counter : inout std_logic_vector(11 downto 0) := (others=>'0')
      );
end delay_line_32;

architecture Behavioral of delay_line_32 is
    component reg_1bit is
        Port ( D : in STD_LOGIC;
               clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               Q : out STD_LOGIC);
    end component;
    
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
    
    component reg_1bit_available_output is
        Port ( D : in STD_LOGIC;
               clk : in STD_LOGIC;
               valid_in : in std_logic;
               rst : in STD_LOGIC;
               Q : out STD_LOGIC);
    end component;

    signal almost_full_mine, almost_full_mine_or_last_pixels, wr_en_or_last_pixels : std_logic := '0';
    signal fifo_out : std_logic_vector(7 downto 0);
    signal dontcare_full, dontcare_empty, valid_reg, valid_reg_and_wr_en : std_logic; --fifo gave an output(almost full flag) and we have a new input)
    
    
    signal N_squared : std_logic_vector(11 downto 0);
    --signal counter : std_logic_vector(11 downto 0) := (others=>'0');
    signal last_pixels : std_logic := '0';
    signal srst2 : std_logic := '1';
    signal valid_signal : std_logic;
begin

N_squared <= line_size*line_size;

generator: fifo_generator_1 port map (clk => clk, srst => srst, din => din, wr_en => wr_en, rd_en => almost_full_mine_or_last_pixels, dout => fifo_out, full => dontcare_full,
                                      almost_full => almost_full_mine, empty => dontcare_empty, valid => valid_reg );
generator_reg: reg_clk_and_valid_in port map(D => fifo_out, clk => clk, valid_in => wr_en_or_last_pixels, rst => srst, Q => system_out);
valid_out: reg_1bit_available_output port map(D => wr_en_or_last_pixels, clk => clk, valid_in=>valid_reg, rst => srst2, Q => valid_signal);

    process(clk, srst) begin
        if srst = '1' then
            last_pixels <= '0';
            srst2 <= '0';
            counter <= (others=>'0');
            almost_full_mine_or_last_pixels <= '0';
        else
            if valid_signal = '1' and (rising_edge(clk)) then
                counter <= counter + 1;
            end if;
            if counter >= N_squared - line_size then
                last_pixels <= '1';
            end if;
            if counter >= N_squared -1  then
                last_pixels <= '0';
                srst2 <= '0';
                counter <= (others=>'0');
                almost_full_mine_or_last_pixels <= '0';
            else 
               srst2 <= '1'; 
               almost_full_mine_or_last_pixels <= last_pixels or almost_full_mine;
            end if;
            
        end if;
    end process;

    --process(last_pixels, almost_full_mine) begin
        --if counter >= N_squared then
            --almost_full_mine_or_last_pixels <= '0';
        --else
            --almost_full_mine_or_last_pixels <= last_pixels or almost_full_mine;
        --end if;
    --end process;
    
    process(last_pixels, wr_en) begin
        wr_en_or_last_pixels <= last_pixels or wr_en;
    end process;
    
    process(valid_signal) begin
        valid <= valid_signal;
    end process;
    
    --process(srst, last_pixels) begin
      --  if srst = '0' then 
        --    srst2 <= '0';
       -- elsif counter >= N_squared then 
         --   srst2 <= '0';
           -- counter <= (others=>'0');
        --end if;
    --end process;
end Behavioral;