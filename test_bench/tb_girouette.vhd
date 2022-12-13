library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_girouette is
end entity tb_girouette;

architecture rtl of tb_girouette is

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

    girouette_inst : entity work.girouette
    generic map (
        B => 4999,
        N => 13
    )
    port map (
        arst => arst,
        clk => clk,
        vent => vent,
        dir_vent => open,
        continu => '0',
        start_stop => '0',
        data_valid => open
    );

end architecture rtl;