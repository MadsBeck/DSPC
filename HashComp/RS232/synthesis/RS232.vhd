-- Rs232.vhd

-- Generated using ACDS version 17.1 590

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Rs232 is
	port (
		address    : in  std_logic                     := '0';             -- avalon_rs232_slave.address
		chipselect : in  std_logic                     := '0';             --                   .chipselect
		byteenable : in  std_logic_vector(3 downto 0)  := (others => '0'); --                   .byteenable
		read       : in  std_logic                     := '0';             --                   .read
		write      : in  std_logic                     := '0';             --                   .write
		writedata  : in  std_logic_vector(31 downto 0) := (others => '0'); --                   .writedata
		readdata   : out std_logic_vector(31 downto 0);                    --                   .readdata
		clk        : in  std_logic                     := '0';             --                clk.clk
		UART_RXD   : in  std_logic                     := '0';             -- external_interface.RXD
		UART_TXD   : out std_logic;                                        --                   .TXD
		irq        : out std_logic;                                        --          interrupt.irq
		reset      : in  std_logic                     := '0'              --              reset.reset
	);
end entity Rs232;

architecture rtl of Rs232 is
	component Rs232_rs232_0 is
		port (
			clk        : in  std_logic                     := 'X';             -- clk
			reset      : in  std_logic                     := 'X';             -- reset
			address    : in  std_logic                     := 'X';             -- address
			chipselect : in  std_logic                     := 'X';             -- chipselect
			byteenable : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- byteenable
			read       : in  std_logic                     := 'X';             -- read
			write      : in  std_logic                     := 'X';             -- write
			writedata  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			readdata   : out std_logic_vector(31 downto 0);                    -- readdata
			irq        : out std_logic;                                        -- irq
			UART_RXD   : in  std_logic                     := 'X';             -- export
			UART_TXD   : out std_logic                                         -- export
		);
	end component Rs232_rs232_0;

begin

	rs232_0 : component Rs232_rs232_0
		port map (
			clk        => clk,        --                clk.clk
			reset      => reset,      --              reset.reset
			address    => address,    -- avalon_rs232_slave.address
			chipselect => chipselect, --                   .chipselect
			byteenable => byteenable, --                   .byteenable
			read       => read,       --                   .read
			write      => write,      --                   .write
			writedata  => writedata,  --                   .writedata
			readdata   => readdata,   --                   .readdata
			irq        => irq,        --          interrupt.irq
			UART_RXD   => UART_RXD,   -- external_interface.export
			UART_TXD   => UART_TXD    --                   .export
		);

end architecture rtl; -- of Rs232
