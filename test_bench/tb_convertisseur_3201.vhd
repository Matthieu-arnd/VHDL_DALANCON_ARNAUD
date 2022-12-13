library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_convertisseur_3201 is
end entity tb_convertisseur_3201;

architecture rtl of tb_convertisseur_3201 is

    constant clk_cst : time := 0.02 ns;
    signal sig_data_in : std_logic_vector(11 downto 0) := "000100000000"; 
    signal sig_clk : std_logic := '0'; 
    signal sig_arst : std_logic;


begin

    sig_arst <= '0' after 63 ns ;
    sig_clk <= not sig_clk after clk_cst / 2;
    
    convertisseur_3201_inst : entity work.convertisseur_3201
    port map (
        clk => sig_clk,
        arst => sig_arst,
        data_in => sig_data_in,
        cs_n => open    ,
        clk_adc => open,
        angle_barre => open
  );    

  
    
end architecture rtl;