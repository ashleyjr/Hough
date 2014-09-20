#include "image.h"
#include <stdio.h>	

int main(){	
	FILE *in, *out;
	int data;
	int i,j;
	int im[x][y];
	
	
	
	// Load image matrix
	in = fopen("Lenna.dat","r");
	for(i=0;i<x;i++){
		for(j=0;j<y;j++){
			fscanf(in,"%d",&data);	
			im[i][j] = data;
		}
	}
	fclose(in);


	// Save image matrix
	out = fopen("Lenna.dat","w");
	for(i=0;i<x;i++){
		for(j=0;j<y;j++){
			fprintf(out,"%d\n\0",im[j][i]);
		}	
	}
	fclose(out);

	return 0;
}
