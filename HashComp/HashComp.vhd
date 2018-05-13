library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.HashCompPkg.all;

entity HashComp is
	port(
		clk    : in std_logic;
		reset  : in std_logic;

		ready  : out std_logic; -- Ready to process the next block
		newData : in  std_logic; -- Start processing the next 
		
		input : IN StringText;
		output : OUT bit_vector(255 downto 0)

	);
end entity HashComp;


architecture rtl of HashComp is

	
	signal h0, h1, h2, h3, h4, h5, h6, h7 : bit_vector(31 downto 0);
	
	signal T1, T2, a, b, c, d, e, f, g, h : bit_vector(31 downto 0);


	Type state_type is (IDLE,BUSY,DONE);
		signal state : state_type;
	

begin

	output <= h0 & h1 & h2 & h3 & h4 & h5 & h6 & h7;
	
	ready <= '1' when state = IDLE else '0';
	
	
	   ---------------------------------------------------------------------------------------------------
   --! HashComp process
   ---------------------------------------------------------------------------------------------------
   hashCompProc : process(reset, clk)
   begin
      if (reset = '1') then
		a <= InitH(0);
		b <= InitH(1);
		c <= InitH(2);
		d <= InitH(3);
		e <= InitH(4);
		f <= InitH(5);
		g <= InitH(6);
		h <= InitH(7);
		T1 <= (others => '0');
		T2 <= (others => '0');
		
		state <= IDLE;
		

      elsif (clk'event and clk = '1') then
	  case state is
		when IDLE =>
			if (newData = '1') then
				
				state <= BUSY;
				
			end if;
		when BUSY =>
			for I 0 to 63 loop
			T1 <= h + ep1(e) + Ch(e,f,g) + Constant_k(I) + InitH(I);
			T2 <= ep0(a) + Maj(a,b,c);
			h <= g;
			g <= f;
			f <= e;
			e <= (d + T1);
			d <= c;
			c <= b;
			b <= a;
			a <= (T1 + T2);			
			
			end loop;
			
			state <= FINAL;
			
		when FINAL =>
			
			h0 <= h0 + a;
			h1 <= h1 + b;			
			h2 <= h2 + c;				
			h3 <= h3 + d;
			h4 <= h4 + e;
			h5 <= h5 + f;
			h6 <= h6 + g;
			h7 <= h7 + h;
				
	  
	  
	  

      end if;
   end process;
end architecture rtl;



function ep0(x : bit_vector) return bit_vector is
   begin
		return bit_vector(rotate_right(unsigned(x), 2) xor rotate_right(unsigned(x), 13) xor rotate_right(unsigned(x), 22));
   end ep0;
   
function ep1 (x : bit_vector) return bit_vector is
   begin
		return bit_vector(rotate_right(unsigned(x), 6) xor rotate_right(unsigned(x), 11) xor rotate_right(unsigned(x), 25));
   end ep1;

function sig0 (x : bit_vector) return bit_vector is
   begin
		return bit_vector((rotate_right(unsigned(x), 7) xor rotate_right(unsigned(x), 18) xor shift_right(unsigned(x), 3));
   end sig0;
   
function sig1 (x : bit_vector) return bit_vector is
   begin
		return bit_vector(rotate_right(unsigned(x), 17) xor rotate_right(unsigned(x), 19) xor shift_right(unsigned(x), 10));
   end sig1;   

function Ch(x, y, z : bit_vector) return bit_vector is
	begin
		return (x and y) xor ((not x) and z);
	end function ch;

function Maj(x, y, z : bit_vector) return bit_vector is
	begin
		return (x and y) xor (x and z) xor (y and z);
	end function maj;   