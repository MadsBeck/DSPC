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
	signal done			: std_logic;
	
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
				done <= '1';
				case mm_adress is
				when "0000" =>
					dataIn(31 downto 0) <= mm_writedata(31 downto 0);
				when "0001" =>
					dataIn(63 downto 32) <= mm_writedata(31 downto 0);
				when "0010" =>
					dataIn(95 downto 64) <= mm_writedata(31 downto 0);
				when "0011" =>
					dataIn(127 downto 96) <= mm_writedata(31 downto 0);
				when "0100" =>
					dataIn(159 downto 128) <= mm_writedata(31 downto 0);
				when "0101" =>
					dataIn(191 downto 160) <= mm_writedata(31 downto 0);
				when "0110" =>
					dataIn(223 downto 192) <= mm_writedata(31 downto 0);
				when "0111" =>
					dataIn(255 downto 224) <= mm_writedata(31 downto 0);
				when "1000" =>
					dataIn(287 downto 256) <= mm_writedata(31 downto 0);
				when "1001" =>
					dataIn(319 downto 288) <= mm_writedata(31 downto 0);
				when "1010" =>
					dataIn(351 downto 320) <= mm_writedata(31 downto 0);
				when "1011" =>
					dataIn(383 downto 352) <= mm_writedata(31 downto 0);
				when "1100" =>
					dataIn(415 downto 384) <= mm_writedata(31 downto 0);
				when "1101" =>
					dataIn(447 downto 416) <= mm_writedata(31 downto 0);
				when "1110" =>
					dataIn(479 downto 448) <= mm_writedata(31 downto 0);
				when "1111" =>
					dataIn(511 downto 480) <= mm_writedata(31 downto 0);
					len <= std_logic_vector(to_unsigned(counter,9));
					updateFlag <= '1';
				when others =>

				end case;
				counter := counter + 1;
				elsif(done = '1' and mm_write = '0') then
					if (dataIn(counter*32-25 downto counter*32-32) = X"00") then
						len <= std_logic_vector(to_unsigned(counter*4-4,9));
					elsif (dataIn(counter*32-17 downto counter*32-24) = X"00") then
						len <= std_logic_vector(to_unsigned(counter*4-3,9));
					elsif (dataIn(counter*32-9 downto counter*32-16) = X"00") then
						len <= std_logic_vector(to_unsigned(counter*4-2,9));
					elsif (dataIn(counter*32-1 downto counter*32-8) = X"00") then
						len <= std_logic_vector(to_unsigned(counter*4-1,9));
					else
						len <= std_logic_vector(to_unsigned(counter*4,9));
					end if;
				elsif(mm_read = '1') then
					mm_readdata <= dataOut(counterO+1*32-1 downto counterO*32);
					counterO := counterO + 1;
				end if;
				
			end if;

		end if;
	end process;
end bhv;