library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

use work.sha256Functions.all;

entity HashComp is
	port(
		clk    : in std_logic;
		reset  : in std_logic;

		ready  : out std_logic; -- Ready to process the next block
		newData : in  std_logic; -- Start processing the next 
		
		input : IN blockArray;
		hOut : out std_logic_vector(0 to 255)

	);
end entity HashComp;


architecture rtl of HashComp is

	
	signal h0, h1, h2, h3, h4, h5, h6, h7 : std_logic_vector(0 to 31);
	
	signal a, b, c, d, e, f, g, h : std_logic_vector(0 to 31);
	


	Type state_type is (IDLE,BUSY,FINAL);
		signal state : state_type;
	

begin

	
	ready <= '1' when state = IDLE else '0';
	
	
	   ---------------------------------------------------------------------------------------------------
   --! HashComp process
   ---------------------------------------------------------------------------------------------------
   hashCompProc : process(reset, clk)
   
   variable Counter : std_logic_vector(0 to 5) := (others => '0');
   variable K : std_logic_vector(0 to 31) := (others => '0');
   variable inputTemp : std_logic_vector(0 to 31) := (others => '0');
   
   variable T1 : std_logic_vector(0 to 31) := (others => '0'); 
   variable T2 : std_logic_vector(0 to 31) := (others => '0'); 
   variable tempOut : std_logic_vector(0 to 255) := (others => '0');
   
   
   
   begin
      if (reset = '0') then
		a <= INIT_A;
		b <= INIT_B;
		c <= INIT_C;
		d <= INIT_D;
		e <= INIT_E;
		f <= INIT_F;
		g <= INIT_G;
		h <= INIT_H;
		T1:= (others => '0');
		T2 := (others => '0');
		tempOut := (others => '0');
		hOut <= tempOut; 
		
		state <= IDLE;
		
		

      elsif (rising_edge(clk)) then
	  case state is
		when IDLE =>
			tempOut := h0 & h1 & h2 & h3 & h4 & h5 & h6 & h7;
			hOut <= tempOut;
			a <= INIT_A;
			b <= INIT_B;
			c <= INIT_C;
			d <= INIT_D;
			e <= INIT_E;
			f <= INIT_F;
			g <= INIT_G;
			h <= INIT_H;
			T1:= (others => '0');
			T2 := (others => '0');
			if (newData = '1') then
				
				state <= BUSY;
				
			end if;
		when BUSY =>
		
		
			K := (constants(to_integer(unsigned(Counter))));
			inputTemp := (input(to_integer(unsigned(Counter))));
			
			T1 :=  std_logic_vector(unsigned(h) + unsigned(ep1(e)) + unsigned(Ch(e,f,g)) + unsigned(K) + unsigned(inputTemp));
			T2 := std_logic_vector(unsigned(ep0(a)) + unsigned(Maj(a,b,c)));
			h <= g;
			g <= f;
			f <= e;
			e <= std_logic_vector(unsigned(d) + unsigned(T1));
			d <= c;
			c <= b;
			b <= a;
			a <= std_logic_vector(unsigned(T1) + unsigned(T2));	
			
		if(Counter /= b"111111" ) then
		Counter := std_logic_vector(unsigned(Counter) + 1);	
		else
		state <= FINAL;
		
		
		end if;
			
		
			
			
		when FINAL => --TODO Make so that input can be longer than 512;
			h0 <= std_logic_vector(unsigned(a) + unsigned(INIT_A));
			h1 <= std_logic_vector(unsigned(b) + unsigned(INIT_B));
			h2 <= std_logic_vector(unsigned(c) + unsigned(INIT_C));
			h3 <= std_logic_vector(unsigned(d) + unsigned(INIT_D));
			h4 <= std_logic_vector(unsigned(e) + unsigned(INIT_E));
			h5 <= std_logic_vector(unsigned(f) + unsigned(INIT_F));
			h6 <= std_logic_vector(unsigned(g) + unsigned(INIT_G));
			h7 <= std_logic_vector(unsigned(h) + unsigned(INIT_H));
			
			
			state <= IDLE;
		end case;
				
	  
	  
	  

      end if;
   end process;
end architecture rtl;


  