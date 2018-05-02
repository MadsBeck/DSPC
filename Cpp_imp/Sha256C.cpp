#include <string>
#include <iostream>
#include <bitset>
#include <vector>



unsigned long sig0(unsigned long X);
unsigned long sig1(unsigned long X);
unsigned long rotright(unsigned long num, int shift);
unsigned long shfright(unsigned long num, int shift);
unsigned long bSig0(unsigned long X);
unsigned long bSig1(unsigned long X);
unsigned long Maj(unsigned long X, unsigned long Y, unsigned long Z);
unsigned long Ch(unsigned long X, unsigned long Y, unsigned long Z);

unsigned long ep0(unsigned long x);
unsigned long ep1(unsigned long x);


const unsigned long Constant_k[64] = {
	0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1,
	0x923f82a4, 0xab1c5ed5, 0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
	0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174, 0xe49b69c1, 0xefbe4786,
	0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
	0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147,
	0x06ca6351, 0x14292967, 0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
	0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85, 0xa2bfe8a1, 0xa81a664b,
	0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
	0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a,
	0x5b9cca4f, 0x682e6ff3, 0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
	0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2 };

unsigned long H[8] = { 0x6a09e667, 0xbb67ae85, 0x3c6ef372,
0xa54ff53a, 0x510e527f, 0x9b05688c,
0x1f83d9ab, 0x5be0cd19 };



int main(void)
{
	std::string input("TeamGoFlex");

	std::cout << input << std::endl;

	std::vector<unsigned long> block;

	for (int i = 0; i < input.size(); ++i)
	{
		// Make a temporary variable called B to store the 8 bit pattern
		// for the ASCII value.
		std::bitset<8> b(input.c_str()[i]);

		// Add that 8 bit pattern into the block.
		block.push_back(b.to_ulong());
	}

	long long length = block.size() * 8;

	//std::cout << length << std::endl;

	/*Padding*/

	int k = (447 - length);

	std::cout << "K: " << k << std::endl;

	unsigned long t1 = 0x80;
	block.push_back(t1); //should be only be 1 bit

	k -= 7;

	for (int i = 0; i < k / 8; i++)
		block.push_back(0x00000000);

	std::bitset<64> big_64bit_blob(length);

	std::string big_64_bit_string = big_64bit_blob.to_string();

	std::bitset<8> temp_string_holder1(big_64_bit_string.substr(0, 8));

	block.push_back(temp_string_holder1.to_ulong());

	for (int i = 8; i < 63; i = i + 8)
	{
		std::bitset<8> temp_string_holder2(big_64_bit_string.substr(i, 8));

		block.push_back(temp_string_holder2.to_ulong());

	}



	//for (std::vector<unsigned long>::iterator it = block.begin(); it != block.end(); ++it)
	//	std::cout << std::hex << *it << std::endl;
	std::cout << "Size after padding: " << std::dec << block.size() << std::endl;

	//std::cout << "after padding" << std::endl;
	//for (std::vector<unsigned long>::iterator it = block.begin(); it != block.end(); ++it)
	//	std::cout << std::hex << *it << std::endl;
	/*Padding done!*/

	/*Block resize*/










	std::vector<unsigned long> W_temp(16);

	for (int i = 0; i < 64; i = i + 4)
	{
		std::bitset<32> temp(0);

		temp = (unsigned long)block[i] << 24;
		temp |= (unsigned long)block[i + 1] << 16;
		temp |= (unsigned long)block[i + 2] << 8;
		temp |= (unsigned long)block[i + 3];

		W_temp[i / 4] = temp.to_ulong();
	}
	/*Block resize done*/

	//std::cout << "blockDecomp" << std::endl;
	//for (std::vector<unsigned long>::iterator it = W.begin(); it != W.end(); ++it)
	//	std::cout << std::hex <<"0x"<< *it<<std::endl;	
	/*Hash Comp*/
	unsigned long W[64];

	

	for (int i = 0; i <= 15; i++)
	{
		W[i] = W_temp[i] & 0xFFFFFFFF;
	}
	for (int i = 16; i <= 63; i++)
	{
		W[i] = (sig1(W[i - 2]) + W[i - 7] + sig0(W[i - 15]) + W[i - 16]);
		W[i] = W[i] & 0xFFFFFFFF;
	}

	std::cout << "New::" << std::endl;
	for (int i = 0; i <= 63; i++)
	{
		std::cout << "0x" << std::dec << W[i] << std::endl;
	}


		
	unsigned long T1, T2, a, b, c, d, e, f, g, h;
	a = H[0];
	b = H[1];
	c = H[2];
	d = H[3];
	e = H[4];
	f = H[5];
	g = H[6];
	h = H[7];

	for (int i = 0; i < 64; i++)
	{
		T1 = h + ep1(e) + Ch(e, f, g) + Constant_k[i] + W[i];
		T2 = (ep0(a) + Maj(a, b, c));
		h = g;
		g = f;
		f = e;
		e = (d + T1) & 0xFFFFFFFF;
		d = c;
		c = b;
		b = a;
		a = (T1 + T2) & 0xFFFFFFFF;




	}

	H[0] = (H[0] + a) & 0xFFFFFFFF;
	H[1] = (H[1] + b) & 0xFFFFFFFF;
	H[2] = (H[2] + c) & 0xFFFFFFFF;
	H[3] = (H[3] + d) & 0xFFFFFFFF;
	H[4] = (H[4] + e) & 0xFFFFFFFF;
	H[5] = (H[5] + f) & 0xFFFFFFFF;
	H[6] = (H[6] + g) & 0xFFFFFFFF;
	H[7] = (H[7] + h) & 0xFFFFFFFF;

	std::cout << sizeof(H) << std::endl;


	std::cout << "New::" << std::endl;
	for (int i = 0; i < 8; i++)
	{
		std::cout <<std::hex << H[i];
	}std::cout << std::endl;











	/*Hash Comp DONE!*/


}

