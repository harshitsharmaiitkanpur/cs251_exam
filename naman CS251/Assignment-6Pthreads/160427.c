#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <pthread.h>
#include <unistd.h>
#include <string.h>
#include <sys/time.h>
#include <ctype.h>
#include <math.h>

#define num_ac 10000
#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))

int active[10000]={0};

double Round(double var)
{
    double value = (int)(var * 100 + .5);
    return (double)(value / 100);
}

int min(int a,int b){
	int mini = (a<b)?a:b;
	return mini;
}

pthread_mutex_t lock;

typedef struct trans{
	int txn_no;
	int type;
	double amount;
	int ac1;
	int ac2;
}TRANS;

TRANS* newNode(){
	TRANS *temp = (TRANS *)malloc(sizeof(TRANS));
	return temp;
}

TRANS *record;
int *ac_no;
double *balance;

char *cptr;
static int dataptr;
int max_words=0;
int nwords=0;
int num_records=0;
void getwords(char *word[]){

	while(1){
		while(*cptr==' ' || *cptr=='\n')
			cptr++;

		if(*cptr == '\0')
			return;

		word[nwords++] = cptr;

		while(*cptr!=' ' && *cptr!='\0' && *cptr!='\n'){
			if(*cptr=='.'){
				cptr+=2;
				break;
			}
			cptr++;
		}

		if(nwords==max_words)
			return;
		*cptr++='\0';
	}
}

void *func(void *arg){
	int pointer;
	int *endptr=(int *)arg;
	
	int a1,a2,type;
	double amount,b1,b2;
	while(1){
		pthread_mutex_lock(&lock);
		if(dataptr>=*endptr){
			pthread_mutex_unlock(&lock);
			break;
		}

		if(active[record[dataptr].ac1-1001]==1 || (record[dataptr].ac2 !=0 && active[record[dataptr].ac2-1001]==1)){	
			pthread_mutex_unlock(&lock);
			continue;
		}

		a1=record[dataptr].ac1;
		a2=record[dataptr].ac2;
		amount=record[dataptr].amount;
		type=record[dataptr].type;
		b1=balance[a1-1001];
		active[a1-1001]=1;
		if(type==4){
			b2=balance[a2-1001];
			active[a2-1001]=1;
		}

		pointer=dataptr;
		dataptr++;
		pthread_mutex_unlock(&lock);

		switch(type){
			case 1:
				b1 += amount*0.99;
				break;
			case 2:
				b1 -= amount*1.01;
				break;
			case 3:
				b1 += b1*0.071;
				break;
			case 4:
				b1 -= amount*1.01;
				b2 += amount*0.99;
				break;
			default:
				break;
		}

		pthread_mutex_lock(&lock);
		balance[a1-1001]=b1;
		active[a1-1001]=0;
		if(type==4){
			balance[a2-1001]=b2;
			active[a2-1001]=0;
		}
		pthread_mutex_unlock(&lock);
	}
}

int main(int argc, char **argv){

	struct timeval s,e;
	/////////////////////////// Check Input ////////////////////////////
	if(argc != 5){
		printf("Not enough parameters");
		exit(-1);
	}

	int num_records=atoi(argv[3]);
	int num_threads=atoi(argv[4]);
	///////////////////////////////////////////////////////////////
	//////////////////////Read account file/////////////////////////


	ac_no=(int *)malloc(10000*sizeof(int));
	balance=(double *)malloc(10000*sizeof(double));
	int fd = open(argv[1], O_RDWR);
	if(fd<0){
		printf("File cannot open");
		exit(-1);
	}

	int size = lseek(fd,0,SEEK_END);
	lseek(fd,0,SEEK_SET);	//return  pointer to file start

	unsigned long bytes_read = 0;
	char *buff;
	char *cbuff;
	buff = malloc(size);

	do{
         unsigned long bytes;
         cbuff = buff + bytes_read;
         bytes = read(fd, cbuff, size - bytes_read);
         if(bytes < 0){
             perror("read");
             exit(-1);
         }
        bytes_read += bytes;
     }while(size != bytes_read);

    cbuff=buff+size;
    cptr=buff;

	max_words=2;
	for(int i=0;i<num_ac;i++){
		char *words[2];
		nwords=0;
		getwords(words);
		ac_no[i]=atoi(words[0]);
		balance[i]=atof(words[1]);
		cptr++;
	}

/*	for(int i=0;i<num_ac;i++)
		printf("ac_no %d | balance %f\n",ac_no[i],balance[i]);
*/
	free(buff);
	close(fd);

	///////////////////////////////////////////////////////
	///////////////Read transaction file////////////////////

	int fd2 = open(argv[2], O_RDWR);
	if(fd2<0){
		printf("File cannot open");
		exit(-1);
	}

	int size2 = lseek(fd2,0,SEEK_END);
	lseek(fd2,0,SEEK_SET);	//return  pointer to file start

	unsigned long bytes_read2 = 0;
	char *buff2;
	char *cbuff2;
	buff2 = malloc(size2);

	do{
         unsigned long bytes2;
         cbuff2 = buff2 + bytes_read2;
         bytes2 = read(fd2, cbuff2, size2 - bytes_read2);
         if(bytes2 < 0){
             perror("read");
             exit(-1);
         }
        bytes_read2 += bytes2;
     }while(size2 != bytes_read2);

    record=(TRANS *)malloc(num_records*sizeof(TRANS));

    cbuff2=buff2+size2;
    cptr=buff2;
	max_words=5;
	for(int i=0;i<num_records;i++){
		char *par[5];
		nwords=0;
		getwords(par);
		record[i].txn_no = atoi(par[0]);
		record[i].type = atoi(par[1]);
		record[i].amount = atof(par[2]);
		record[i].ac1 = atoi(par[3]);
		record[i].ac2 = atoi(par[4]);
		cptr++;
	}

//	for(int i=0;i<num_records;i++)
//		printf("No. %d | Type %d | Amount %f | Ac1 %d | Ac2 %d \n", record[i]->txn_no, record[i]->type, record[i]->amount, record[i]->ac1, record[i]->ac2);

	free(buff2);
	close(fd2);

	//////////////////////////  THREADING  ////////////////////////////

	pthread_mutex_init(&lock, NULL);
	
	gettimeofday(&s, NULL);

	int BLOCK_SIZE=num_records/num_threads;
	pthread_t threads[num_threads];

	int *ptr = &num_records;
	dataptr = 0;
	for(int i=0;i<num_threads;i++){
		if(pthread_create(&threads[i],NULL,func,ptr)!=0){
			perror("pthread_create");
			exit(-1);
		}
	}
	
	for(int j=0; j < num_threads; j++)
        	pthread_join(threads[j], NULL);

	for(int i=0;i<num_ac;i++)
		printf("%d %.2lf\n",ac_no[i], balance[i]);
	 gettimeofday(&e, NULL);
// 		printf("Time taken = %ld microsecs\n", TDIFF(s, e));

	return 0;
}
