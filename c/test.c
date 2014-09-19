#include <stdio.h>	

int main(){	
	FILE *in, *out;
	int data;
	int i,j;
	int im[20][20];
	
	in = fopen("Lenna.dat","r");
		
	
	// Load image matrix
	i = 0;
	j = 0;
	while(1){	
		fscanf(in,"%d",&data);	
		im[i][j] = data;
		printf(" %d , %d : %d \n",i,j,im[i][j]);

		if((19 == i) && (19 == j)){
			break;
		}
		i++;
		if(i == 20){
			i = 0;
			j++;
		}
	}
	fclose(in);


	out = fopen("LennaOut.dat","w");
	
	for(i=0;i<20;i++){
		for(j=0;j<20;j++){
			fputs(im[i][j],out);
		}	
	}

	fclose(out);

	return 0;
}
