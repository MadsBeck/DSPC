library ieee;
use ieee.std_logic_1164.all;



entity TopTest is
	port(	CLOCK_50 : IN std_logic
	);
--			csi_clockreset_clk 		: in std_logic; --Avalon Clk
--			csi_clockreset_reset_n 	: in std_logic; --Avalon Reset
--			avs_s1_write				: in std_logic; --Avalon wr
--			avs_s1_read					: in std_logic; --Avalon rd
--			avs_s1_chipselect 		: in std_logic; --Avalon cs
--			avs_s1_byteenable 		: in std_logic_vector(3 downto 0);
--			avs_s1_address 			: in std_logic_vector(3 downto 0); -- Avalon address
--			avs_s1_writedata 			: in std_logic_vector(31 downto 0); -- Avalon wr data
--			avs_s1_readdata 			: out std_logic_vector(255 downto 0)); -- Avalon rd data


end TopTest;

	
	
ARCHITECTURE Structure OF TopTest IS


	component System is
		port (
			clk_clk                        : in  std_logic := 'X' -- clk
			
		);
	end component System;
	
	begin
	
	
	
	u0 : component System
	port map (
			clk_clk                        => CLOCK_50                        --                        clk.clk
	);
	
	
	
	
	
	
	
	
end Structure;
	






