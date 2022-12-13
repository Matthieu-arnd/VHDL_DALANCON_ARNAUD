library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity girouette 
is
    generic (
        B : integer := 4999;
        N : integer := 13
    );
    port (
        arst : in std_logic;
        clk : in std_logic;
        vent : in std_logic;
        dir_vent : out std_logic_vector(N-1 downto 0);
        continu : in std_logic;
        start_stop : in std_logic;
        data_valid: out std_logic
    );
end entity girouette;

architecture rtl of girouette is

    signal y : std_logic;
    signal q_counter1 : std_logic_vector(N-1 downto 0);
    signal q_counter2 : std_logic_vector(N-1 downto 0);
    signal fall_edge : std_logic;
   -- signal nvent : std_logic;
    

begin

     -- Instance du compteur n°1 : 
     counter_inst1 : entity work.counter
     generic map (
         N => N
     )
     port map (
         arst_i => arst,
         clk_i => clk,
         srst_i => y,
         en_i => vent,
         q_o => q_counter1
     );

    -- Comparaison pour compter jusqu'à 360 ms : 
     y <= '1' when unsigned(q_counter1) >= B else '0';
    
    -- Inversion signal vent
    --nvent <= not vent;
    
     -- Instance du compteur n°2 : 
     counter_inst2 : entity work.counter
     generic map (
         N => N
     )
     port map (
         arst_i => arst,
         clk_i => clk,
         srst_i =>fall_edge,
         en_i => y,
         q_o => q_counter2
     );

    -- Instance du trigger pour détecter les fronts descendants : 
    trigger_re_fe_inst : entity work.trigger_re_fe
    generic map (
        C_ASYNC => TRUE
    )
    port map (
        freq_vent_i => vent,
        clk_i => clk,
        fe_o => fall_edge,
        re_o => open
    );

  

    -- Instance du registre : 
    registre_inst : entity work.registre
    generic map (
        N => N
    )
    port map (
        clk => clk,
        arst => arst,
        E => q_counter2,
        en => fall_edge,
        Q => dir_vent
    );

end architecture rtl;