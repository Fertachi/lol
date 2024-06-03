library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rw_96x8_sync is
    port ( 
        address : in std_logic_vector(7 downto 0);
        data_in : in std_logic_vector(7 downto 0);
        writen : in std_logic;
        clk : in std_logic;
        data_out : out std_logic_vector(7 downto 0)
    );
end rw_96x8_sync;

architecture rw_arq of rw_96x8_sync is 

type rw_type is array (128 to 223) of std_logic_vector(7 downto 0);
signal RW : rw_type;
signal EN : std_logic;

begin

enable : process (address)
begin
    if (to_integer(unsigned(address)) >= 128 and to_integer(unsigned(address)) <= 223) then
        EN <= '1';
    else
        EN <= '0';
    end if;
end process;

memory : process (clk)
begin
    if rising_edge(clk) then
        if EN = '1' then
            if writen = '1' then
                RW(to_integer(unsigned(address))) <= data_in;
            else
                data_out <= RW(to_integer(unsigned(address)));
            end if;
        end if;
    end if;
end process;

end rw_arq;
