--********************************************************************************************************************--
--! @file
--! @brief File Description
--! Copyright&copy - YOUR COMPANY NAME
--********************************************************************************************************************--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


--! Entity/Package Description
entity sha_tb is
end entity sha_tb;

architecture tb of sha_tb is

-- Signal declarations

	component mmsha
		port(
			mm_clock 			: in std_logic;
			mm_reset 			: in std_logic;
			mm_write 			: in std_logic;
			mm_read 			: in std_logic;
			mm_cs 				: in std_logic;
			mm_byteenable 		: in std_logic_vector(3 downto 0);
			mm_adress 			: in std_logic_vector(3 downto 0);
			mm_writedata 		: in std_logic_vector(31 downto 0);
			mm_readdata 		: out std_logic_vector(31 downto 0));
	end component;
	
	-- constants
  constant read_wait_time  : integer := 1;
  constant write_wait_time : integer := 2;

  -- component ports
  signal csi_clockreset_clk     : std_logic := '0';
  signal csi_clockreset_reset_n : std_logic := '1';
  signal avs_s1_write           : std_logic := '0';
  signal avs_s1_read            : std_logic := '0';
  signal avs_s1_chipselect      : std_logic := '0';
  signal avs_s1_byteenable      : std_logic_vector(3 downto 0) := (others => '0');
  signal avs_s1_address         : std_logic_vector(3 downto 0) := (others => '0');
  signal avs_s1_writedata       : std_logic_vector(31 downto 0) := (others => '0');
  signal avs_s1_readdata        : std_logic_vector(31 downto 0) := (others => 'Z');
	
  signal Clk : std_logic := '1';
  
  
constant clkPeriod : time := 10 ns;


begin

	DUT : mmsha
		port map(
		mm_clock		=> csi_clockreset_clk, 	
		mm_reset 		=> csi_clockreset_reset_n,
		mm_write 		=> avs_s1_write,
		mm_read 		=> avs_s1_read,
		mm_cs 			=> avs_s1_chipselect,
		mm_byteenable	=> avs_s1_byteenable,
		mm_adress 		=> avs_s1_address,
		mm_writedata	=> avs_s1_writedata,
		mm_readdata 	=> avs_s1_readdata);
		
	Clk <= not Clk after clkPeriod;
	csi_clockreset_clk <= Clk;
	csi_clockreset_reset_n <= '0', '1' after clkPeriod/2;

	WaveGen_Proc: process
	begin
  
		avs_s1_chipselect <= '1';
		wait for clkPeriod;
		
		avs_s1_address <= "0000";
		avs_s1_writedata <= X"6D616554";
		avs_s1_write <= '1';
		
		wait for clkPeriod;
		
		avs_s1_address <= "0001";
		avs_s1_writedata <= X"78656C46";
		
		wait for clkPeriod;	
		
		avs_s1_write <= '0';



		wait for clkPeriod*20;
		avs_s1_read <= '1';

	-- insert signal assignments here
	wait;
	end process WaveGen_Proc;

end tb;