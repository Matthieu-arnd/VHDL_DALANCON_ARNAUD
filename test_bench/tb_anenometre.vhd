library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_anenometre is
end entity tb_anenometre;

architecture rtl of tb_anenometre is
    
    constant CLK_PER : time := 20 ns;
    signal clk, vent : std_logic := '0';
    signal arst : std_logic := '1';
    signal continu : std_logic := '1';
    signal start_stop : std_logic := '1';
    constant vent_per : time := 4 ms;


begin
    clk <= not clk after CLK_PER / 2;
    vent <= not vent after vent_per/2;
    arst <= '0' after 63 ns ;

  anenometre_inst : entity work.anenometre
  generic map (
    nb_bits => 8
  )
  port map (
    arst => arst,
    clk => clk,
    vent => vent,
    freq_vent => open,
    continu => continu,
    start_stop => start_stop,
    data_valid => open
  );

process 
begin

  continu <= '1';start_stop <= '0'; wait for 1001 ms; 
  continu <= '0';start_stop <= '0'; wait for 1001 ms;
  start_stop <= '1';continu <= '0'; wait for 1001 ms;
  start_stop <= '0';continu <='0'; wait for 1001 ms;

end process;
    
    
end architecture rtl;