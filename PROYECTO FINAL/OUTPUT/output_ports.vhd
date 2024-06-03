library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity output_ports is
    port ( 
        address : in std_logic_vector(7 downto 0);
        data_in : in std_logic_vector(7 downto 0);
        writen : in std_logic;
        clk : in std_logic;
        reset : in std_logic;
        port_out_00 : out std_logic_vector(7 downto 0);
        port_out_01 : out std_logic_vector(7 downto 0)
    );
end output_ports;

architecture out_ports_arq of output_ports is
begin

-- port_out_00 description : ADDRESS x"E0"
U3 : process (clk, reset)
begin
    if reset = '0' then
        port_out_00 <= (others => '0');
    elsif rising_edge(clk) then
        if (address = x"E0" and writen = '1') then
            port_out_00 <= data_in;
        end if;
    end if;
end process;

-- port_out_01 description : ADDRESS x"E1"
U4 : process (clk, reset)
begin
    if reset = '0' then
        port_out_01 <= (others => '0');
    elsif rising_edge(clk) then
        if (address = x"E1" and writen = '1') then
            port_out_01 <= data_in;
        end if;
    end if;
end process;

-- “the rest of the output port models go here...”

end out_ports_arq;
