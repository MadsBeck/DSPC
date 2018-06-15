-- System.vhd

-- Generated using ACDS version 17.1 590

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity System is
	port (
		clk_clk : in std_logic := '0'  -- clk.clk
	);
end entity System;

architecture rtl of System is
	component System_jtag_uart_0 is
		port (
			clk            : in  std_logic                     := 'X';             -- clk
			rst_n          : in  std_logic                     := 'X';             -- reset_n
			av_chipselect  : in  std_logic                     := 'X';             -- chipselect
			av_address     : in  std_logic                     := 'X';             -- address
			av_read_n      : in  std_logic                     := 'X';             -- read_n
			av_readdata    : out std_logic_vector(31 downto 0);                    -- readdata
			av_write_n     : in  std_logic                     := 'X';             -- write_n
			av_writedata   : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			av_waitrequest : out std_logic;                                        -- waitrequest
			av_irq         : out std_logic                                         -- irq
		);
	end component System_jtag_uart_0;

	component System_nios2_gen2_0 is
		port (
			clk                                 : in  std_logic                     := 'X';             -- clk
			reset_n                             : in  std_logic                     := 'X';             -- reset_n
			reset_req                           : in  std_logic                     := 'X';             -- reset_req
			d_address                           : out std_logic_vector(16 downto 0);                    -- address
			d_byteenable                        : out std_logic_vector(3 downto 0);                     -- byteenable
			d_read                              : out std_logic;                                        -- read
			d_readdata                          : in  std_logic_vector(31 downto 0) := (others => 'X'); -- readdata
			d_waitrequest                       : in  std_logic                     := 'X';             -- waitrequest
			d_write                             : out std_logic;                                        -- write
			d_writedata                         : out std_logic_vector(31 downto 0);                    -- writedata
			debug_mem_slave_debugaccess_to_roms : out std_logic;                                        -- debugaccess
			i_address                           : out std_logic_vector(16 downto 0);                    -- address
			i_read                              : out std_logic;                                        -- read
			i_readdata                          : in  std_logic_vector(31 downto 0) := (others => 'X'); -- readdata
			i_waitrequest                       : in  std_logic                     := 'X';             -- waitrequest
			irq                                 : in  std_logic_vector(31 downto 0) := (others => 'X'); -- irq
			debug_reset_request                 : out std_logic;                                        -- reset
			debug_mem_slave_address             : in  std_logic_vector(8 downto 0)  := (others => 'X'); -- address
			debug_mem_slave_byteenable          : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- byteenable
			debug_mem_slave_debugaccess         : in  std_logic                     := 'X';             -- debugaccess
			debug_mem_slave_read                : in  std_logic                     := 'X';             -- read
			debug_mem_slave_readdata            : out std_logic_vector(31 downto 0);                    -- readdata
			debug_mem_slave_waitrequest         : out std_logic;                                        -- waitrequest
			debug_mem_slave_write               : in  std_logic                     := 'X';             -- write
			debug_mem_slave_writedata           : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			dummy_ci_port                       : out std_logic                                         -- readra
		);
	end component System_nios2_gen2_0;

	component System_onchip_memory2_0 is
		port (
			clk        : in  std_logic                     := 'X';             -- clk
			address    : in  std_logic_vector(12 downto 0) := (others => 'X'); -- address
			clken      : in  std_logic                     := 'X';             -- clken
			chipselect : in  std_logic                     := 'X';             -- chipselect
			write      : in  std_logic                     := 'X';             -- write
			readdata   : out std_logic_vector(31 downto 0);                    -- readdata
			writedata  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			byteenable : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- byteenable
			reset      : in  std_logic                     := 'X';             -- reset
			reset_req  : in  std_logic                     := 'X';             -- reset_req
			freeze     : in  std_logic                     := 'X'              -- freeze
		);
	end component System_onchip_memory2_0;

	component System_mm_interconnect_0 is
		port (
			clk_0_clk_clk                                  : in  std_logic                     := 'X';             -- clk
			nios2_gen2_0_reset_reset_bridge_in_reset_reset : in  std_logic                     := 'X';             -- reset
			nios2_gen2_0_data_master_address               : in  std_logic_vector(16 downto 0) := (others => 'X'); -- address
			nios2_gen2_0_data_master_waitrequest           : out std_logic;                                        -- waitrequest
			nios2_gen2_0_data_master_byteenable            : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- byteenable
			nios2_gen2_0_data_master_read                  : in  std_logic                     := 'X';             -- read
			nios2_gen2_0_data_master_readdata              : out std_logic_vector(31 downto 0);                    -- readdata
			nios2_gen2_0_data_master_write                 : in  std_logic                     := 'X';             -- write
			nios2_gen2_0_data_master_writedata             : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			nios2_gen2_0_data_master_debugaccess           : in  std_logic                     := 'X';             -- debugaccess
			nios2_gen2_0_instruction_master_address        : in  std_logic_vector(16 downto 0) := (others => 'X'); -- address
			nios2_gen2_0_instruction_master_waitrequest    : out std_logic;                                        -- waitrequest
			nios2_gen2_0_instruction_master_read           : in  std_logic                     := 'X';             -- read
			nios2_gen2_0_instruction_master_readdata       : out std_logic_vector(31 downto 0);                    -- readdata
			jtag_uart_0_avalon_jtag_slave_address          : out std_logic_vector(0 downto 0);                     -- address
			jtag_uart_0_avalon_jtag_slave_write            : out std_logic;                                        -- write
			jtag_uart_0_avalon_jtag_slave_read             : out std_logic;                                        -- read
			jtag_uart_0_avalon_jtag_slave_readdata         : in  std_logic_vector(31 downto 0) := (others => 'X'); -- readdata
			jtag_uart_0_avalon_jtag_slave_writedata        : out std_logic_vector(31 downto 0);                    -- writedata
			jtag_uart_0_avalon_jtag_slave_waitrequest      : in  std_logic                     := 'X';             -- waitrequest
			jtag_uart_0_avalon_jtag_slave_chipselect       : out std_logic;                                        -- chipselect
			nios2_gen2_0_debug_mem_slave_address           : out std_logic_vector(8 downto 0);                     -- address
			nios2_gen2_0_debug_mem_slave_write             : out std_logic;                                        -- write
			nios2_gen2_0_debug_mem_slave_read              : out std_logic;                                        -- read
			nios2_gen2_0_debug_mem_slave_readdata          : in  std_logic_vector(31 downto 0) := (others => 'X'); -- readdata
			nios2_gen2_0_debug_mem_slave_writedata         : out std_logic_vector(31 downto 0);                    -- writedata
			nios2_gen2_0_debug_mem_slave_byteenable        : out std_logic_vector(3 downto 0);                     -- byteenable
			nios2_gen2_0_debug_mem_slave_waitrequest       : in  std_logic                     := 'X';             -- waitrequest
			nios2_gen2_0_debug_mem_slave_debugaccess       : out std_logic;                                        -- debugaccess
			onchip_memory2_0_s1_address                    : out std_logic_vector(12 downto 0);                    -- address
			onchip_memory2_0_s1_write                      : out std_logic;                                        -- write
			onchip_memory2_0_s1_readdata                   : in  std_logic_vector(31 downto 0) := (others => 'X'); -- readdata
			onchip_memory2_0_s1_writedata                  : out std_logic_vector(31 downto 0);                    -- writedata
			onchip_memory2_0_s1_byteenable                 : out std_logic_vector(3 downto 0);                     -- byteenable
			onchip_memory2_0_s1_chipselect                 : out std_logic;                                        -- chipselect
			onchip_memory2_0_s1_clken                      : out std_logic                                         -- clken
		);
	end component System_mm_interconnect_0;

	component System_irq_mapper is
		port (
			clk           : in  std_logic                     := 'X'; -- clk
			reset         : in  std_logic                     := 'X'; -- reset
			receiver0_irq : in  std_logic                     := 'X'; -- irq
			sender_irq    : out std_logic_vector(31 downto 0)         -- irq
		);
	end component System_irq_mapper;

	component altera_reset_controller is
		generic (
			NUM_RESET_INPUTS          : integer := 6;
			OUTPUT_RESET_SYNC_EDGES   : string  := "deassert";
			SYNC_DEPTH                : integer := 2;
			RESET_REQUEST_PRESENT     : integer := 0;
			RESET_REQ_WAIT_TIME       : integer := 1;
			MIN_RST_ASSERTION_TIME    : integer := 3;
			RESET_REQ_EARLY_DSRT_TIME : integer := 1;
			USE_RESET_REQUEST_IN0     : integer := 0;
			USE_RESET_REQUEST_IN1     : integer := 0;
			USE_RESET_REQUEST_IN2     : integer := 0;
			USE_RESET_REQUEST_IN3     : integer := 0;
			USE_RESET_REQUEST_IN4     : integer := 0;
			USE_RESET_REQUEST_IN5     : integer := 0;
			USE_RESET_REQUEST_IN6     : integer := 0;
			USE_RESET_REQUEST_IN7     : integer := 0;
			USE_RESET_REQUEST_IN8     : integer := 0;
			USE_RESET_REQUEST_IN9     : integer := 0;
			USE_RESET_REQUEST_IN10    : integer := 0;
			USE_RESET_REQUEST_IN11    : integer := 0;
			USE_RESET_REQUEST_IN12    : integer := 0;
			USE_RESET_REQUEST_IN13    : integer := 0;
			USE_RESET_REQUEST_IN14    : integer := 0;
			USE_RESET_REQUEST_IN15    : integer := 0;
			ADAPT_RESET_REQUEST       : integer := 0
		);
		port (
			reset_in0      : in  std_logic := 'X'; -- reset
			reset_in1      : in  std_logic := 'X'; -- reset
			clk            : in  std_logic := 'X'; -- clk
			reset_out      : out std_logic;        -- reset
			reset_req      : out std_logic;        -- reset_req
			reset_req_in0  : in  std_logic := 'X'; -- reset_req
			reset_req_in1  : in  std_logic := 'X'; -- reset_req
			reset_in2      : in  std_logic := 'X'; -- reset
			reset_req_in2  : in  std_logic := 'X'; -- reset_req
			reset_in3      : in  std_logic := 'X'; -- reset
			reset_req_in3  : in  std_logic := 'X'; -- reset_req
			reset_in4      : in  std_logic := 'X'; -- reset
			reset_req_in4  : in  std_logic := 'X'; -- reset_req
			reset_in5      : in  std_logic := 'X'; -- reset
			reset_req_in5  : in  std_logic := 'X'; -- reset_req
			reset_in6      : in  std_logic := 'X'; -- reset
			reset_req_in6  : in  std_logic := 'X'; -- reset_req
			reset_in7      : in  std_logic := 'X'; -- reset
			reset_req_in7  : in  std_logic := 'X'; -- reset_req
			reset_in8      : in  std_logic := 'X'; -- reset
			reset_req_in8  : in  std_logic := 'X'; -- reset_req
			reset_in9      : in  std_logic := 'X'; -- reset
			reset_req_in9  : in  std_logic := 'X'; -- reset_req
			reset_in10     : in  std_logic := 'X'; -- reset
			reset_req_in10 : in  std_logic := 'X'; -- reset_req
			reset_in11     : in  std_logic := 'X'; -- reset
			reset_req_in11 : in  std_logic := 'X'; -- reset_req
			reset_in12     : in  std_logic := 'X'; -- reset
			reset_req_in12 : in  std_logic := 'X'; -- reset_req
			reset_in13     : in  std_logic := 'X'; -- reset
			reset_req_in13 : in  std_logic := 'X'; -- reset_req
			reset_in14     : in  std_logic := 'X'; -- reset
			reset_req_in14 : in  std_logic := 'X'; -- reset_req
			reset_in15     : in  std_logic := 'X'; -- reset
			reset_req_in15 : in  std_logic := 'X'  -- reset_req
		);
	end component altera_reset_controller;

	signal nios2_gen2_0_debug_reset_request_reset                          : std_logic;                     -- nios2_gen2_0:debug_reset_request -> [rst_controller:reset_in0, rst_controller:reset_in1]
	signal nios2_gen2_0_data_master_readdata                               : std_logic_vector(31 downto 0); -- mm_interconnect_0:nios2_gen2_0_data_master_readdata -> nios2_gen2_0:d_readdata
	signal nios2_gen2_0_data_master_waitrequest                            : std_logic;                     -- mm_interconnect_0:nios2_gen2_0_data_master_waitrequest -> nios2_gen2_0:d_waitrequest
	signal nios2_gen2_0_data_master_debugaccess                            : std_logic;                     -- nios2_gen2_0:debug_mem_slave_debugaccess_to_roms -> mm_interconnect_0:nios2_gen2_0_data_master_debugaccess
	signal nios2_gen2_0_data_master_address                                : std_logic_vector(16 downto 0); -- nios2_gen2_0:d_address -> mm_interconnect_0:nios2_gen2_0_data_master_address
	signal nios2_gen2_0_data_master_byteenable                             : std_logic_vector(3 downto 0);  -- nios2_gen2_0:d_byteenable -> mm_interconnect_0:nios2_gen2_0_data_master_byteenable
	signal nios2_gen2_0_data_master_read                                   : std_logic;                     -- nios2_gen2_0:d_read -> mm_interconnect_0:nios2_gen2_0_data_master_read
	signal nios2_gen2_0_data_master_write                                  : std_logic;                     -- nios2_gen2_0:d_write -> mm_interconnect_0:nios2_gen2_0_data_master_write
	signal nios2_gen2_0_data_master_writedata                              : std_logic_vector(31 downto 0); -- nios2_gen2_0:d_writedata -> mm_interconnect_0:nios2_gen2_0_data_master_writedata
	signal nios2_gen2_0_instruction_master_readdata                        : std_logic_vector(31 downto 0); -- mm_interconnect_0:nios2_gen2_0_instruction_master_readdata -> nios2_gen2_0:i_readdata
	signal nios2_gen2_0_instruction_master_waitrequest                     : std_logic;                     -- mm_interconnect_0:nios2_gen2_0_instruction_master_waitrequest -> nios2_gen2_0:i_waitrequest
	signal nios2_gen2_0_instruction_master_address                         : std_logic_vector(16 downto 0); -- nios2_gen2_0:i_address -> mm_interconnect_0:nios2_gen2_0_instruction_master_address
	signal nios2_gen2_0_instruction_master_read                            : std_logic;                     -- nios2_gen2_0:i_read -> mm_interconnect_0:nios2_gen2_0_instruction_master_read
	signal mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_chipselect      : std_logic;                     -- mm_interconnect_0:jtag_uart_0_avalon_jtag_slave_chipselect -> jtag_uart_0:av_chipselect
	signal mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_readdata        : std_logic_vector(31 downto 0); -- jtag_uart_0:av_readdata -> mm_interconnect_0:jtag_uart_0_avalon_jtag_slave_readdata
	signal mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_waitrequest     : std_logic;                     -- jtag_uart_0:av_waitrequest -> mm_interconnect_0:jtag_uart_0_avalon_jtag_slave_waitrequest
	signal mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_address         : std_logic_vector(0 downto 0);  -- mm_interconnect_0:jtag_uart_0_avalon_jtag_slave_address -> jtag_uart_0:av_address
	signal mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_read            : std_logic;                     -- mm_interconnect_0:jtag_uart_0_avalon_jtag_slave_read -> mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_read:in
	signal mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_write           : std_logic;                     -- mm_interconnect_0:jtag_uart_0_avalon_jtag_slave_write -> mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_write:in
	signal mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_writedata       : std_logic_vector(31 downto 0); -- mm_interconnect_0:jtag_uart_0_avalon_jtag_slave_writedata -> jtag_uart_0:av_writedata
	signal mm_interconnect_0_nios2_gen2_0_debug_mem_slave_readdata         : std_logic_vector(31 downto 0); -- nios2_gen2_0:debug_mem_slave_readdata -> mm_interconnect_0:nios2_gen2_0_debug_mem_slave_readdata
	signal mm_interconnect_0_nios2_gen2_0_debug_mem_slave_waitrequest      : std_logic;                     -- nios2_gen2_0:debug_mem_slave_waitrequest -> mm_interconnect_0:nios2_gen2_0_debug_mem_slave_waitrequest
	signal mm_interconnect_0_nios2_gen2_0_debug_mem_slave_debugaccess      : std_logic;                     -- mm_interconnect_0:nios2_gen2_0_debug_mem_slave_debugaccess -> nios2_gen2_0:debug_mem_slave_debugaccess
	signal mm_interconnect_0_nios2_gen2_0_debug_mem_slave_address          : std_logic_vector(8 downto 0);  -- mm_interconnect_0:nios2_gen2_0_debug_mem_slave_address -> nios2_gen2_0:debug_mem_slave_address
	signal mm_interconnect_0_nios2_gen2_0_debug_mem_slave_read             : std_logic;                     -- mm_interconnect_0:nios2_gen2_0_debug_mem_slave_read -> nios2_gen2_0:debug_mem_slave_read
	signal mm_interconnect_0_nios2_gen2_0_debug_mem_slave_byteenable       : std_logic_vector(3 downto 0);  -- mm_interconnect_0:nios2_gen2_0_debug_mem_slave_byteenable -> nios2_gen2_0:debug_mem_slave_byteenable
	signal mm_interconnect_0_nios2_gen2_0_debug_mem_slave_write            : std_logic;                     -- mm_interconnect_0:nios2_gen2_0_debug_mem_slave_write -> nios2_gen2_0:debug_mem_slave_write
	signal mm_interconnect_0_nios2_gen2_0_debug_mem_slave_writedata        : std_logic_vector(31 downto 0); -- mm_interconnect_0:nios2_gen2_0_debug_mem_slave_writedata -> nios2_gen2_0:debug_mem_slave_writedata
	signal mm_interconnect_0_onchip_memory2_0_s1_chipselect                : std_logic;                     -- mm_interconnect_0:onchip_memory2_0_s1_chipselect -> onchip_memory2_0:chipselect
	signal mm_interconnect_0_onchip_memory2_0_s1_readdata                  : std_logic_vector(31 downto 0); -- onchip_memory2_0:readdata -> mm_interconnect_0:onchip_memory2_0_s1_readdata
	signal mm_interconnect_0_onchip_memory2_0_s1_address                   : std_logic_vector(12 downto 0); -- mm_interconnect_0:onchip_memory2_0_s1_address -> onchip_memory2_0:address
	signal mm_interconnect_0_onchip_memory2_0_s1_byteenable                : std_logic_vector(3 downto 0);  -- mm_interconnect_0:onchip_memory2_0_s1_byteenable -> onchip_memory2_0:byteenable
	signal mm_interconnect_0_onchip_memory2_0_s1_write                     : std_logic;                     -- mm_interconnect_0:onchip_memory2_0_s1_write -> onchip_memory2_0:write
	signal mm_interconnect_0_onchip_memory2_0_s1_writedata                 : std_logic_vector(31 downto 0); -- mm_interconnect_0:onchip_memory2_0_s1_writedata -> onchip_memory2_0:writedata
	signal mm_interconnect_0_onchip_memory2_0_s1_clken                     : std_logic;                     -- mm_interconnect_0:onchip_memory2_0_s1_clken -> onchip_memory2_0:clken
	signal irq_mapper_receiver0_irq                                        : std_logic;                     -- jtag_uart_0:av_irq -> irq_mapper:receiver0_irq
	signal nios2_gen2_0_irq_irq                                            : std_logic_vector(31 downto 0); -- irq_mapper:sender_irq -> nios2_gen2_0:irq
	signal rst_controller_reset_out_reset                                  : std_logic;                     -- rst_controller:reset_out -> [irq_mapper:reset, mm_interconnect_0:nios2_gen2_0_reset_reset_bridge_in_reset_reset, onchip_memory2_0:reset, rst_controller_reset_out_reset:in, rst_translator:in_reset]
	signal rst_controller_reset_out_reset_req                              : std_logic;                     -- rst_controller:reset_req -> [nios2_gen2_0:reset_req, onchip_memory2_0:reset_req, rst_translator:reset_req_in]
	signal mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_read_ports_inv  : std_logic;                     -- mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_read:inv -> jtag_uart_0:av_read_n
	signal mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_write_ports_inv : std_logic;                     -- mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_write:inv -> jtag_uart_0:av_write_n
	signal rst_controller_reset_out_reset_ports_inv                        : std_logic;                     -- rst_controller_reset_out_reset:inv -> [jtag_uart_0:rst_n, nios2_gen2_0:reset_n]

