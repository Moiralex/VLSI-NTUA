library IEEE;
use IEEE.std_logic_1164.all;

entity finite_state_machine is
    port ( early_valid, line0, rst, clk : in std_logic;
           y : out std_logic_vector(1 downto 0) := "00");
end finite_state_machine;

architecture fsm_arch of finite_state_machine is
    type state_type is (G_B, B, R, G_R);
    signal current_state, next_state : state_type := G_B;
begin
sync_proc: process(rst, clk)
    begin
        if (rst = '0') then
            current_state <= G_B; 
            --y <= "00";
        elsif rising_edge(clk) then
            case current_state is
                when G_B =>  --current state green in a line with green and blue
                    if early_valid = '0' then 
                        current_state <= G_B;
                        --y <= "00";
                    else
                        current_state <= B;
                        --y <= "01";
                    end if;
                when B => --current state blue
                    if early_valid = '0' then 
                        current_state <= B;
                        --y <= "01";
                    else
                        if line0 = '0' then
                            current_state <= G_B;
                            --y <= "00";
                        else    --line change
                            current_state <= R;
                            --y <= "10";
                        end if;
                    end if;
                when R => --current state red
                    if early_valid = '0' then 
                        current_state <= R;
                        --y <= "10";
                    else
                        current_state <= G_R;
                        --y <= "11";
                    end if;
                when G_R => --current state green in a line with green and red
                    if early_valid = '0' then 
                        current_state <= G_R;
                        --y <= "11";
                    else
                        if line0 = '0' then
                            current_state <= R;
                            --y <= "10";
                        else    --line change
                            current_state <= G_B;
                            --y <= "00";
                        end if;
                    end if;
                when others =>
                    current_state <= G_B;
            end case;
            --current_state <= next_state;
        end if;
    end process sync_proc;
    
    --we load the next state of previous calculation to current_state, if the state is
    --the same as before and we have the same early_valid and line0 values then the state  
    --stays the same again
--    comb_proc: process(current_state, line0, early_valid)
--    begin
--            case current_state is
--                when G_B =>  --current state green in a line with green and blue
--                    if early_valid = '0' then 
--                        next_state <= G_B;
--                        --y <= "00";
--                    else
--                        next_state <= B;
--                        --y <= "01";
--                    end if;
--                when B => --current state blue
--                    if early_valid = '0' then 
--                        next_state <= B;
--                        --y <= "01";
--                    else
--                        if line0 = '0' then
--                            next_state <= G_B;
--                            --y <= "00";
--                        else    --line change
--                            next_state <= R;
--                            --y <= "10";
--                        end if;
--                    end if;
--                when R => --current state red
--                    if early_valid = '0' then 
--                        next_state <= R;
--                        --y <= "10";
--                    else
--                        next_state <= G_R;
--                        --y <= "11";
--                    end if;
--                when G_R => --current state green in a line with green and red
--                    if early_valid = '0' then 
--                        next_state <= G_R;
--                        --y <= "11";
--                    else
--                        if line0 = '0' then
--                            next_state <= R;
--                            --y <= "10";
--                        else    --line change
--                            next_state <= G_B;
--                            --y <= "00";
--                        end if;
--                    end if;
--                when others =>
--                    next_state <= G_B;
--            end case;
--    end process comb_proc;
    
    with current_state select
        y <= "00" when G_B,
        "01" when B,
        "10" when R,
        "11" when G_R,
        "00" when others;
end fsm_arch;