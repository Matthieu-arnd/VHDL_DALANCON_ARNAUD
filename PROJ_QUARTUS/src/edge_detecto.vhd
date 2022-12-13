library IEEE; 
use IEEE.std_logic_1164.all; 
entity edge_detector is
    generic (
        C_ASYNC : boolean := false
    );
  port (
    clk_i : in std_logic;
    d_i : in std_logic;
    re_o : out std_logic;
    fe_o : out std_logic
  ) ;
end entity edge_detector;

architecture rtl of edge_detector is

    signal q0, q1 : std_logic;

begin
    gen_sync: if C_ASYNC = FALSE generate
        q0 <= d_i;
    end generate gen_sync;
    gen_async: if C_ASYNC = TRUE generate
        process (clk_i)
        begin
            if rising_edge(clk_i) then
                q0 <= d_i;
            end if;
        end process;
    end generate gen_async;
    process (clk_i)
    begin
        if rising_edge(clk_i) then
            q1 <= q0;
        end if;
    end process;
    re_o <= '1' when q1 = '0' and q0 = '1' else '0';
    fe_o <= '1' when q1 = '1' and q0 = '0' else '0';

end architecture rtl ; -- rtl