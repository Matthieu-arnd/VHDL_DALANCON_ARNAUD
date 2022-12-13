library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity gene_impul is

    generic (
        B : integer := 50e6;
        N : integer := 26
    );
    port (
        clk_i   : in std_logic;
        arst_i : in std_logic;
        q_o : out std_logic
    );
end entity;

architecture rtl of gene_impul is

signal A : std_logic_vector(N-1 downto 0);
signal q : std_logic;
begin

    counter_inst : entity work.counter
    generic map (
      N => A'length
    )
    port map (
      arst_i => arst_i,
      clk_i => clk_i,
      srst_i => q,
      en_i => '1',
      q_o => A
    );
  
    q <= '1' when unsigned (A) >= B else '0';
    q_o <= q;
    

end architecture;