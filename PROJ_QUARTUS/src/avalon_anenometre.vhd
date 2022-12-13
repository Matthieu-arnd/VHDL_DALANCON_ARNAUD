library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity avalon_anenometre is
    port (
        arst_i : in std_logic;
        clk_i : in std_logic;
        vent_i : in std_logic;
        address_i : in std_logic_vector(1 downto 0);
        write_data_i : in std_logic_vector(31 downto 0);
        write_i : in std_logic;
        --byte_enable_i : in std_logic_vector(3 downto 0);
        --read_i : in std_logic;
        read_data_o : out std_logic_vector(31 downto 0)
    );
end entity avalon_anenometre;

architecture rtl of avalon_anenometre is
    signal data_valid : std_logic;
    signal continu, start_stop : std_logic;
    signal freq_vent : std_logic_vector(7 downto 0);
    --signal write_data_i : std_logic_vector(31 downto 0);
    signal reg, reg_byte_enable : std_logic_vector(2 downto 0);
    signal read_count : unsigned(31 downto 0);
    signal d_read : std_logic;
    signal raz : std_logic;
begin

    -- Instance de l'anénometre :
    anenometre_inst : entity work.anenometre
    generic map (
        nb_bits => 8
    )
    port map (
        arst => raz,
        clk => clk_i,
        vent => vent_i,
        freq_vent => freq_vent,
        continu => continu,
        start_stop => start_stop,
        data_valid => data_valid
    );

    
    process (clk_i, arst_i)
    begin
        if arst_i = '1' then
            raz <= '1';
            continu <= '0';
            start_stop <= '0';
        elsif rising_edge(clk_i) then
            if write_i = '1' then
                case to_integer(unsigned(address_i)) is
                    when 0 =>
                        raz <= write_data_i(0);
                        continu <= write_data_i(1);
                        start_stop <= write_data_i(2);
                    when 1 =>
                        -- Ecriture masqué
                        --reg(10 downto 3) <= write_data_i(7 downto 0);
                    when others =>
                end case;
            end if;
        end if;
    end process;

    read_data_o <= x"0000000" & '0' & continu & start_stop & raz when address_i = "00" else
    x"00000" & "000" & data_valid & freq_vent;
 
end architecture rtl;