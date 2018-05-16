--********************************************************************************************************************--
--! @file
--! @brief File Description
--! Copyright&copy - YOUR COMPANY NAME
--********************************************************************************************************************--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

use work.HashCompPkg.all;


--! Entity/Package Description
entity tb_HashComp is
end entity tb_HashComp;

architecture tb of tb_HashComp is

-- Signal declarations

--Input signals
	signal reset : std_logic := '0';
	signal newData : std_logic := '0';
	signal clk : std_logic := '0';
	signal input : StringText := (others => (others => '0'));

--OutPut signal
	signal ready : std_logic := '0';
	signal output : std_logic_vector(255 downto 0);
	
	
	constant clkPeriod : time := 10 ns;






--! Component declaration for 

begin

	dut: entity work.HashComp 
	PORT MAP(
	
		input => input,
		reset => reset,
		clk => clk,
		output => output,
		ready => ready,
		newData => newData);
		
	--! Clock generatetion
		
	clk_process : process
	begin
		clk <= '0';
		wait for clkPeriod/2;
		clk <= '1';
		wait for clkPeriod/2;
	end process;
	
	
	   ---------------------------------------------------------------------------------------------------
   --! Stimuli process
   ---------------------------------------------------------------------------------------------------
   stim_proc : process
   begin

	input(0) <= X"5465616d"; -- hash data for TeamGoFlex
	input(1) <= X"476f466c";
	input(2) <= X"65788000";
	input(3) <= X"00000000";
	input(4) <= X"00000000";
	input(5) <= X"00000000";
	input(6) <= X"00000000";
	input(7) <= X"00000000";
	input(8) <= X"00000000";
	input(9) <= X"00000000";
	input(10) <= X"00000000";
	input(11) <= X"00000000";
	input(12) <= X"00000000";
	input(13) <= X"00000000";
	input(14) <= X"00000000";
	input(15) <= X"00000050";
	input(16) <= X"565d8907";
	input(17) <= X"73f73eca";
	input(18) <= X"db2f5687";
	input(19) <= X"78a08a4a";
	input(20) <= X"41a5dd27";
	input(21) <= X"54725b66";
	input(22) <= X"552721e1";
	input(23) <= X"bd288528";
	input(24) <= X"e8d108c9";
	input(25) <= X"2d4d5997";
	input(26) <= X"1de8877a";
	input(27) <= X"4997fd80";
	input(28) <= X"a7c792ce";
	input(29) <= X"568969e7";
	input(30) <= X"9853fc31";
	input(31) <= X"e8d2cc8d";
	input(32) <= X"5a8f63d3";
	input(33) <= X"933f86ba";
	input(34) <= X"3bc4884a";
	input(35) <= X"861511a8";
	input(36) <= X"be512d8c";
	input(37) <= X"17fe2d59";
	input(38) <= X"58e7b9fc";
	input(39) <= X"b7b438c2";
	input(40) <= X"257f28d6";
	input(41) <= X"dabf089e";
	input(42) <= X"0c37e52a";
	input(43) <= X"da581963";
	input(44) <= X"6bfef4d8";
	input(45) <= X"4e52e2ae";
	input(46) <= X"aade826c";
	input(47) <= X"b07393dc";
	input(48) <= X"4d8f0f1a";
	input(49) <= X"0c4ed59f";
	input(50) <= X"823e57f5";
	input(51) <= X"e8692319";
	input(52) <= X"294f8b15";
	input(53) <= X"9684b1ab";
	input(54) <= X"dbe6f2c8";
	input(55) <= X"36d8f2ae";
	input(56) <= X"bd9eb755";
	input(57) <= X"70e0dc80";
	input(58) <= X"5cb75c9c";
	input(59) <= X"7a11ec60";
	input(60) <= X"364b98a1";
	input(61) <= X"6271d3a5";
	input(62) <= X"ec9a5d64";
	input(63) <= X"40bd38d1";
	
	
	
	reset <= '1';
	wait for clkPeriod;
	reset <= '0';
	wait for clkPeriod;
	
	assert ready = '1' report "Failed to reset" severity error;
	
	newData <= '1';
	wait for clkPeriod;
	newData <= '0';
	
	wait until ready = '1';
	
	assert output = X"135c6560432275a70eed672fa5d480818a62b4c2e57bde90437ce069a92c2d7f" report "Failed to calculate hash for TeamGoFlex" severity error;
		
	assert false report "Simulation Finished" severity failure;
      

   end process;

	

end architecture tb;