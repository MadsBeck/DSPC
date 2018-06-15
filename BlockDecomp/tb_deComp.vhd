library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

use work.shaFunctions.all;


--------------------------------------------------------------------------------
entity  tb_deComp is

end entity tb_deComp;
--------------------------------------------------------------------------------

architecture Bhv of tb_deComp is
	signal dataIn : std_logic_vector(511 downto 0);
	signal reset : std_logic;
	signal update : std_logic := '0';

	signal dataOut : wordArray;
	signal ready : std_logic;
	signal finished : std_logic;

	signal clock : std_logic;
	constant clk_period : time := 10 ns;

  
begin  -- architecture Bhv

  -----------------------------
  -- component instantiation 
  -----------------------------
	uut: entity work.deComp
		port map (
		clock => clock,
		reset => reset,
		ready => ready,
		finished => finished,
		update => update,
		inData  => dataIn,
		outData => dataOut);

	clk: process
	begin
		clock <= '0';
		wait for clk_period/2;
		clock <= '1';
		wait for clk_period/2;
	end process clk;
	
	
	StimuliProcess : process
  	begin
		dataIn <= "01100001011000100110001101100100100000000000" &
		"0000000000000000000000000000000000000000000000000000000000000000000" &
		"0000000000000000000000000000000000000000000000000000000000000000000" &
		"0000000000000000000000000000000000000000000000000000000000000000000" &
		"0000000000000000000000000000000000000000000000000000000000000000000" &
		"0000000000000000000000000000000000000000000000000000000000000000000" &
		"0000000000000000000000000000000000000000000000000000000000000000000" &
		"000000000000000000000000000000000000000000000000000000000000100000";
		
		wait for clk_period * 2;

		reset <= '1';
		wait for clk_period;
		reset <= '0';
		wait for clk_period;
		
		assert ready = '1' report "deComp is not ready after reset!";
		wait for clk_period;

		update <= '1';
		wait for clk_period;
		update <= '0';

		wait until ready = '1';
			
		assert dataOut(0) = X"61626364" and
			dataOut(1) = X"80000000" and
			dataOut(2) = X"00000000" and
			dataOut(3) = X"00000000" and
			dataOut(4) = X"00000000" and
			dataOut(5) = X"00000000" and
			dataOut(6) = X"00000000" and
			dataOut(7) = X"00000000" and
			dataOut(8) = X"00000000" and
			dataOut(9) = X"00000000" and
			dataOut(10) = X"00000000" and
			dataOut(11) = X"00000000" and
			dataOut(12) = X"00000000" and
			dataOut(13) = X"00000000" and
			dataOut(14) = X"00000000" and
			dataOut(15) = X"00000020" and
			dataOut(16) = X"72628364" and
			dataOut(17) = X"80140000" and
			dataOut(18) = X"11c22fdd" and
			dataOut(19) = X"80205508" and
			dataOut(20) = X"52115a52" and
			dataOut(21) = X"20055801" and
			dataOut(22) = X"8677e73c" and
			dataOut(23) = X"796b38b8" and
			dataOut(24) = X"8f6c4e0c" and
			dataOut(25) = X"0d179933" and
			dataOut(26) = X"2f046250" and
			dataOut(27) = X"91cdfd21" and
			dataOut(28) = X"dd6f2b7b" and
			dataOut(29) = X"c78870dc" and
			dataOut(30) = X"2a59078c" and
			dataOut(31) = X"2c21f147" and
			dataOut(32) = X"33b9aac2" and
			dataOut(33) = X"a985640c" and
			dataOut(34) = X"980c48c2" and
			dataOut(35) = X"74afbea8" and
			dataOut(36) = X"1739d0f4" and
			dataOut(37) = X"0307b16e" and
			dataOut(38) = X"36eccece" and
			dataOut(39) = X"f72f560f" and
			dataOut(40) = X"b9993801" and
			dataOut(41) = X"a44a3feb" and
			dataOut(42) = X"8d34eed6" and
			dataOut(43) = X"27f34e9a" and
			dataOut(44) = X"8852e608" and
			dataOut(45) = X"2a0983e6" and
			dataOut(46) = X"48fd55f7" and
			dataOut(47) = X"bfe14650" and
			dataOut(48) = X"2dbbe909" and
			dataOut(49) = X"46893ac9" and
			dataOut(50) = X"fb852a6f" and
			dataOut(51) = X"56231afc" and
			dataOut(52) = X"a1c5b260" and
			dataOut(53) = X"e33cfe77" and
			dataOut(54) = X"3aaa947a" and
			dataOut(55) = X"5ff97cf4" and
			dataOut(56) = X"651a9dff" and
			dataOut(57) = X"b8cc1c00" and
			dataOut(58) = X"e3c8290d" and
			dataOut(59) = X"1100548b" and
			dataOut(60) = X"271c4e0f" and
			dataOut(61) = X"3878453f" and
			dataOut(62) = X"3ede4927" and
			dataOut(63) = X"3ce08b0e"
				report "block Decomp Error";

  	end process StimuliProcess;
  
end architecture Bhv;