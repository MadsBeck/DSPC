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
		
	Clk <= not Clk after clkPeriod/2;
	csi_clockreset_clk <= Clk;
	

	WaveGen_Proc: process
	
	variable data : std_logic_vector(0 to 255) := (others => '0');
	
	begin
	
		csi_clockreset_reset_n <= '0', '1' after clkPeriod/2;
  
		avs_s1_chipselect <= '1';
		avs_s1_address <= "0000";
		avs_s1_writedata <= X"5465616D";
		wait for clkPeriod;
		
		avs_s1_write <= '1';
		
		wait for clkPeriod*2;
		
		avs_s1_write <= '0';
		avs_s1_chipselect <= '0';
		
		wait for clkPeriod;
		
		avs_s1_chipselect <= '1';
		avs_s1_address <= "0001";
		avs_s1_writedata <= X"466C6578";
		wait for clkPeriod;	
		
		avs_s1_write <= '1';
		
		wait for clkPeriod*2;
		
		avs_s1_write <= '0';
		avs_s1_chipselect <= '0';
		
		wait for clkPeriod;
		
		avs_s1_chipselect <= '1';
		avs_s1_address <= "1111";
		avs_s1_writedata <= X"00000000";
		wait for clkPeriod;	
		
		avs_s1_write <= '1';
		
		wait for clkPeriod;
		
		avs_s1_write <= '0';
		avs_s1_chipselect <= '0';
		
		
		


		wait for clkPeriod*106;
		
		wait for clkPeriod;
		
		for i in 0 to 7 loop
			avs_s1_address <= std_logic_vector(to_unsigned(i,avs_s1_address'length));
			avs_s1_chipselect <= '1';
			wait for clkPeriod;
			avs_s1_read <= '1';
			wait for clkPeriod*3;
			data(i*32 to ((i+1)*32)-1) := avs_s1_readdata;
			avs_s1_read <= '0';
			avs_s1_chipselect <= '0';
			wait for clkPeriod;
		end loop;
		

		wait for clkPeriod;
		
		assert (data = X"07B7348BB4B48AB449449078384FB6ECE73ADE1C475D77164F45CC973B9C9549") report "Sha256 failed with:";

		wait for clkPeriod;

		avs_s1_chipselect <= '1';
		avs_s1_write <= '1';
		wait for clkPeriod;
		
		avs_s1_address <= "0000";
		avs_s1_writedata <= X"5465616D";
		
		
		wait for clkPeriod*2;
		
		avs_s1_address <= "0001";
		avs_s1_writedata <= X"466C6500";
		
		wait for clkPeriod;	
		
		avs_s1_write <= '0';

		wait for clkPeriod*210;
		avs_s1_read <= '1';
		wait for clkPeriod*2;
		for i in 0 to 7 loop
			data(i*32 to ((i+1)*32)-1) := avs_s1_readdata;
			wait for clkPeriod;
		end loop;
		
		avs_s1_read <= '0';
		
		assert (data = X"0713FAB016E9BDE8E00139E35B9C0F3C17C6E44A0C2EF2657BE36768EE98B439") report "Sha256 2 failed with:";
		

		

	-- insert signal assignments here
	wait;
	end process WaveGen_Proc;

end tb;