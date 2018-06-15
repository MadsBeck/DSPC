library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

use work.sha256Functions.all;

entity sha256 is
	port (
		inData 		: in std_logic_vector(511 downto 0);
		len 		: in std_logic_vector(8 downto 0);
		clock 		: in std_logic;
		reset 		: in std_logic;
		update 		: in std_logic;
		finished 	: out std_logic;
		outData 	: out std_logic_vector(255 downto 0));
end sha256;

architecture bhv of sha256 is

signal padOut 		: std_logic_vector(511 downto 0);
signal readyD 		: std_logic;
signal readyH 		: std_logic;
signal updateD 		: std_logic;
signal finishedD 	: std_logic;
signal deCompOut 	: blockArray;

begin

DECOMP : entity work.deComp
	port map(
	inData => padOut,
	clock => clock,
	reset => reset,
	ready => readyD,
	update => updateD,
	finished => finishedD,
	outData => deCompOut);

HASH : entity work.HashComp
	port map(
	clk => clock,
	reset => reset,
	ready => readyH,
	newData => finishedD,
	input => deCompOut,
	output => outData);

	sha256 : process(reset,clock)
	begin
		if(reset = '0') then
			outData <= (others => '0');
			finished <= '0';
			updateD <= '0';
		elsif(clock'event and reset = '1') then
			if(update = '1' and readyD = '1') then
				padOut <= padInput(inData,len);
				updateD <= '1';
			end if;
			if(readyH = '0') then
				finished <= '0';
			else
				finished <= '1';
			end if;
		end if;
	end process;
	
end bhv;