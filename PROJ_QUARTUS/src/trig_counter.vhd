library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity trig_counter is
  generic (
    P : integer := 8
);
    port (
        freq_vent_i : in std_logic;
        clk_i : in std_logic;
        nb_periode_o : out std_logic_vector (P - 1 downto 0);
        arst_i, srst_i : in std_logic

    );
end entity trig_counter;

architecture rtl of trig_counter is
    signal front_montant : std_logic;
begin

   
--instance trigger
  trigger_inst : entity work.trigger
  generic map (
    C_ASYNC => TRUE
  )
  port map (
    freq_vent_i => freq_vent_i,
    clk_i => clk_i,
    bool_trigger_o => front_montant
  );

  --instance counter
  counter_inst : entity work.counter
  generic map (
    N => 8
  )
  port map (
    arst_i => arst_i,
    clk_i => clk_i,
    srst_i => srst_i,
    en_i => front_montant,
    q_o => nb_periode_o 
  );

    
end architecture rtl;