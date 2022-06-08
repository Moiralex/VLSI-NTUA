library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dvlsi2021_lab5_top is
  port (
        DDR_cas_n         : inout STD_LOGIC;
        DDR_cke           : inout STD_LOGIC;
        DDR_ck_n          : inout STD_LOGIC;
        DDR_ck_p          : inout STD_LOGIC;
        DDR_cs_n          : inout STD_LOGIC;
        DDR_reset_n       : inout STD_LOGIC;
        DDR_odt           : inout STD_LOGIC;
        DDR_ras_n         : inout STD_LOGIC;
        DDR_we_n          : inout STD_LOGIC;
        DDR_ba            : inout STD_LOGIC_VECTOR( 2 downto 0);
        DDR_addr          : inout STD_LOGIC_VECTOR(14 downto 0);
        DDR_dm            : inout STD_LOGIC_VECTOR( 3 downto 0);
        DDR_dq            : inout STD_LOGIC_VECTOR(31 downto 0);
        DDR_dqs_n         : inout STD_LOGIC_VECTOR( 3 downto 0);
        DDR_dqs_p         : inout STD_LOGIC_VECTOR( 3 downto 0);
        FIXED_IO_mio      : inout STD_LOGIC_VECTOR(53 downto 0);
        FIXED_IO_ddr_vrn  : inout STD_LOGIC;
        FIXED_IO_ddr_vrp  : inout STD_LOGIC;
        FIXED_IO_ps_srstb : inout STD_LOGIC;
        FIXED_IO_ps_clk   : inout STD_LOGIC;
        FIXED_IO_ps_porb  : inout STD_LOGIC
       );
end entity; -- dvlsi2021_lab5_top

architecture arch of dvlsi2021_lab5_top is

  component design_1_wrapper is
    port (
          DDR_cas_n         : inout STD_LOGIC;
          DDR_cke           : inout STD_LOGIC;
          DDR_ck_n          : inout STD_LOGIC;
          DDR_ck_p          : inout STD_LOGIC;
          DDR_cs_n          : inout STD_LOGIC;
          DDR_reset_n       : inout STD_LOGIC;
          DDR_odt           : inout STD_LOGIC;
          DDR_ras_n         : inout STD_LOGIC;
          DDR_we_n          : inout STD_LOGIC;
          DDR_ba            : inout STD_LOGIC_VECTOR( 2 downto 0);
          DDR_addr          : inout STD_LOGIC_VECTOR(14 downto 0);
          DDR_dm            : inout STD_LOGIC_VECTOR( 3 downto 0);
          DDR_dq            : inout STD_LOGIC_VECTOR(31 downto 0);
          DDR_dqs_n         : inout STD_LOGIC_VECTOR( 3 downto 0);
          DDR_dqs_p         : inout STD_LOGIC_VECTOR( 3 downto 0);
          FIXED_IO_mio      : inout STD_LOGIC_VECTOR(53 downto 0);
          FIXED_IO_ddr_vrn  : inout STD_LOGIC;
          FIXED_IO_ddr_vrp  : inout STD_LOGIC;
          FIXED_IO_ps_srstb : inout STD_LOGIC;
          FIXED_IO_ps_clk   : inout STD_LOGIC;
          FIXED_IO_ps_porb  : inout STD_LOGIC;
          --------------------------------------------------------------------------
          ----------------------------------------------- PL (FPGA) COMMON INTERFACE
          ACLK                                : out STD_LOGIC;
          ARESETN                             : out STD_LOGIC_VECTOR(0 to 0);
          ------------------------------------------------------------------------------------
          -- PS2PL-DMA AXI4-STREAM MASTER INTERFACE TO ACCELERATOR AXI4-STREAM SLAVE INTERFACE
          M_AXIS_TO_ACCELERATOR_tdata         : out STD_LOGIC_VECTOR(7 downto 0);
          M_AXIS_TO_ACCELERATOR_tkeep         : out STD_LOGIC_VECTOR( 0    to 0);
          M_AXIS_TO_ACCELERATOR_tlast         : out STD_LOGIC;
          M_AXIS_TO_ACCELERATOR_tready        : in  STD_LOGIC;
          M_AXIS_TO_ACCELERATOR_tvalid        : out STD_LOGIC;
          ------------------------------------------------------------------------------------
          -- ACCELERATOR AXI4-STREAM MASTER INTERFACE TO PL2P2-DMA AXI4-STREAM SLAVE INTERFACE
          S_AXIS_S2MM_FROM_ACCELERATOR_tdata  : in  STD_LOGIC_VECTOR(31 downto 0);
          S_AXIS_S2MM_FROM_ACCELERATOR_tkeep  : in  STD_LOGIC_VECTOR( 3 downto 0);
          S_AXIS_S2MM_FROM_ACCELERATOR_tlast  : in  STD_LOGIC;
          S_AXIS_S2MM_FROM_ACCELERATOR_tready : out STD_LOGIC;
          S_AXIS_S2MM_FROM_ACCELERATOR_tvalid : in  STD_LOGIC
         );
  end component design_1_wrapper;


--    component main_node is
--      generic (N: std_logic_vector(11 downto 0) := "000000100000");
--      Port (clk : in std_logic;
--            rst, valid_in, new_image : in std_logic;
--            input : in std_logic_vector(7 downto 0);
--            red : out std_logic_vector(7 downto 0);
--            green : out std_logic_vector(7 downto 0);
--            blue : out std_logic_vector(7 downto 0);
--            --debug
--            next_state: out std_logic_vector(1 downto 0);
--            counter_in : inout std_logic_vector(10 downto 0);
--            --debug
--            valid_out, image_finished : out std_logic);
--    end component;
    
