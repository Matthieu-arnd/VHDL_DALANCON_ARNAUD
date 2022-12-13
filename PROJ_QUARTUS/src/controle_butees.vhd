library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity controle_butees is
  port (
    sens, pwm : in std_logic;
    butees_d, butees_g : in std_logic_vector(11 downto 0);
    angle_barre : in std_logic_vector(11 downto 0);
    fin_course_d, fin_course_g : out std_logic;
    out_pwm : out std_logic
  ) ;
end controle_butees;

architecture rtl of controle_butees is

    begin 

    -- Mise à zéro du PWM : 

    out_pwm <= '0' when (angle_barre >= butees_g and sens = '0') or (angle_barre >= butees_d and sens = '1') else pwm;
    
    -- Génération des signaux "fin_course_d" & "fin_course_g" : 

    fin_course_g <= '1' when angle_barre >= butees_g and sens = '0' else '0';
    fin_course_d <= '1' when angle_barre >= butees_d and sens = '1' else '0';


end architecture rtl;