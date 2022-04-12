----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2022 01:00:42 AM
-- Design Name: 
-- Module Name: fir_filter - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

entity fir_filter is
  Port ( clk : in std_logic;
         rst : in std_logic;
         valid_in : in std_logic;
         x : in std_logic_vector(7 downto 0);
         valid_out : out std_logic;
         fir_output : out std_logic_vector (19 downto 0)); 
end fir_filter;

architecture Behavioral of fir_filter is

    component signal_register is
    Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component mlab_ram is
        generic (
            data_width : integer :=8  	
         );
        port (clk  : in std_logic;
              we   : in std_logic;						
              en   : in std_logic;	
              rst : in std_logic;			
              addr : in std_logic_vector(2 downto 0);			
              di   : in std_logic_vector(data_width-1 downto 0);		
              do   : out std_logic_vector(data_width-1 downto 0)
       );	
    end component;
    
    component mlab_rom is
        generic (
            coeff_width : integer :=8  				
	   );
        Port ( clk : in  STD_LOGIC;
               en : in  STD_LOGIC;				
               addr : in  STD_LOGIC_VECTOR (2 downto 0);			
               rom_out : out  STD_LOGIC_VECTOR (coeff_width-1 downto 0));	
    end component;
    
    component mac is
        Port( rom_output : in std_logic_vector (7 downto 0);
            ram_output : in std_logic_vector (7 downto 0);
            mac_init : in std_logic;
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            mac_output : out std_logic_vector (19 downto 0)); 
    end component;
    
    component control_unit is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           valid_in : in STD_LOGIC;
           rom_address : out STD_LOGIC_VECTOR (2 downto 0);
           ram_address : out STD_LOGIC_VECTOR (2 downto 0);
           we: out STD_LOGIC := '0';
           mac_init : out STD_LOGIC;
           valid_out : out STD_LOGIC);
    end component;
    
    component reg is
    Port ( D : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           Q : out STD_LOGIC);
    end component;
    

    
    signal we_ram, en_ram, en_rom, mac_initialization : std_logic;
    signal addr_ram, addr_rom : std_logic_vector(2 downto 0);
    signal sig_buf, di_ram, output_of_ram, output_of_rom : std_logic_vector(7 downto 0);
    signal mac_init_buf, valid_out_buf :std_logic;
    begin
    en_ram <= '1';
    en_rom <= '1';
    
    signal_reg: signal_register port map(D=>x, clk=>clk, rst=>rst, Q=>sig_buf);
    control: control_unit port map(clk=>clk, rst=>rst, valid_in=>valid_in, rom_address=>addr_rom, ram_address=>addr_ram, we=>we_ram, mac_init=>mac_init_buf, valid_out=>valid_out_buf);
    mac_init_reg : reg port map(D=>mac_init_buf, clk=>clk, rst=>rst, Q=>mac_initialization);
    valid_out_reg : reg port map(D=>valid_out_buf, clk=>clk, rst=>rst, Q=>valid_out);
    ram: mlab_ram port map(clk=>clk, we=>we_ram, en=>en_ram, rst=>rst, addr=>addr_ram, di=>sig_buf, do=>output_of_ram);
    rom: mlab_rom port map(clk=>clk, en=>en_rom, addr=>addr_rom, rom_out=>output_of_rom);
    mac_label: mac port map(rom_output=>output_of_rom, ram_output=>output_of_ram, mac_init=>mac_initialization, clk=>clk, rst=>rst, mac_output=>fir_output);

end Behavioral;