----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.03.2022 16:50:30
-- Design Name: 
-- Module Name: full_adder_structural - Structural
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



entity full_adder_structural is
    Port ( FA, FB, FCin : in STD_LOGIC;
           FS, FCout : out STD_LOGIC
          );
        
end full_adder_structural;

architecture Structural of full_adder_structural is
    component half_adder_dataflow is
        Port ( A, B : in STD_LOGIC;
               S, Cout : out STD_LOGIC
             );
    end component;
    
    component or_gate is
        Port ( X, Y : in STD_LOGIC;
               Z : out STD_LOGIC
             );
    end component;
    
    signal S0, C0, C1 : STD_LOGIC;
begin

U1: half_adder_dataflow PORT MAP (A=>FA, B=>FB, S=>S0, Cout=>C0);
U2: half_adder_dataflow PORT MAP (A=>S0, B=>FCin, S=>FS, Cout=>C1);
U3: or_gate PORT MAP (X=>C0, Y=>C1, Z=>FCout);

end Structural;
