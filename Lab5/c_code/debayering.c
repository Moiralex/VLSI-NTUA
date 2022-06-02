#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]){

	int ** Bayer_values, **Green, **Blue, **Red;
	FILE* file;
	int N, i, j, read_value, line_odd_even=0, pixel_odd_even=0;


	if(argc>2) {
		file = fopen(argv[1], "r");
        N=atoi(argv[2]);
	}
	else{
		printf ("dwse arxeio kai N\n");
		return 0;
	}

	if (NULL == file) {
        printf("file can't be opened \n");
    }


    Bayer_values = (int**)malloc((N+2) * sizeof(int*));
    Green = (int**)malloc((N+1) * sizeof(int*));
    Blue = (int**)malloc((N+1) * sizeof(int*));
    Red = (int**)malloc((N+1) * sizeof(int*));
    for (i = 0; i < N+2; i++){
        Bayer_values[i] = (int*)malloc((N+2) * sizeof(int));
        if(i < N+1){
	    	Green[i] = (int*)malloc((N+1) * sizeof(int));
		    Blue[i] = (int*)malloc((N+1) * sizeof(int));
		    Red[i] = (int*)malloc((N+1) * sizeof(int));
    	}
    }

    for(i=0; i < N+1; i++){
    	Bayer_values[0][i] = 0;
    	Bayer_values[i][0] = 0;
    	Bayer_values[N+1][i] = 0;
    	Bayer_values[i][N+1] = 0;
    }

    for(i=1; i < N+1; i++){
    	for(j=1; j < N+1; j++){
	    	fscanf (file, "%d", &read_value); 
	    	Bayer_values[i][j] = read_value;
	    }
    }
    
    fclose (file); 
    /////////////////reading ends

    /////////////////calculation begins
    for(i=1; i < N+1; i++){
    	for(j=1; j < N+1; j++){
	    	if(line_odd_even == 0){ //grammes 0,2,...(green and blue)
	    		if(pixel_odd_even == 0){ //green
		    		Green[i][j] = Bayer_values[i][j];
		    		Blue[i][j] = (Bayer_values[i][j-1]+Bayer_values[i][j+1])/2;
		    		Red[i][j] = (Bayer_values[i-1][j]+Bayer_values[i+1][j])/2;
		    	}
		    	else{	//blue
		    		Green[i][j] = (Bayer_values[i][j-1]+Bayer_values[i][j+1]+Bayer_values[i-1][j]+Bayer_values[i+1][j])/4;
		    		Blue[i][j] = Bayer_values[i][j];
		    		Red[i][j] = (Bayer_values[i-1][j-1]+Bayer_values[i-1][j+1]+Bayer_values[i+1][j-1]+Bayer_values[i+1][j+1])/4;
		    	}
	    	}
	    	else{	//grammes 1,3,...(green and red)
	    		if(pixel_odd_even == 0){ //red
		    		Green[i][j] = (Bayer_values[i][j-1]+Bayer_values[i][j+1]+Bayer_values[i-1][j]+Bayer_values[i+1][j])/4;
		    		Blue[i][j] = (Bayer_values[i-1][j-1]+Bayer_values[i-1][j+1]+Bayer_values[i+1][j-1]+Bayer_values[i+1][j+1])/4;
		    		Red[i][j] = Bayer_values[i][j];
		    	} 
		    	else{ //green
		    		Green[i][j] = Bayer_values[i][j];
		    		Blue[i][j] = (Bayer_values[i-1][j]+Bayer_values[i+1][j])/2;
		    		Red[i][j] = (Bayer_values[i][j-1]+Bayer_values[i][j+1])/2;
		    	}
	    	}
	    	pixel_odd_even = (pixel_odd_even + 1)%2;
	    }
	    line_odd_even = (line_odd_even + 1)%2;
    }

    ////////////end of calculations

    /////////////print into files

    file = fopen("red.txt","w");

	if(file == NULL)
	{
		printf("Error!");   
		exit(1);             
	}

	for(i=1; i < N+1; i++){
    	for(j=1; j < N+1; j++){
	    	fprintf(file,"%d ", Red[i][j]); 
	    }
	    fprintf(file,"\n"); 
    }

    fclose (file); 

    file = fopen("blue.txt","w");

	if(file == NULL)
	{
		printf("Error!");   
		exit(1);             
	}

    for(i=1; i < N+1; i++){
    	for(j=1; j < N+1; j++){
	    	fprintf(file,"%d ", Blue[i][j]); 
	    }
	    fprintf(file,"\n"); 
    }

    fclose (file); 

    file = fopen("green.txt","w");

	if(file == NULL)
	{
		printf("Error!");   
		exit(1);             
	}

    for(i=1; i < N+1; i++){
    	for(j=1; j < N+1; j++){
	    	fprintf(file,"%d ",	Green[i][j]);
	    }
	    fprintf(file,"\n"); 
    }

    fclose (file); 
}