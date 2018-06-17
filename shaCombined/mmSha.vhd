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
		mm_writedata 		: in std_logic_vector(0 to 31);
		mm_readdata 		: out std_logic_vector(0 to 31));
end mmSha;

architecture bhv of mmSha is

	signal dataIn 		: std_logic_vector(0 to 511) := (others => '0');
	signal dataOut  	: std_logic_vector(0 to 255);
	signal len			: std_logic_vector(0 to 63) := (others => '0');
	signal updateFlag	: std_logic := '0';
	signal finish 		: std_logic;
	signal ready 		: std_logic;
	type state_type is (IDLE, READING, WRITING, WORKING, DONE);
	signal state 		: state_type;
	
	
begin

	
SHA256 : entity work.sha256
	port map(
	inData => dataIn,
	len => len,
	clock => mm_clock,
	reset => mm_reset,
	update => updateFlag,
	finished => finish,
	ready => ready,
	outData => dataOut);
	loadData : process(mm_reset, mm_clock)
	
	variable counter	: integer range 0 to 64;
	variable counterO	: integer range 0 to 8;
	variable check : std_logic := '0';

	
	
	begin
		
		if(mm_reset = '0') then
			mm_readdata <= (others => '0');
			counter := 0;
			counterO := 0;
			updateFlag <= '0';
			check := '0';
			state <= IDLE;
		elsif(rising_edge(mm_clock)) then
		case state is
		when IDLE =>
			updateFlag <= '0';
			if(mm_cs = '1') then
				if(mm_write = '1') then
					state <= WRITING;
				elsif(mm_read = '1') then
					state <= READING;
				end if;
			end if;
		when WRITING =>
		
			case mm_adress is
			when "0000" =>
				dataIn(0 to 31) <= mm_writedata(0 to 31);
			when "0001" =>
				dataIn(32 to 63) <= mm_writedata(0 to 31);
			when "0010" =>
				dataIn(64 to 95) <= mm_writedata(0 to 31);
			when "0011" =>
				dataIn(96 to 127) <= mm_writedata(0 to 31);
			when "0100" =>
				dataIn(128 to 159) <= mm_writedata(0 to 31);
			when "0101" =>
				dataIn(160 to 191) <= mm_writedata(0 to 31);
			when "0110" =>
				dataIn(192 to 223) <= mm_writedata(0 to 31);
			when "0111" =>
				dataIn(224 to 255) <= mm_writedata(0 to 31);
			when "1000" =>
				dataIn(256 to 287) <= mm_writedata(0 to 31);
			when "1001" =>
				dataIn(288 to 319) <= mm_writedata(0 to 31);
			when "1010" =>
				dataIn(320 to 351) <= mm_writedata(0 to 31);
			when "1011" =>
				dataIn(352 to 383) <= mm_writedata(0 to 31);
			when "1100" =>
				dataIn(384 to 415) <= mm_writedata(0 to 31);
			when "1101" =>
				dataIn(416 to 447) <= mm_writedata(0 to 31);
			when "1110" =>
				dataIn(448 to 479) <= mm_writedata(0 to 31);
			when "1111" =>
				dataIn(480 to 511) <= mm_writedata(0 to 31);
			when others =>
			end case;
			counter := counter + 1;
			if(mm_write = '0') then
				state <= WORKING;
			end if;
		when READING =>
			counterO := counterO + 1;
			mm_readdata <= dataOut((counterO-1)*32 to counterO*32-1);
			if(counterO >= 8) then
				state <= DONE;
			end if;

		when WORKING =>
			if (dataIn(counter*32-32 to counter*32-25) = X"00") then
				len(0 to 63) <= std_logic_vector(to_unsigned(counter*4-4,len'length));
			elsif (dataIn(counter*32-24 to counter*32-17) = X"00") then
				len(0 to 63) <= std_logic_vector(to_unsigned(counter*4-3,len'length));
			elsif (dataIn(counter*32-16 to counter*32-9) = X"00") then
				len(0 to 63) <= std_logic_vector(to_unsigned(counter*4-2,len'length));
			elsif (dataIn(counter*32-8 to counter*32-1) = X"00") then
				len(0 to 63) <= std_logic_vector(to_unsigned(counter*4-1,len'length));
			else
				len(0 to 63) <= std_logic_vector(to_unsigned(counter*4,len'length));
			end if;
			if(len /= X"0000000000000000") then
				if(ready = '1') then
					updateFlag <= '1';
					if(finish = '1' and check = '1') then
						state <= DONE;
					else
						check := '1';
					end if;
				elsif(ready = '0') then
					updateFlag <= '0';
				end if;
			end if;
		when DONE =>
			counterO := 0;
			counter := 0;
			check := '0';
			dataIn <= (others => '0');
			state <= IDLE;
		end case;

		end if;
	end process;
end bhv;