--    component reg_1bit is
--        Port ( D : in STD_LOGIC;
--               clk : in STD_LOGIC;
--               rst : in STD_LOGIC;
--               Q : out STD_LOGIC :='0');
--    end component;
    
--    component reg_8bit is
--        Port ( D : in std_logic_vector(7 downto 0);
--               clk : in STD_LOGIC;
--               rst : in STD_LOGIC;
--               Q : out std_logic_vector(7 downto 0));
--    end component;

component main_node_new_image_generator is
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
        counter_in : inout std_logic_vector(20 downto 0);
        --debug
        valid_out, image_finished : out std_logic);
end component;
-------------------------------------------
-- INTERNAL SIGNAL & COMPONENTS DECLARATION

  signal aclk    : std_logic;
  signal aresetn : std_logic_vector(0 to 0);

  signal tmp_tdata, tmp_data_reg, red, green, blue  : std_logic_vector(7 downto 0);
  signal tmp_tkeep  : std_logic_vector(0 downto 0);
  signal tmp_tlast  : std_logic;
  signal tmp_tready : std_logic;
  signal tmp_tvalid, tmp_valid_reg, valid_out, image_finished, new_image: std_logic;
  signal rst, not_prev_valid: std_logic;
  signal tdata_output : std_logic_vector(31 downto 0);

begin

  PROCESSING_SYSTEM_INSTANCE : design_1_wrapper
    port map (
              DDR_cas_n         => DDR_cas_n,
              DDR_cke           => DDR_cke,
              DDR_ck_n          => DDR_ck_n,
              DDR_ck_p          => DDR_ck_p,
              DDR_cs_n          => DDR_cs_n,
              DDR_reset_n       => DDR_reset_n,
              DDR_odt           => DDR_odt,
              DDR_ras_n         => DDR_ras_n,
              DDR_we_n          => DDR_we_n,
              DDR_ba            => DDR_ba,
              DDR_addr          => DDR_addr,
              DDR_dm            => DDR_dm,
              DDR_dq            => DDR_dq,
              DDR_dqs_n         => DDR_dqs_n,
              DDR_dqs_p         => DDR_dqs_p,
              FIXED_IO_mio      => FIXED_IO_mio,
              FIXED_IO_ddr_vrn  => FIXED_IO_ddr_vrn,
              FIXED_IO_ddr_vrp  => FIXED_IO_ddr_vrp,
              FIXED_IO_ps_srstb => FIXED_IO_ps_srstb,
              FIXED_IO_ps_clk   => FIXED_IO_ps_clk,
              FIXED_IO_ps_porb  => FIXED_IO_ps_porb,
              --------------------------------------------------------------------------
              ----------------------------------------------- PL (FPGA) COMMON INTERFACE
              ACLK                                => aclk,    -- clock to accelerator
              ARESETN                             => aresetn, -- reset to accelerator, active low
              ------------------------------------------------------------------------------------
              -- PS2PL-DMA AXI4-STREAM MASTER INTERFACE TO ACCELERATOR AXI4-STREAM SLAVE INTERFACE
              M_AXIS_TO_ACCELERATOR_tdata         => tmp_tdata,
              M_AXIS_TO_ACCELERATOR_tkeep         => "1",
              M_AXIS_TO_ACCELERATOR_tlast         => tmp_tlast,
              M_AXIS_TO_ACCELERATOR_tready        => '1',
              M_AXIS_TO_ACCELERATOR_tvalid        => tmp_tvalid,
              ------------------------------------------------------------------------------------
              -- ACCELERATOR AXI4-STREAM MASTER INTERFACE TO PL2P2-DMA AXI4-STREAM SLAVE INTERFACE
              S_AXIS_S2MM_FROM_ACCELERATOR_tdata  => tdata_output,
              --S_AXIS_S2MM_FROM_ACCELERATOR_tkeep  => tmp_tkeep & tmp_tkeep & tmp_tkeep & tmp_tkeep,
              S_AXIS_S2MM_FROM_ACCELERATOR_tkeep => "1",
              S_AXIS_S2MM_FROM_ACCELERATOR_tlast  => image_finished,
              S_AXIS_S2MM_FROM_ACCELERATOR_tready => tmp_tready,
              S_AXIS_S2MM_FROM_ACCELERATOR_tvalid => valid_out
             );

----------------------------
-- COMPONENTS INSTANTIATIONS

--rst <= aresetn(0);
--tdata_output <= "00000000" & red & green & blue;
--valid_delay_reg: reg_1bit port map (D=>tmp_tvalid, clk => aclk, rst => rst, Q => tmp_valid_reg);
--input_delay_reg: reg_8bit port map (D=>tmp_tdata, clk => aclk, rst => rst, Q => tmp_data_reg);

--not_prev_valid <= not tmp_valid_reg;
--new_image <= not_prev_valid and tmp_tvalid;

--     main_node_instance: main_node
--      generic map(N => "000000100000")
--      Port map (clk => aclk,
--            rst => rst,
--            valid_in =>tmp_valid_reg,
--            new_image => new_image,
--            input =>tmp_data_reg,
--            red => red,
--            green =>green,
--            blue =>blue,
--            --debug
--            next_state => open,
--            counter_in => open,
--            --debug
--            valid_out =>valid_out, 
--            image_finished =>image_finished );

rst <= aresetn(0);
main_node: main_node_new_image_generator
    generic map (N => "000000100000")
    port map (clk => aclk,
        rst => rst,
        tmp_tvalid => tmp_tvalid,
        input => tmp_tdata,
        tdata_output => tdata_output,
        valid_in_test => open,
        new_image_test => open,
        red_test => open,
        green_test => open,
        blue_test => open,
        next_state => open,
        counter_in => open,       
        
        valid_out => valid_out,
        image_finished => image_finished
        );



end architecture; -- arch