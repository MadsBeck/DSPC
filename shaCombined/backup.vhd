library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;



entity mmSha is
	port (
		mm_clock 			: in std_logic;
		mm_reset 			: in std_logic;
		mm_write 			: in std_logic;
		mm_read 			: in std_logic;
		mm_cs 				: in std_logic;
		mm_byteenable 		: in std_logic_vector(3 downto 0);
		mm_adress 			: in std_logic_vector(3 downto 0);
		mm_writedata 		: in std_logic_vector(31 downto 0);
		mm_readdata 		: out std_logic_vector(31 downto 0));
end mmSha;

architecture bhv of mmSha is

	signal dataIn 		: std_logic_vector(511 downto 0);
	signal dataOut  	: std_logic_vector(255 downto 0);
	signal len			: std_logic_vector(8 downto 0);
	signal updateFlag	: std_logic;
	signal finish 		: std_logic;
	
begin

SHA256 : entity work.sha256
	port map(
	inData => dataIn,
	len => len,
	clock => mm_clock,
	reset => mm_reset,
	update => updateFlag,
	finished => finish,
	outData => dataOut);
	loadData : process(mm_reset, mm_clock)
	
	variable counter	: integer range 0 to 64;
	variable counterO	: integer range 0 to 7;
	
	begin
		if(mm_reset = '0') then
			mm_readdata <= (others => '0');
			counter := 0;
			counterO := 0;
		elsif(mm_clock'event and mm_reset = '1') then
		if(mm_cs = '1') then
			if(mm_write = '1') then
			case mm_adress is
			when "0000" =>
				dataIn(31 downto 0) <= mm_writedata(31 downto 0);
				if(mm_writedata(7 downto 0) /= X"00") then
					counter := 1;
				if(mm_writedata(15 downto 8) /= X"00") then
					counter := 2;
				if(mm_writedata(23 downto 16) /= X"00") then
					counter := 3;
				if(mm_writedata(31 downto 24) /= X"00") then
					counter := 4;
				end if;
			when "0001" =>
				dataIn(63 downto 32) <= mm_writedata(31 downto 0);
				if(mm_writedata(7 downto 0) /= X"00") then
					counter := 5;
				if(mm_writedata(15 downto 8) /= X"00") then
					counter := 6;
				if(mm_writedata(23 downto 16) /= X"00") then
					counter := 7;
				if(mm_writedata(31 downto 24) /= X"00") then
					counter := 8;
				end if;
			when "0010" =>
				dataIn(95 downto 64) <= mm_writedata(31 downto 0);
				if(mm_writedata(7 downto 0) /= X"00") then
					counter := 9;
				if(mm_writedata(15 downto 8) /= X"00") then
					counter := 10;
				if(mm_writedata(23 downto 16) /= X"00") then
					counter := 11;
				if(mm_writedata(31 downto 24) /= X"00") then
					counter := 12;
				end if;
			when "0011" =>
				dataIn(127 downto 96) <= mm_writedata(31 downto 0);
				if(mm_writedata(7 downto 0) /= X"00") then
					counter := 13;
				if(mm_writedata(15 downto 8) /= X"00") then
					counter := 14;
				if(mm_writedata(23 downto 16) /= X"00") then
					counter := 15;
				if(mm_writedata(31 downto 24) /= X"00") then
					counter := 16;
				end if;
			when "0100" =>
				dataIn(159 downto 128) <= mm_writedata(31 downto 0);
				if(mm_writedata(7 downto 0) /= X"00") then
					counter := 17;
				if(mm_writedata(15 downto 8) /= X"00") then
					counter := 18;
				if(mm_writedata(23 downto 16) /= X"00") then
					counter := 19;
				if(mm_writedata(31 downto 24) /= X"00") then
					counter := 20;
				end if;
			when "0101" =>
				dataIn(191 downto 160) <= mm_writedata(31 downto 0);
				if(mm_writedata(7 downto 0) /= X"00") then
					counter := 21;
				if(mm_writedata(15 downto 8) /= X"00") then
					counter := 22;
				if(mm_writedata(23 downto 16) /= X"00") then
					counter := 23;
				if(mm_writedata(31 downto 24) /= X"00") then
					counter := 24;
				end if;
			when "0110" =>
				dataIn(223 downto 192) <= mm_writedata(31 downto 0);
				if(mm_writedata(7 downto 0) /= X"00") then
					counter := 25;
				if(mm_writedata(15 downto 8) /= X"00") then
					counter := 26;
				if(mm_writedata(23 downto 16) /= X"00") then
					counter := 27;
				if(mm_writedata(31 downto 24) /= X"00") then
					counter := 28;
				end if;
			when "0111" =>
				dataIn(255 downto 224) <= mm_writedata(31 downto 0);
				if(mm_writedata(7 downto 0) /= X"00") then
					counter := 29;
				if(mm_writedata(15 downto 8) /= X"00") then
					counter := 30;
				if(mm_writedata(23 downto 16) /= X"00") then
					counter := 31;
				if(mm_writedata(31 downto 24) /= X"00") then
					counter := 32;
				end if;
			when "1000" =>
				dataIn(287 downto 256) <= mm_writedata(31 downto 0);
				if(mm_writedata(7 downto 0) /= X"00") then
					counter := 33;
				if(mm_writedata(15 downto 8) /= X"00") then
					counter := 34;
				if(mm_writedata(23 downto 16) /= X"00") then
					counter := 35;
				if(mm_writedata(31 downto 24) /= X"00") then
					counter := 36;
				end if;
			when "1001" =>
				dataIn(319 downto 288) <= mm_writedata(31 downto 0);
				if(mm_writedata(7 downto 0) /= X"00") then
					counter := 37;
				if(mm_writedata(15 downto 8) /= X"00") then
					counter := 38;
				if(mm_writedata(23 downto 16) /= X"00") then
					counter := 39;
				if(mm_writedata(31 downto 24) /= X"00") then
					counter := 40;
				end if;
			when "1010" =>
				dataIn(351 downto 320) <= mm_writedata(31 downto 0);
				if(mm_writedata(7 downto 0) /= X"00") then
					counter := 41;
				if(mm_writedata(15 downto 8) /= X"00") then
					counter := 42;
				if(mm_writedata(23 downto 16) /= X"00") then
					counter := 43;
				if(mm_writedata(31 downto 24) /= X"00") then
					counter := 44;
				end if;
			when "1011" =>
				dataIn(383 downto 352) <= mm_writedata(31 downto 0);
				if(mm_writedata(7 downto 0) /= X"00") then
					counter := 45;
				if(mm_writedata(15 downto 8) /= X"00") then
					counter := 46;
				if(mm_writedata(23 downto 16) /= X"00") then
					counter := 47;
				if(mm_writedata(31 downto 24) /= X"00") then
					counter := 48;
				end if;
			when "1100" =>
				dataIn(415 downto 384) <= mm_writedata(31 downto 0);
				if(mm_writedata(7 downto 0) /= X"00") then
					counter := 49; 
				if(mm_writedata(15 downto 8) /= X"00") then
					counter := 50;
				if(mm_writedata(23 downto 16) /= X"00") then
					counter := 51;
				if(mm_writedata(31 downto 24) /= X"00") then
					counter := 52;
				end if;
			when "1101" =>
				dataIn(447 downto 416) <= mm_writedata(31 downto 0);
				if(mm_writedata(7 downto 0) /= X"00") then
					counter := 53;
				if(mm_writedata(15 downto 8) /= X"00") then
					counter := 54;
				if(mm_writedata(23 downto 16) /= X"00") then
					counter := 55;
				if(mm_writedata(31 downto 24) /= X"00") then
					counter := 56;
				end if;
			when "1110" =>
				dataIn(479 downto 448) <= mm_writedata(31 downto 0);
				if(mm_writedata(7 downto 0) /= X"00") then
					counter := 57;
				if(mm_writedata(15 downto 8) /= X"00") then
					counter := 58;
				if(mm_writedata(23 downto 16) /= X"00") then
					counter := 59;
				if(mm_writedata(31 downto 24) /= X"00") then
					counter := 60;
				end if;
			when "1111" =>
				dataIn(511 downto 480) <= mm_writedata(31 downto 0);
				if(mm_writedata(7 downto 0) /= X"00") then
					counter := 61;
				if(mm_writedata(15 downto 8) /= X"00") then
					counter := 62;
				if(mm_writedata(23 downto 16) /= X"00") then
					counter := 63;
				if(mm_writedata(31 downto 24) /= X"00") then
					counter := 64;
				end if;
				len <= std_logic_vector(to_unsigned(counter,9));
				updateFlag <= '1';
			when others =>
				
				
			end case;
					
				elsif(mm_read = '1') then
					mm_readdata <= dataOut(counterO+1*32-1 downto counterO*32);
					counterO := counterO + 1;
				end if;
				
			end if;

		end if;
	end process;
end bhv;