library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

use work.shaFunctions.all;

entity deComp is
	port (
		inData : in std_logic_vector(511 downto 0);
		clock : in std_logic;
		reset : in std_logic;
		ready : out std_logic;
		update : in std_logic;
		finished : out std_logic;
		outData : out wordArray);
end deComp;
architecture bhv of deComp is


	type states is (IDLE, WORKING, DONE);
	signal state : states;
	signal tempBlock : wordArray;
begin -- blcok deComp
	ready <= '1' when state = IDLE else '0';

	decomp: process(clock,reset)
	variable counter : integer range 16 to 65;
	begin
	
		if reset = '1' then
			counter := 16;
			state <= IDLE;
		elsif (rising_edge(clock)) then
			case state is
				when IDLE =>
					if update = '1' then
						tempBlock(0) <= inData(31 downto 0);
						tempBlock(1) <= inData(63 downto 32);
						tempBlock(2) <= inData(95 downto 64);
						tempBlock(3) <= inData(127 downto 96);
						tempBlock(4) <= inData(159 downto 128);
						tempBlock(5) <= inData(191 downto 160);
						tempBlock(6) <= inData(223 downto 192);
						tempBlock(7) <= inData(255 downto 224);
						tempBlock(8) <= inData(287 downto 256);
						tempBlock(9) <= inData(319 downto 288);
						tempBlock(10) <= inData(351 downto 320);
						tempBlock(11) <= inData(383 downto 352);
						tempBlock(12) <= inData(415 downto 384);
						tempBlock(13) <= inData(447 downto 416);
						tempBlock(14) <= inData(479 downto 448);
						tempBlock(15) <= inData(511 downto 480);
						finished <= '0';
						state <= WORKING;
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
					state <= IDLE;
			end case;
		end if;

	end process decomp;
end architecture bhv;
