--********************************************************************************************************************--
--! @file
--! @brief File Description
--! Copyright&copy - YOUR COMPANY NAME
--********************************************************************************************************************--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_bit_unsigned.all;

package BlockDecomp is
        type StringText is array(63 downto 0) of bit_vector(31 downto 0);
end package;

--! Local libraries
library work;

--! Entity/Package Description
entity tb_HashComp is
end entity tb_HashComp;

architecture tb of tb_HashComp is

Component Hash_Comp
port(
	input : IN StringText;
	clk : IN std_logic;
	reset : IN std_logic;
	output : OUT bit_vector(255 downto 0));
end Component;
-- Signal declarations

--! Component declaration for 

begin

	dut: Hash_Comp PORT MAP(
	
		input => input,
		reset => reset,
		clk => clk,
		output => output);
		
	clk_process : process
	begin
		clk <= '0';
		wait for clkPeriod/2;
		clk <= '1';
		wait for clkPeriod/2;
	end process;

end architecture tb;