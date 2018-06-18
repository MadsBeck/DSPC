library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

use work.sha256Functions.all;

entity sha256 is
	port (
		inData 		: in std_logic_vector(0 to 511);
		len 		: in std_logic_vector(0 to 63);
		clock 		: in std_logic;
		reset 		: in std_logic;
		update 		: in std_logic;
		finished 	: out std_logic;
		workingS	: out std_logic;
		ready 		: out std_logic;
		readS		: in std_logic;
		outData 	: out std_logic_vector(0 to 255));
end sha256;

architecture bhv of sha256 is

signal padOut 		: std_logic_vector(0 to 511) := (others => '0');
signal readyD 		: std_logic := '0';
signal readyH 		: std_logic := '0';
signal updateD 		: std_logic := '0';
signal finishedD 	: std_logic := '0';
signal workingD 	: std_logic := '0';
signal workingH 	: std_logic := '0';
signal hOut		: std_logic_vector(0 to 255) := (others => '0');
signal deCompOut 	: blockArray;
type state_type is (IDLE, WORKING, DONE);
signal state 		: state_type;

begin

	ready <= '1' when state = IDLE else '0';
	workingS <= '0' when state = IDLE else '1';

DECOMP : entity work.deComp
	port map(
	inData => padOut,
	clock => clock,
	reset => reset,
	workingD => workingD,
	ready => readyD,
	update => updateD,
	finished => finishedD,
	outData => deCompOut);

HASH : entity work.HashComp
	port map(
	clk => clock,
	reset => reset,
	ready => readyH,
	workingH => workingH,
	newData => finishedD,
	hOut => hOut,
	input => deCompOut);

	sha256 : process(reset,clock)
	variable check : std_logic := '0';
	begin --TODO STATE MACHINE!
	
	if(reset = '0') then
		outData <= (others => '0');
		finished <= '0';
		updateD <= '0';
		check := '0';
		state <= IDLE;
	elsif(rising_edge(clock)) then
		case state is
		when IDLE =>
			if(update = '1' and readyD = '1' and readyH = '1') then
				finished <= '0';
				state <= WORKING;
				padOut <= padInput(inData,len);
				updateD <= '1';
			end if;
			if readS = '1' then
				finished <= '0';
			end if;
		when WORKING =>
			if(workingD = '1') then
				updateD <= '0';
			end if;
			if (workingH = '1') then
				check := '1';
			end if;
			if(workingH = '0' and check = '1' and readyH = '1') then
					state <= DONE;
			end if;
		when DONE =>
			outData <= hOut;
			finished <= '1';
			check := '0';
			state <= IDLE;
		end case;
	end if;	
		
	end process;
	
end bhv;