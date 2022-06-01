library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity custom_fifo_with_almost_full_flag_N_32 is
    generic (
		line_size : STD_LOGIC_VECTOR := "100000"
	 );
    PORT (
        clk : IN STD_LOGIC;
        srst : IN STD_LOGIC;
        din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        wr_en : IN STD_LOGIC;
        new_image2 : in std_logic;
        --wr_enabled : out std_logic;
        system_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        valid_out : OUT STD_LOGIC;
        counter : inout std_logic_vector(11 downto 0) := (others=>'0');
        counter_in : inout std_logic_vector(11 downto 0) := (others=>'0')
      );
end custom_fifo_with_almost_full_flag_N_32;

architecture Behavioral of custom_fifo_with_almost_full_flag_N_32 is
   
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
    
    component reg_1bit is
        Port ( D : in STD_LOGIC;
               clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               Q : out STD_LOGIC);
    end component;
    
    signal almost_full_mine, wr_en_or_last_pixels : std_logic;
    signal almost_full_mine_or_last_pixels : std_logic := '0';
    signal fifo_out : std_logic_vector(7 downto 0);
    signal dontcare_full, dontcare_empty, valid_reg, valid_reg_and_wr_en : std_logic; --fifo gave an output(almost full flag) and we have a new input)
    
    
    signal N_squared : std_logic_vector(11 downto 0);
    --signal counter_in : std_logic_vector(11 downto 0) := (others=>'0');
    signal last_pixels : std_logic := '0';
    signal srst2 : std_logic := '1';
    signal wr_enabled_after_new_image, new_image_came, srst_fifo : std_logic ;
    
begin

N_squared <= line_size*line_size;

generator: fifo_generator_1 port map (clk => clk, srst => srst_fifo, din => din, wr_en => wr_enabled_after_new_image, rd_en => almost_full_mine_or_last_pixels, dout => fifo_out, full => dontcare_full,
                                      almost_full => almost_full_mine, empty => dontcare_empty, valid => valid_reg );
generator_reg: reg_clk_and_valid_in port map(D => fifo_out, clk => clk, valid_in => valid_reg, rst => srst, Q => system_out);
valid_out2: reg_1bit_available_output port map(D => valid_reg, clk => clk, valid_in=>valid_reg, 
            rst => srst2, Q => valid_out);
            
    process(clk, srst, new_image) begin
        if srst_fifo = '1' or srst = '1' then
            if srst = '1' then
                srst_fifo <= '1';
            end if;
            last_pixels <= '0';
            srst2 <= '0';
            counter <= (others=>'0');
            counter_in <= (others=>'0');
            almost_full_mine_or_last_pixels <= '0';
            new_image_came <= '0';  --disable fifo until new_image signal comes
            srst_fifo <= '0';
        else
            
            if valid_reg = '1' and (rising_edge(clk)) then
                counter <= counter + 1;
            end if;
            
            if wr_enabled_after_new_image = '1' and (rising_edge(clk)) then
                counter_in <= counter_in + 1;
                if counter_in >= N_squared  then
                    if new_image2 = '1' then
                        new_image_came <= '1';  
                    else
                        new_image_came <= '0'; 
                    end if;  
                    counter_in <= (others=>'0'); 
                end if; 
            end if;
            
            if new_image2 = '1' then
                new_image_came <= '1';  
                --counter_in <= "000000000001"; 
            end if;  
            
            if counter >= N_squared then
                
                last_pixels <= '0';
                --srst2 <= '0';
                if new_image_came = '0' then
                    srst_fifo <= '1';
                    wr_enabled_after_new_image <= '0';
                    almost_full_mine_or_last_pixels <= '0';
                else
                    almost_full_mine_or_last_pixels <= almost_full_mine;
                end if;
                counter <= (others=>'0');
                --new_image_came <= '0';  --disable fifo until new_image signal comes
            elsif counter >= N_squared - line_size then
                last_pixels <= '1';
                almost_full_mine_or_last_pixels <= (last_pixels or almost_full_mine);
            else 
               srst2 <= '1'; 
               almost_full_mine_or_last_pixels <= (last_pixels or (almost_full_mine and new_image_came));
            end if;

            wr_enabled_after_new_image <= wr_en and (new_image_came or new_image2);
        end if;
    end process;
    
    --process(new_image2) begin
        --if new_image2 = '1' then
            --new_image_came <= '1';         
        --end if;      
    --end process;
    
    --process(wr_en, new_image_came, clk) begin
        --wr_enabled_after_new_image <= wr_en and new_image_came;
    --end process;
    
    --process (wr_enabled_after_new_image) begin
        --wr_enabled <= new_image_came;
    --end process;
end Behavioral;
