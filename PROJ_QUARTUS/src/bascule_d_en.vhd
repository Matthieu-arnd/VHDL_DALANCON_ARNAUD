library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bascule_d_en is
    port (
        pre_i : in std_logic;
        clr_i : in std_logic;
        clk_i : in std_logic;
        d_i : in std_logic;
        en_i : in std_logic;
        q_o : out std_logic
    );
end entity bascule_d_en;

architecture rtl of bascule_d_en is

signal r : std_logic := '0' ; 
begin

    p_bascule_d_en : process(clk_i, clr_i, pre_i)
    begin
        if pre_i = '1' then
            q_o <= '1';
        elsif clr_i = '1' then
            q_o <= '0';
        elsif rising_edge(clk_i) then
            if en_i = '1'then 
                q_o <= d_i;
				r <= d_i;
            else 
                q_o <= r;
            end if;
        end if; 
    end process p_bascule_d_en;
end architecture rtl;