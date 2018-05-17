library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


package shaFunctions is

	function o0(x : std_logic_vector) return std_logic_vector;
	function o1(x : std_logic_vector) return std_logic_vector;
	type wordArray is array (63 downto 0) of std_logic_vector(31 downto 0);
	
end package shaFunctions;

package body shaFunctions is

	

	function o0(x : std_logic_vector) return std_logic_vector is
	begin
		return std_logic_vector(rotate_right(unsigned(x), 7) xor rotate_right(unsigned(x), 18) xor shift_right(unsigned(x), 3));
	end function o0;

	function o1(x : std_logic_vector) return std_logic_vector is
	begin
		return std_logic_vector(rotate_right(unsigned(x), 17) xor rotate_right(unsigned(x), 19) xor shift_right(unsigned(x), 10));
	end function o1;
	
end package body shaFunctions;