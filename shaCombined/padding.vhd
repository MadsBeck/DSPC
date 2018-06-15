library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;


entity padding is
	port(clk			: in std_logic;
		reset			: in std_logic;
		inputString		: in std_logic_vector(31 downto 0);
		inputLength		: in std_logic_vector(63 downto 0);
		ready 			: out std_logic;
		outputString	: out std_logic_vector(511 downto 0)
		);
end entity;


architecture bhv of padding is

constant appendBits : std_logic_vector(63 downto 0) :=(others => '0'); -- Length of initial message to be appended last 

begin

padProc : process
	variable l 	  				:integer range 31 downto 0; -- Length of input string
	variable k					:integer := (448-l)-1 mod 512;		-- Calculation of amount of zeroes needed for the message to append
	variable paddingLength		:integer := l + k + 1 + 64;	-- Size of padded message as used by length of Message
	variable Message 			:std_logic_vector(paddingLength-1 downto 0) :=(others => '0'); -- Size of message is paddingLength
	variable inputStringTemp	:std_logic_vector(31 downto 0) :=(others => '0');
	variable outputStringTemp	:std_logic_vector(paddingLength-1 downto 0) :=(others => '0');

begin
	ready <= '0';
	inputStringTemp := inputString;
	Message ((paddingLength - 1) downto (paddingLength - l)) := inputStringTemp((l - 1) downto 0);
	Message (paddingLength - l - 1) := '1';
	Message (63 downto 0) := inputLength;
	for i in paddingLength-1 downto 0 loop
		outputStringTemp(i) := Message(i);
	end loop;
	outputString <= outputStringTemp;
	ready <= '1';
	wait;
end process;

end architecture;
