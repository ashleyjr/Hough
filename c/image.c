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
	int data;
	int i,j;
	int im[width][height];
	int im_new[width][height];	
	int max,min	;
	int new_max,new_min;
	
	// Load image matrix
	in = fopen("LennaIn.dat","r");
	for(i=0;i<width;i++){
		for(j=0;j<height;j++){
			fscanf(in,"%d",&data);	
			im[i][j] = data;
		}
	}
	fclose(in);

	
	min = 255;
	max = 0;
	for(i=1;i<(width-1);i++){
		for(j=1;j<(height-1);j++){
			//im_new[i][j] = 
			//	// horizontal 1
			//	im[i-1][j-1] + (2*im[i][j-1]) + im[i+1][j-1] - 
			//	im[i-1][j+1] - (2*im[i][j+1]) - im[i+1][j+1] +
			//	// vertical
			//		im[i-1][j-1] -			im[i+1][j-1]	+
			//	(2*	im[i-1][j]	)- 	 	(2*	im[i+1][j]) 	+
			//		im[i-1][j+1] -	 		im[i+1][j+1];
						
			im_new[i][j] = 
				// horizontal 1
				diff(im[i-1][j-1], im[i-1][j+1]) + 
				diff((2*im[i][j-1]), (2*im[i][j+1])) +
				diff(im[i+1][j-1],im[i+1][j+1]);
				
		//	im_new[i][j] = 	
		//		// Vertical		
		//		im[i-1][j-1] - im[i+1][j-1] + 
		//		(2*im[i-1][j])  - (2*im[i+1][j]) +
		//		im[i-1][j+1] - im[i+1][j+1];
		

			//im_new[i][j] = diff(im[i][j],im[i][j-1]) + diff(im[i][j],im[i-1][j]);
			if(im_new[i][j] > max){
				max = im_new[i][j];
			}
			if(im_new[i][j] < min){
				min = im_new[i][j];
			}
		}	
	}
	printf("%d,%d\n",max,min);	

	new_max = 0;
	new_min = max;
	max = max - min;	// Max now contains difference
	for(i=1;i<(width-1);i++){
		for(j=1;j<(height-1);j++){
					
			im_new[i][j] =  (int) (((im_new[i][j] - min)*255)/(max));			
		
			if(im_new[i][j] > new_max){
				new_max = im_new[i][j];
			}
			if(im_new[i][j] < new_min){
				new_min = im_new[i][j];
			}
		}	
	}

	printf("%d,%d\n",new_max,new_min);

	// Save image matrix
	out = fopen("LennaOut.dat","w");
	for(i=0;i<width;i++){
		for(j=0;j<height;j++){
			fprintf(out,"%d\n\0",im_new[i][j]);
		}	
	}
	fclose(out);

	return 0;
}
