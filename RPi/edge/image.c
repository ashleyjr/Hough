#include "image.h"
#include <stdio.h>	
#include <math.h>

int diff(int a,int b){
	if(a > b)
		return a - b;
	else
		return b - a;
}

int main(){	
	FILE *in, *out;
	unsigned int   data,i,j,one,two;
	unsigned char  im[width][height];
	   
	// Load image matrix
	in = fopen("CamIn.dat","r");
	for(i=0;i<width;i++){
		for(j=0;j<height;j++){
			fscanf(in,"%d",&data);	
			im[i][j] = data;
		}
	}
	fclose(in);


   // do the op
	for(i=0;i<width-2;i++){
		for(j=0;j<height;j++){
        
         one = im[i][j];
         two = im[i+2][j];
         if(one > two)     im[i][j] =  one - two;
         else              im[i][j] =  two - one;
		}	
	}


   // Save image matrix
	out = fopen("CamOut.dat","w");
	for(i=0;i<width;i++){
		for(j=0;j<height;j++){
			fprintf(out,"%d\n\0",im[i][j]);
		}	
	}
	fclose(out);

	return 0;
}
