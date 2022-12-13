library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_pwm is
end entity tb_pwm;

architecture rtl of tb_pwm is

    constant clk_cst : time := 10 ns;
    signal arst, clk : std_logic := '0';
    constant freq : std_logic_vector(7 downto 0) := "10010000";
    constant duty : std_logic_vector(7 downto 0) := "10110110";
    signal en_pwm : std_logic;


begin
   
    PWM_inst : entity work.PWM
    port map (
      arst_i => arst,
      clk_i => clk,
      freq_i => freq,
      duty_i => duty,
      en_pwm_i => en_pwm,
      pwm_out => open
    );
  
    arst <= '1' after 63 ns;
    clk <= not clk after clk_cst / 2;
    
    
    
end architecture rtl;