library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity custom_fifo_with_almost_full_flag is
    PORT (
        clk : IN STD_LOGIC;
        srst : IN STD_LOGIC;
        din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        wr_en : IN STD_LOGIC;
        system_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        valid : OUT STD_LOGIC
      );
end custom_fifo_with_almost_full_flag;

architecture Behavioral of custom_fifo_with_almost_full_flag is
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
    
    signal almost_full_mine : std_logic := '0';
    signal fifo_out : std_logic_vector(7 downto 0);
    signal dontcare_full, dontcare_empty, valid_reg, valid_reg_and_wr_en : std_logic; --fifo gave an output(almost full flag) and we have a new input)
    
begin

generator: fifo_generator_1 port map (clk => clk, srst => srst, din => din, wr_en => wr_en, rd_en => almost_full_mine, dout => fifo_out, full => dontcare_full,
                                      almost_full => almost_full_mine, empty => dontcare_empty, valid => valid_reg );
generator_reg: reg_clk_and_valid_in port map(D => fifo_out, clk => clk, valid_in => wr_en, rst => srst, Q => system_out);
valid_out: reg_1bit port map(D => valid_reg_and_wr_en, clk => clk, rst => srst, Q => valid);

    process(valid_reg, wr_en) begin
        valid_reg_and_wr_en <= valid_reg and wr_en;
    end process;
end Behavioral;
