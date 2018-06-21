/*
 *    - Use ALT versions of stdio routines:
 *
 *           Function                  Description
 *        ===============  =====================================
 *        alt_printf       Only supports %s, %x, and %c ( < 1 Kbyte)
 *        alt_putstr       Smaller overhead than puts with direct drivers
 *                         Note this function doesn't add a newline.
 *        alt_putchar      Smaller overhead than putchar with direct drivers
 *        alt_getchar      Smaller overhead than getchar with direct drivers
 *
 */

#include "sys/alt_stdio.h"
#include<system.h>
#include<io.h>
#include<unistd.h>
#include "sys/alt_dev.h"
#include "priv/alt_busy_sleep.h"
int main()
{ 
	char * input="";
	char count = 0;
	char cn='0';
	alt_u32 data[16] = {};
	alt_u32* memwrite = (alt_u32*)SHA256_MM_0_BASE;


for(;;)
{

	alt_putstr("Welcome to \"butlicker\", Type string:\n");


	  while((cn = alt_getchar() )!= '\n')
	  {
		  (*(input+count)) = cn;
		  count++;
	  }
	  alt_printf("size= %x \n",count);
	  alt_printf("mod4= %x \n",(count%4));
	  alt_printf("dataContaniers= %x \n",(count/4));

	  if((count%4) == 0)
	  {
	  for(int i = 0; i<(count/4);i++)
	  {
		  data[i] = (*(input+(i*4)))<<24;
		  data[i] |= (*(input+(i*4)+1))<<16;
		  data[i] |= (*(input+(i*4)+2))<<8;
		  data[i] |= (*(input+(i*4)+3));
	  }

	  }else
	  {
		  alt_u8 mod4 = (count%4);
		  alt_u8 j = 0;

		  for(j = 0; j<(count/4);j++)
		  {
			  data[j] = (*(input+(j*4)))<<24;
			  data[j] |= (*(input+(j*4)+1))<<16;
			  data[j] |= (*(input+(j*4)+2))<<8;
			  data[j] |= (*(input+(j*4)+3));
		  }

		  switch(mod4){
		  case 1:
			  data[j] = (*(input+(j*4)))<<24;
			  break;
		  case 2:
			  data[j] = (*(input+(j*4)))<<24;
			  data[j] |= (*(input+(j*4)+1))<<16;
			  break;
		  case 3:
			  data[j] = (*(input+(j*4)))<<24;
			  data[j] |= (*(input+(j*4)+1))<<16;
			  data[j] |= (*(input+(j*4)+2))<<8;
			  break;

		  }


	  }
	  for(int i = 0; i<16;i++)
	  {
			  //alt_printf("%x\n",data[i]);
		  	 *(memwrite+(i)) = data[i];

	  }
	  count = 0;
	  //*input = "";

	  usleep(100);


	  alt_u32 val;
	  for(int i = 0; i<8;i++)
	  {

		  val = *(memwrite+i);
		  alt_printf("%x \n",val);
		  val = 0;


	  }



}

  return 0;
}