begin

	jtag_uart_0 : component System_jtag_uart_0
		port map (
			clk            => clk_clk,                                                         --               clk.clk
			rst_n          => rst_controller_reset_out_reset_ports_inv,                        --             reset.reset_n
			av_chipselect  => mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_chipselect,      -- avalon_jtag_slave.chipselect
			av_address     => mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_address(0),      --                  .address
			av_read_n      => mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_read_ports_inv,  --                  .read_n
			av_readdata    => mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_readdata,        --                  .readdata
			av_write_n     => mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_write_ports_inv, --                  .write_n
			av_writedata   => mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_writedata,       --                  .writedata
			av_waitrequest => mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_waitrequest,     --                  .waitrequest
			av_irq         => irq_mapper_receiver0_irq                                         --               irq.irq
		);

	nios2_gen2_0 : component System_nios2_gen2_0
		port map (
			clk                                 => clk_clk,                                                    --                       clk.clk
			reset_n                             => rst_controller_reset_out_reset_ports_inv,                   --                     reset.reset_n
			reset_req                           => rst_controller_reset_out_reset_req,                         --                          .reset_req
			d_address                           => nios2_gen2_0_data_master_address,                           --               data_master.address
			d_byteenable                        => nios2_gen2_0_data_master_byteenable,                        --                          .byteenable
			d_read                              => nios2_gen2_0_data_master_read,                              --                          .read
			d_readdata                          => nios2_gen2_0_data_master_readdata,                          --                          .readdata
			d_waitrequest                       => nios2_gen2_0_data_master_waitrequest,                       --                          .waitrequest
			d_write                             => nios2_gen2_0_data_master_write,                             --                          .write
			d_writedata                         => nios2_gen2_0_data_master_writedata,                         --                          .writedata
			debug_mem_slave_debugaccess_to_roms => nios2_gen2_0_data_master_debugaccess,                       --                          .debugaccess
			i_address                           => nios2_gen2_0_instruction_master_address,                    --        instruction_master.address
			i_read                              => nios2_gen2_0_instruction_master_read,                       --                          .read
			i_readdata                          => nios2_gen2_0_instruction_master_readdata,                   --                          .readdata
			i_waitrequest                       => nios2_gen2_0_instruction_master_waitrequest,                --                          .waitrequest
			irq                                 => nios2_gen2_0_irq_irq,                                       --                       irq.irq
			debug_reset_request                 => nios2_gen2_0_debug_reset_request_reset,                     --       debug_reset_request.reset
			debug_mem_slave_address             => mm_interconnect_0_nios2_gen2_0_debug_mem_slave_address,     --           debug_mem_slave.address
			debug_mem_slave_byteenable          => mm_interconnect_0_nios2_gen2_0_debug_mem_slave_byteenable,  --                          .byteenable
			debug_mem_slave_debugaccess         => mm_interconnect_0_nios2_gen2_0_debug_mem_slave_debugaccess, --                          .debugaccess
			debug_mem_slave_read                => mm_interconnect_0_nios2_gen2_0_debug_mem_slave_read,        --                          .read
			debug_mem_slave_readdata            => mm_interconnect_0_nios2_gen2_0_debug_mem_slave_readdata,    --                          .readdata
			debug_mem_slave_waitrequest         => mm_interconnect_0_nios2_gen2_0_debug_mem_slave_waitrequest, --                          .waitrequest
			debug_mem_slave_write               => mm_interconnect_0_nios2_gen2_0_debug_mem_slave_write,       --                          .write
			debug_mem_slave_writedata           => mm_interconnect_0_nios2_gen2_0_debug_mem_slave_writedata,   --                          .writedata
			dummy_ci_port                       => open                                                        -- custom_instruction_master.readra
		);

	onchip_memory2_0 : component System_onchip_memory2_0
		port map (
			clk        => clk_clk,                                          --   clk1.clk
			address    => mm_interconnect_0_onchip_memory2_0_s1_address,    --     s1.address
			clken      => mm_interconnect_0_onchip_memory2_0_s1_clken,      --       .clken
			chipselect => mm_interconnect_0_onchip_memory2_0_s1_chipselect, --       .chipselect
			write      => mm_interconnect_0_onchip_memory2_0_s1_write,      --       .write
			readdata   => mm_interconnect_0_onchip_memory2_0_s1_readdata,   --       .readdata
			writedata  => mm_interconnect_0_onchip_memory2_0_s1_writedata,  --       .writedata
			byteenable => mm_interconnect_0_onchip_memory2_0_s1_byteenable, --       .byteenable
			reset      => rst_controller_reset_out_reset,                   -- reset1.reset
			reset_req  => rst_controller_reset_out_reset_req,               --       .reset_req
			freeze     => '0'                                               -- (terminated)
		);

	mm_interconnect_0 : component System_mm_interconnect_0
		port map (
			clk_0_clk_clk                                  => clk_clk,                                                     --                                clk_0_clk.clk
			nios2_gen2_0_reset_reset_bridge_in_reset_reset => rst_controller_reset_out_reset,                              -- nios2_gen2_0_reset_reset_bridge_in_reset.reset
			nios2_gen2_0_data_master_address               => nios2_gen2_0_data_master_address,                            --                 nios2_gen2_0_data_master.address
			nios2_gen2_0_data_master_waitrequest           => nios2_gen2_0_data_master_waitrequest,                        --                                         .waitrequest
			nios2_gen2_0_data_master_byteenable            => nios2_gen2_0_data_master_byteenable,                         --                                         .byteenable
			nios2_gen2_0_data_master_read                  => nios2_gen2_0_data_master_read,                               --                                         .read
			nios2_gen2_0_data_master_readdata              => nios2_gen2_0_data_master_readdata,                           --                                         .readdata
			nios2_gen2_0_data_master_write                 => nios2_gen2_0_data_master_write,                              --                                         .write
			nios2_gen2_0_data_master_writedata             => nios2_gen2_0_data_master_writedata,                          --                                         .writedata
			nios2_gen2_0_data_master_debugaccess           => nios2_gen2_0_data_master_debugaccess,                        --                                         .debugaccess
			nios2_gen2_0_instruction_master_address        => nios2_gen2_0_instruction_master_address,                     --          nios2_gen2_0_instruction_master.address
			nios2_gen2_0_instruction_master_waitrequest    => nios2_gen2_0_instruction_master_waitrequest,                 --                                         .waitrequest
			nios2_gen2_0_instruction_master_read           => nios2_gen2_0_instruction_master_read,                        --                                         .read
			nios2_gen2_0_instruction_master_readdata       => nios2_gen2_0_instruction_master_readdata,                    --                                         .readdata
			jtag_uart_0_avalon_jtag_slave_address          => mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_address,     --            jtag_uart_0_avalon_jtag_slave.address
			jtag_uart_0_avalon_jtag_slave_write            => mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_write,       --                                         .write
			jtag_uart_0_avalon_jtag_slave_read             => mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_read,        --                                         .read
			jtag_uart_0_avalon_jtag_slave_readdata         => mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_readdata,    --                                         .readdata
			jtag_uart_0_avalon_jtag_slave_writedata        => mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_writedata,   --                                         .writedata
			jtag_uart_0_avalon_jtag_slave_waitrequest      => mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_waitrequest, --                                         .waitrequest
			jtag_uart_0_avalon_jtag_slave_chipselect       => mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_chipselect,  --                                         .chipselect
			nios2_gen2_0_debug_mem_slave_address           => mm_interconnect_0_nios2_gen2_0_debug_mem_slave_address,      --             nios2_gen2_0_debug_mem_slave.address
			nios2_gen2_0_debug_mem_slave_write             => mm_interconnect_0_nios2_gen2_0_debug_mem_slave_write,        --                                         .write
			nios2_gen2_0_debug_mem_slave_read              => mm_interconnect_0_nios2_gen2_0_debug_mem_slave_read,         --                                         .read
			nios2_gen2_0_debug_mem_slave_readdata          => mm_interconnect_0_nios2_gen2_0_debug_mem_slave_readdata,     --                                         .readdata
			nios2_gen2_0_debug_mem_slave_writedata         => mm_interconnect_0_nios2_gen2_0_debug_mem_slave_writedata,    --                                         .writedata
			nios2_gen2_0_debug_mem_slave_byteenable        => mm_interconnect_0_nios2_gen2_0_debug_mem_slave_byteenable,   --                                         .byteenable
			nios2_gen2_0_debug_mem_slave_waitrequest       => mm_interconnect_0_nios2_gen2_0_debug_mem_slave_waitrequest,  --                                         .waitrequest
			nios2_gen2_0_debug_mem_slave_debugaccess       => mm_interconnect_0_nios2_gen2_0_debug_mem_slave_debugaccess,  --                                         .debugaccess
			onchip_memory2_0_s1_address                    => mm_interconnect_0_onchip_memory2_0_s1_address,               --                      onchip_memory2_0_s1.address
			onchip_memory2_0_s1_write                      => mm_interconnect_0_onchip_memory2_0_s1_write,                 --                                         .write
			onchip_memory2_0_s1_readdata                   => mm_interconnect_0_onchip_memory2_0_s1_readdata,              --                                         .readdata
			onchip_memory2_0_s1_writedata                  => mm_interconnect_0_onchip_memory2_0_s1_writedata,             --                                         .writedata
			onchip_memory2_0_s1_byteenable                 => mm_interconnect_0_onchip_memory2_0_s1_byteenable,            --                                         .byteenable
			onchip_memory2_0_s1_chipselect                 => mm_interconnect_0_onchip_memory2_0_s1_chipselect,            --                                         .chipselect
			onchip_memory2_0_s1_clken                      => mm_interconnect_0_onchip_memory2_0_s1_clken                  --                                         .clken
		);

	irq_mapper : component System_irq_mapper
		port map (
			clk           => clk_clk,                        --       clk.clk
			reset         => rst_controller_reset_out_reset, -- clk_reset.reset
			receiver0_irq => irq_mapper_receiver0_irq,       -- receiver0.irq
			sender_irq    => nios2_gen2_0_irq_irq            --    sender.irq
		);

	rst_controller : component altera_reset_controller
		generic map (
			NUM_RESET_INPUTS          => 2,
			OUTPUT_RESET_SYNC_EDGES   => "deassert",
			SYNC_DEPTH                => 2,
			RESET_REQUEST_PRESENT     => 1,
			RESET_REQ_WAIT_TIME       => 1,
			MIN_RST_ASSERTION_TIME    => 3,
			RESET_REQ_EARLY_DSRT_TIME => 1,
			USE_RESET_REQUEST_IN0     => 0,
			USE_RESET_REQUEST_IN1     => 0,
			USE_RESET_REQUEST_IN2     => 0,
			USE_RESET_REQUEST_IN3     => 0,
			USE_RESET_REQUEST_IN4     => 0,
			USE_RESET_REQUEST_IN5     => 0,
			USE_RESET_REQUEST_IN6     => 0,
			USE_RESET_REQUEST_IN7     => 0,
			USE_RESET_REQUEST_IN8     => 0,
			USE_RESET_REQUEST_IN9     => 0,
			USE_RESET_REQUEST_IN10    => 0,
			USE_RESET_REQUEST_IN11    => 0,
			USE_RESET_REQUEST_IN12    => 0,
			USE_RESET_REQUEST_IN13    => 0,
			USE_RESET_REQUEST_IN14    => 0,
			USE_RESET_REQUEST_IN15    => 0,
			ADAPT_RESET_REQUEST       => 0
		)
		port map (
			reset_in0      => nios2_gen2_0_debug_reset_request_reset, -- reset_in0.reset
			reset_in1      => nios2_gen2_0_debug_reset_request_reset, -- reset_in1.reset
			clk            => clk_clk,                                --       clk.clk
			reset_out      => rst_controller_reset_out_reset,         -- reset_out.reset
			reset_req      => rst_controller_reset_out_reset_req,     --          .reset_req
			reset_req_in0  => '0',                                    -- (terminated)
			reset_req_in1  => '0',                                    -- (terminated)
			reset_in2      => '0',                                    -- (terminated)
			reset_req_in2  => '0',                                    -- (terminated)
			reset_in3      => '0',                                    -- (terminated)
			reset_req_in3  => '0',                                    -- (terminated)
			reset_in4      => '0',                                    -- (terminated)
			reset_req_in4  => '0',                                    -- (terminated)
			reset_in5      => '0',                                    -- (terminated)
			reset_req_in5  => '0',                                    -- (terminated)
			reset_in6      => '0',                                    -- (terminated)
			reset_req_in6  => '0',                                    -- (terminated)
			reset_in7      => '0',                                    -- (terminated)
			reset_req_in7  => '0',                                    -- (terminated)
			reset_in8      => '0',                                    -- (terminated)
			reset_req_in8  => '0',                                    -- (terminated)
			reset_in9      => '0',                                    -- (terminated)
			reset_req_in9  => '0',                                    -- (terminated)
			reset_in10     => '0',                                    -- (terminated)
			reset_req_in10 => '0',                                    -- (terminated)
			reset_in11     => '0',                                    -- (terminated)
			reset_req_in11 => '0',                                    -- (terminated)
			reset_in12     => '0',                                    -- (terminated)
			reset_req_in12 => '0',                                    -- (terminated)
			reset_in13     => '0',                                    -- (terminated)
			reset_req_in13 => '0',                                    -- (terminated)
			reset_in14     => '0',                                    -- (terminated)
			reset_req_in14 => '0',                                    -- (terminated)
			reset_in15     => '0',                                    -- (terminated)
			reset_req_in15 => '0'                                     -- (terminated)
		);

	mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_read_ports_inv <= not mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_read;

	mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_write_ports_inv <= not mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_write;

	rst_controller_reset_out_reset_ports_inv <= not rst_controller_reset_out_reset;

end architecture rtl; -- of System
