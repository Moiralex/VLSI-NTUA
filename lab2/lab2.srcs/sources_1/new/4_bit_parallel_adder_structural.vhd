----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.03.2022 19:08:31
-- Design Name: 
-- Module Name: 4_bit_parallel_adder_structural - Structural
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

entity four_bit_parallel_adder_structural is
    Port ( P4A : in STD_LOGIC_VECTOR (3 downto 0);
           P4B : in STD_LOGIC_VECTOR (3 downto 0);
           PCin : in STD_LOGIC;
           P4S : out STD_LOGIC_VECTOR (3 downto 0);
           PCout : out STD_LOGIC);
end four_bit_parallel_adder_structural;

architecture Structural of four_bit_parallel_adder_structural is

component full_adder_structural is
    Port ( FA, FB, FCin : in STD_LOGIC;
           FS, FCout : out STD_LOGIC
          );
        
end component;

signal C1, C2, C3 : STD_LOGIC;

begin

U1: full_adder_structural PORT MAP (FA=>P4A(0), FB=>P4B(0), FCin=>PCin, FS=>P4S(0), FCout=>C1);
U2: full_adder_structural PORT MAP (FA=>P4A(1), FB=>P4B(1), FCin=>C1, FS=>P4S(1), FCout=>C2);
U3: full_adder_structural PORT MAP (FA=>P4A(2), FB=>P4B(2), FCin=>C2, FS=>P4S(2), FCout=>C3);
U4: full_adder_structural PORT MAP (FA=>P4A(3), FB=>P4B(3), FCin=>C3, FS=>P4S(3), FCout=>PCout);


end Structural;
