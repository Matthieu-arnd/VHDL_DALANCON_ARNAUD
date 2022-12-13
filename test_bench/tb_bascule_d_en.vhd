library IEEE;
use IEEE.std_logic_1164.all;

entity tb_bascule_d_en is
end entity tb_bascule_d_en;

architecture rtl of tb_bascule_d_en is
    constant CLK_PER : time := 20 ns;
    signal clr, pre : std_logic := '1';
    signal clk, d : std_logic := '0';
    signal en : std_logic := '0';

    begin

        clk <= not clk after CLK_PER / 2;
        bascule_d_en_inst : entity work.bascule_d_en
    port map (
        pre_i => pre, clr_i => clr, clk_i => clk,
        d_i => d, q_o => open,en_i => en);
        
        process
             begin
                en <= '0'; wait for 10*CLK_PER;
                en <= '1'; wait for 10*CLK_PER;
                pre <= '1'; clr <= '1'; d <= '0'; wait for 2*CLK_PER;
                pre <= '0'; clr <= '1'; d <= '0'; wait for 2*CLK_PER;
                pre <= '0'; clr <= '0'; d <= '1'; wait for 3*CLK_PER;
                pre <= '0'; clr <= '0'; d <= '0'; wait for 3*CLK_PER;
                pre <= '0'; clr <= '0'; d <= '1'; wait for CLK_PER;
                pre <= '0'; clr <= '0'; d <= '0'; wait for CLK_PER;
        end process;
end architecture rtl;


