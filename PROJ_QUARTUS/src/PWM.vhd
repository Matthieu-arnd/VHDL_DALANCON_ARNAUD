library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PWM is
    port (
        arst_i : in std_logic;
        clk_i : in std_logic; 
        freq_i : in std_logic_vector(7 downto 0);
        duty_i : in std_logic_vector(7 downto 0);
        en_pwm_i : in std_logic;
        pwm_out : out std_logic
    );
end entity PWM;

architecture rtl of PWM is

    signal reset_counter : std_logic;
    signal sqn : std_logic_vector(31 downto 0);
    signal pwm_on : std_logic;

    begin

    -- Instance du compteur  : 
    counter_inst : entity work.counter
    generic map (
        N => 32
    )
    port map (
        arst_i => arst_i,
        clk_i => clk_i,
        srst_i => reset_counter,
        en_i => '1',
        q_o => sqn
    );


    -- Comparateurs : 

        -- Fréquence : 

        reset_counter <= '1' when sqn > freq_i else '0';
    
        -- Période : 

        pwm_on <= '1' when sqn < duty_i else '0';

        pwm_out <= pwm_on;

    end architecture rtl;