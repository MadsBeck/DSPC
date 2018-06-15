library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

package paddingPackage is
	function padInput (x : std_logic_vector) return std_logic_vector;
end paddingPackage;

package body paddingPackage is
	function padInput(x : std_logic_vector) return std_logic_vector is
	
		constant appendBits 			:std_logic_vector(63 downto 0) :=(others => '0'); -- Length of initial message to be appended last 
		variable l 	  			:integer range 31 downto 0; -- Length of input string
		variable k				:integer := (448-l)-1 mod 512;		-- Calculation of amount of zeroes needed for the message to append
		variable paddingLength			:integer := l + k + 1 + 64;	-- Size of padded message as used by length of Message
		variable Message 			:std_logic_vector(paddingLength downto 0) :=(others => '0'); -- Size of message is paddingLength
		variable ready 				:std_logic := '0'; -- Flag for testing
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
	end padInput;
end paddingPackage;