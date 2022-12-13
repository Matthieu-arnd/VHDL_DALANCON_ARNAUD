library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bascule_d is
    port (
        pre_i : in std_logic;
        clr_i : in std_logic;
        clk_i : in std_logic;
        d_i : in std_logic;
        q_o : out std_logic;
        q_n_o : out std_logic
    );
end entity bascule_d;

architecture rtl of bascule_d is

begin
    p_bascule_d : process(clk_i, clr_i, pre_i)
    begin
        if pre_i = '1' then
            q_o <= '1';
            q_n_o <= '0';
        elsif clr_i = '1' then
            q_o <= '0';
            q_n_o <= '1';
        elsif rising_edge(clk_i) then
            q_o <= d_i;
            q_n_o <= not d_i;
        end if;
    end process p_bascule_d;
end architecture rtl;