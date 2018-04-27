#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <fcntl.h>
#include <pthread.h>
#include <string.h>

#define THREAD 1
#define MAX_THREADS 64

pthread_mutex_t lock;
pthread_mutex_t lock_account[10000];
static double account[10000];
static char *dataptr;


void modify_acc(char *txn,double *account)
{
    int txn_seq,txn_type,acc_1,acc_2;
    double txn_amt;
    sscanf( txn,"%d %d %lf %d %d ",&txn_seq,&txn_type,&txn_amt,&acc_1,&acc_2);
   
    
    if(txn_type==1)
    {
      double add = 0.99*txn_amt;
      pthread_mutex_lock(&lock_account[acc_1-1001]);
      account[acc_1-1001] = account[acc_1-1001] + add;
      pthread_mutex_unlock(&lock_account[acc_1-1001]);
    }   
    else if(txn_type==2)
    {
      double sub=1.01*txn_amt;
      pthread_mutex_lock(&lock_account[acc_1-1001]);
      account[acc_1-1001] = account[acc_1-1001] - sub;
      pthread_mutex_unlock(&lock_account[acc_1-1001]);
    }
    else if(txn_type==3)
    {
      pthread_mutex_lock(&lock_account[acc_1-1001]);
      account[acc_1-1001] = account[acc_1-1001] + 0.071*account[acc_1-1001];
      pthread_mutex_unlock(&lock_account[acc_1-1001]);
    }
    else if(txn_type==4)
    {
        double serv= 0.01*txn_amt;
        pthread_mutex_lock(&lock_account[acc_1-1001]);
        account[acc_1-1001] = account[acc_1-1001] - txn_amt - serv;
        pthread_mutex_unlock(&lock_account[acc_1-1001]);
        
        pthread_mutex_lock(&lock_account[acc_2-1001]);
        account[acc_2-1001] = account[acc_2-1001] + txn_amt - serv;
        pthread_mutex_unlock(&lock_account[acc_2-1001]);
    }

}

void *hashit(void *arg)
{
  char *cptr;
  char *endptr = (char *)arg;
  int len;
  char pre_txn[250];

  while(1)
  {
     pthread_mutex_lock(&lock);
     if(dataptr >= endptr)
     {
           pthread_mutex_unlock(&lock);
           break;
     }
     cptr=dataptr;
     dataptr=strchr(cptr,'\n');
     len = (int)(dataptr-cptr);
     strncpy(pre_txn,cptr,len);
     pre_txn[len] = '\0';
     dataptr++;
     pthread_mutex_unlock(&lock);
     modify_acc(pre_txn,account);
  }
 pthread_exit(NULL);
}

int main(int argc, char **argv){
  int num_threads,num_txn;
  if(argc !=5)
             printf("not enough parameters\n");

    num_txn = atoi(argv[3]);
    if(num_txn <=0)
            printf("invalid num txn\n");

    num_threads = atoi(argv[4]);
    if(num_threads <=0 || num_threads > MAX_THREADS){
            printf("invalid num of threads\n");
    }
    FILE *file;
    file=fopen(argv[1],"r");
    if(file==NULL)
      printf("Can't open file\n");
    else
    {
      char acc_id[300],acc_bal[300];
      int status,id;
      double balance;
      do
      {
         status = fscanf(file, "%s", &acc_id);
         status = fscanf(file, "%s", &acc_bal);
         balance = atof(acc_bal);
         id = atoi(acc_id);
         account[id-1001] = balance;
      }while(status!=-1);
    }
    fclose(file);


     int fd, ctr;
     unsigned long size, bytes_read = 0;
     char *buff, *cbuff;
     pthread_t threads[num_threads];

   
     fd = open(argv[2], O_RDONLY);
     if(fd < 0){
           printf("Can not open file\n");
           exit(-1);
     } 
    
    size = lseek(fd, 0, SEEK_END);
    if(size <= 0){
           perror("lseek");
           exit(-1);
    }
    
    if(lseek(fd, 0, SEEK_SET) != 0){
           perror("lseek");
           exit(-1);
    }
   
    buff = malloc(size);
    if(!buff){
           perror("mem");
           exit(-1);
    }   
   /*Read the complete file into buff
     XXX Better implemented using mmap */
   
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
   
     dataptr = buff;
     cbuff = buff + size;
     pthread_mutex_init(&lock, NULL);
     pthread_mutex_init(&lock_account, NULL);

     for(ctr=0; ctr < num_threads; ++ctr){
        if(pthread_create(&threads[ctr], NULL, hashit, cbuff) != 0){
              perror("pthread_create");
              exit(-1);
        }
     }
     for(ctr=0; ctr < num_threads; ++ctr)
            pthread_join(threads[ctr], NULL);
     free(buff);
     close(fd);
      for(int i = 0;i<10000;i++){
        printf("%d %.2f\n",i+1001,account[i]);
    }

}