library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity trigger is
    generic (
        C_ASYNC : boolean := TRUE
    );
    port (
        freq_vent_i : in std_logic;
        clk_i : in std_logic;
        bool_trigger_o : out std_logic
    );
end entity trigger;

architecture rtl of trigger is

    signal q0, q1 : std_logic;
    
begin
    
    gen_sync : if C_ASYNC = FALSE generate
        q0 <= freq_vent_i;
    end generate gen_sync;

    gen_async : if C_ASYNC = TRUE generate

        bascule_d_inst : entity work.bascule_d
        port map (
            pre_i => '0',
            clr_i => '0',
            clk_i => clk_i,
            d_i => freq_vent_i,
            q_o => q0,
            q_n_o => open
        );

    end generate gen_async;

        delay_bascule_d_inst : entity work.bascule_d
        port map (
            pre_i => '0',
            clr_i => '0',
            clk_i => clk_i,
            d_i => q0,
            q_o => q1,
            q_n_o => open
        );
    
    bool_trigger_o <= '1' when q1 = '0' and q0 = '1' else '0';


end architecture rtl;