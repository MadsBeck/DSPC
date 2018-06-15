library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;
use work.paddingpackage;


--------------------------------------------------------------------------------
entity  padding_tb is 
end entity ;
--------------------------------------------------------------------------------


architecture bench of padding_tb is


component padding
	port(clk			: in std_logic;
		reset			: in std_logic;	
		inputString		: in std_logic_vector(31 downto 0);
		inputLength		: in std_logic_vector(63 downto 0);
		ready 			: out std_logic;
		outputString	: out std_logic_vector(511 downto 0)
	);
end component;
  -----------------------------
  -- Port Signals 
  -----------------------------
  type String is array (positive range <>) of character;
  
	signal inputString 			: std_logic_vector(31 downto 0)  := "01100001011000100110001101100100";
	signal inputLength			: std_logic_vector(63 downto 0)  :="0000000000000000000000000000000000000000000000000000000000100000";
	signal outputString			: std_logic_vector(511 downto 0) :=(others => '0');
	signal ready				: std_logic 			:= '0';
	signal clk					: std_logic				:= '0';
	constant period 			: time 					:= 10 ns;
	signal reset 				: std_logic				:= '0';
  
begin  -- architecture bench

  -----------------------------
  -- Component instantiation 
  -----------------------------
  INST: padding
   port map (clk			=> clk,
			reset			=> reset,
			inputString 	=> inputString,
			inputLength		=> inputLength,
			ready			=> ready,
			outputString 	=> outputString);

   -- Clock and reset generation
  clk <= not clk after period/2;
  reset <= '0', '1' after 20 ns;
   
  StimuliProcess : process
  begin
	wait until reset = '1';
	inputString <= "01100001011000100110001101100100";
	inputLength <= "0000000000000000000000000000000000000000000000000000000000100000";
	wait until ready = '1';	
	assert outputString = "01100001011000100110001101100100100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000"
		report "output string error" severity error;
	
  end process StimuliProcess;
  
end architecture bench;



configuration bhv_sim_cfg of padding_tb is
	for bench
		for INST : padding
			use entity work.padding(bhv);
		end for;
	end for;
end bhv_sim_cfg;