unsigned long Ch(unsigned long X, unsigned long Y, unsigned long Z)
{
	unsigned long Temp1 = X & Y;
	unsigned long Temp2 = ~X & Z;

	return Temp1 ^ Temp2;
}
unsigned long Maj(unsigned long X, unsigned long Y, unsigned long Z)
{
	unsigned long Temp1 = X & Y;
	unsigned long Temp2 = X & Z;
	unsigned long Temp3 = Y & Z;

	return Temp1 ^ Temp2 ^ Temp3;
}


unsigned long sig0(unsigned long X)
{
	return rotright(X, 7) ^ rotright(X, 18) ^ shfright(X, 3);


}

unsigned long sig1(unsigned long X)
{
	return rotright(X, 17) ^ rotright(X, 19) ^ shfright(X, 10);

}

unsigned long bSig0(unsigned long X)
{
	unsigned long Temp1 = rotright(X, 2);
	unsigned long Temp2 = rotright(X, 13);
	unsigned long Temp3 = rotright(X, 22);

	unsigned long Temp4 = Temp1 ^ Temp2 ^Temp3;

	return Temp4;
}

unsigned long bSig1(unsigned long X)
{
	unsigned long Temp1 = rotright(X, 6);
	unsigned long Temp2 = rotright(X, 11);
	unsigned long Temp3 = rotright(X, 25);

	unsigned long Temp4 = Temp1 ^ Temp2 ^Temp3;

	return Temp4;
}

unsigned long rotright(unsigned long num, int shift)
{
	return (num >> shift) | (num << (32 - shift));//Circular right shift by n

}

unsigned long shfright(unsigned long num, int shift)
{
	return (num >> shift);

}

unsigned long ep0(unsigned long x)
{
	return (rotright(x, 2) ^ rotright(x, 13) ^ rotright(x, 22));
}

unsigned long ep1(unsigned long x)
{
	return (rotright(x, 6) ^ rotright(x, 11) ^ rotright(x, 25));
}


