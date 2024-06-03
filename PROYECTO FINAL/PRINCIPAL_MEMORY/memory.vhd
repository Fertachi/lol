library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
    port (
        address : in std_logic_vector(7 downto 0);
        data_in : in std_logic_vector(7 downto 0);
        writen : in std_logic;
        clk : in std_logic;
        reset : in std_logic;
        port_out_00 : out std_logic_vector(7 downto 0);
        port_out_01 : out std_logic_vector(7 downto 0);
        port_in_00 : in std_logic_vector(7 downto 0);
        port_in_01 : in std_logic_vector(7 downto 0);
        data_out : out std_logic_vector(7 downto 0)
    );
end memory;

architecture memory_arq of memory is

    signal rom_data_out : std_logic_vector(7 downto 0);
    signal rw_data_out : std_logic_vector(7 downto 0);

    component rom_128x8_sync is
        port (
            address : in std_logic_vector(7 downto 0);
            clk : in std_logic;
            data_out : out std_logic_vector(7 downto 0)
        );
    end component;

    component rw_96x8_sync is
        port (
            address : in std_logic_vector(7 downto 0);
            data_in : in std_logic_vector(7 downto 0);
            writen : in std_logic;
            clk : in std_logic;
            data_out : out std_logic_vector(7 downto 0)
        );
    end component;

    component output_ports is
        port (
            address : in std_logic_vector(7 downto 0);
            data_in : in std_logic_vector(7 downto 0);
            writen : in std_logic;
            clk : in std_logic;
            reset : in std_logic;
            port_out_00 : out std_logic_vector(7 downto 0);
            port_out_01 : out std_logic_vector(7 downto 0)
        );
    end component;

    component multiplex is
        port (
            port_in_00 : in std_logic_vector(7 downto 0);
            port_in_01 : in std_logic_vector(7 downto 0);
            address : in std_logic_vector(7 downto 0);
            rom_data_out : in std_logic_vector(7 downto 0);
            rw_data_out : in std_logic_vector(7 downto 0);
            data_out : out std_logic_vector(7 downto 0)
        );
    end component;

begin

    U1: rom_128x8_sync
        port map (
            address => address,
            clk => clk,
            data_out => rom_data_out
        );

    U2: rw_96x8_sync
        port map (
            address => address,
            data_in => data_in,
            writen => writen,
            clk => clk,
            data_out => rw_data_out
        );

    U3: output_ports
        port map (
            address => address,
            data_in => data_in,
            writen => writen,
            clk => clk,
            reset => reset,
            port_out_00 => port_out_00,
            port_out_01 => port_out_01
        );

    U4: multiplex
        port map (
            port_in_00 => port_in_00,
            port_in_01 => port_in_01,
            address => address,
            rom_data_out => rom_data_out,
            rw_data_out => rw_data_out,
            data_out => data_out
        );

end memory_arq;
