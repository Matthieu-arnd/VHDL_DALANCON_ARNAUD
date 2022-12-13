library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_controle_butees is
end entity tb_controle_butees;

architecture rtl of tb_controle_butees is

    constant clk_cst : time := 10 ns;
    signal sens_i, pwm_i : std_logic := '0';
    constant butees_d_i : std_logic_vector(11 downto 0) := "010101111000"; -- 1400
    constant butees_g_i : std_logic_vector(11 downto 0) := "011111001101"; -- 1567
    constant angle_barre_i : std_logic_vector(11 downto 0) := "011000011000"; -- 1567

begin
   
    controle_butees_inst : entity work.controle_butees
    port map (
        pwm => pwm_i,
        sens => sens_i,
        butees_d => butees_d_i,
        butees_g => butees_g_i,
        angle_barre => angle_barre_i,
        fin_course_d => open,
        fin_course_g => open,
        out_pwm => open
  );

  sens_i <= '1' after 100 ns;
  pwm_i <= not pwm_i after clk_cst / 2;
  


    
    
end architecture rtl;