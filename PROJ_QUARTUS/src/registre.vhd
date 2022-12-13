library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity registre is
    generic (
        N : integer := 13
    );
    port (
        clk   : in std_logic;
        arst : in std_logic;
        E : in std_logic_vector(12 downto 0);
        en : in std_logic;
        Q : out std_logic_vector(12 downto 0)
    );
end entity;

architecture rtl of registre is


    begin

        GEN_BASCULE_D :
        for I in 0 to N-1 generate 
            bascule_d_en_inst : entity work.bascule_d_en 
                port map (
                    pre_i => '0',
                    clr_i => arst,
                    clk_i => clk,
                    d_i => E(I),
                    en_i => en,
                    q_o => Q(I)
              );
        end generate GEN_BASCULE_D;
    end architecture;