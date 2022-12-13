library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_gene_impul is
end entity tb_gene_impul;

architecture rtl of tb_gene_impul is

    constant clk_cst : time := 0.02 ns;
    signal arst, clk : std_logic := '1';


begin
  
  

    gene_impul_inst : entity work.gene_impul
  generic map (
    B => 50,
    N => 26 
  )
  port map (
    clk_i => clk,
    arst_i => arst,
    q_o => open
  );

  arst <= '0' after 100 ns ;
  clk <= not clk after clk_cst / 2;
    
    
end architecture rtl;