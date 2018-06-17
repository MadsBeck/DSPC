library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

use work.sha256Functions.all;

entity deComp is
	port (
		inData : in std_logic_vector(0 to 511);
		clock : in std_logic;
		reset : in std_logic;
		ready : out std_logic;
		update : in std_logic;
		finished : out std_logic;
		outData : out blockArray);
end deComp;
architecture bhv of deComp is


	type states is (IDLE, WORKING, DONE);
	signal state : states;
	signal tempBlock : blockArray;
begin -- blcok deComp
	ready <= '1' when state = IDLE else '0';

	decomp: process(clock,reset)
	variable counter : integer range 16 to 65;
	variable check : std_logic := '0';
	begin
	
		if reset = '0' then
			counter := 16;
			state <= IDLE;
			finished <= '0';
			ready <= '1';
			check := '0';
		elsif (rising_edge(clock)) then
			case state is
				when IDLE =>
					if update = '1' then
						tempBlock(0) <= inData(0 to 31);
						tempBlock(1) <= inData(32 to 63);
						tempBlock(2) <= inData(64 to 95);
						tempBlock(3) <= inData(96 to 127);
						tempBlock(4) <= inData(128 to 159);
						tempBlock(5) <= inData(160 to 191);
						tempBlock(6) <= inData(192 to 223);
						tempBlock(7) <= inData(224 to 255);
						tempBlock(8) <= inData(256 to 287);
						tempBlock(9) <= inData(288 to 319);
						tempBlock(10) <= inData(320 to 351);
						tempBlock(11) <= inData(352 to 383);
						tempBlock(12) <= inData(384 to 415);
						tempBlock(13) <= inData(416 to 447);
						tempBlock(14) <= inData(448 to 479);
						tempBlock(15) <= inData(480 to 511);
						state <= WORKING;
					end if;
					if (update = '0') then
						if(check = '1') then
							finished <= '0';
						else
							check := '1';
						end if;
					end if;
			
				when WORKING =>
					tempBlock(counter) <= (o1(tempBlock(counter-2))+tempBlock(counter-7)+o0(tempBlock(counter-15))+tempBlock(counter-16));
					tempBlock(counter+1) <= (o1(tempBlock(counter-1))+tempBlock(counter-6)+o0(tempBlock(counter-14))+tempBlock(counter-15));
					counter := counter+2;
					if (counter > 63) then
						state <= DONE;
						counter := 16;
					end if;
				when DONE =>
					outData <= tempBlock;
					finished <= '1';
					check := '0';
					state <= IDLE;
			end case;
		end if;

	end process decomp;
end architecture bhv;
