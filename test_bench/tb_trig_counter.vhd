library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_trig_counter is
end entity tb_trig_counter;

architecture rtl of tb_trig_counter is

constant CLK_PER : time := 20 ns;
signal clk, d, arst_n, srst_n : std_logic := '0';


begin
    clk <= not clk after CLK_PER / 2;
    arst_n <= '1' after 63 ns;
    srst_n <= '0' after 63 ns;
    trig_counter_inst : entity work.trig_counter
    port map (
    freq_vent_i => d,
    clk_i => clk,
    nb_periode_o =>open,
    arst_i => arst_n,
    srst_i => srst_n
   );

   process
   begin
     d <= '0'; wait for 2*CLK_PER;
     d <= '1'; wait for 2*CLK_PER;
     d <= '0'; wait for 2*CLK_PER;
     d <= '1'; wait for CLK_PER;
     d <= '0'; wait for CLK_PER;
   end process;
    
end architecture rtl;