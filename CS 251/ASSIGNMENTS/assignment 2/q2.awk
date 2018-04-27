#!/usr/bin/gawk

BEGIN{

}

 {
   # if(NR == 1)   # nr gives us number of recordings
   # time1 = $1 
   split($3,parts1,".")
   split($5,ip,":")
   split(ip[1],parts2,".")



    

if( parts1[5] < parts2[5] )
{
      if(flag[$3ip[1]] != 1){
         time1[$3ip[1]]=$1
         flag[$3ip[1]]=1
      }
      time2[$3ip[1]]=$1
  
 arr[$3ip[1]]++
 A[$3ip[1]]++
 split($3,x,".")
 nameofA[$3ip[1]]=x[1]"."x[2]"."x[3]"."x[4]":"x[5]
       if($10 != "ack")
       {
          if($9 ~ /:/ )
          #retrans_A[$3ip[1]]++
          
         
            split($9,y,":")
            retrans_A[$3ip[1]] = retrans_A[$3ip[1]] + (y[2] - y[1])
         
       }

        if($8 == "seq")
     {
        
        if($9 ~ /:/ )
        #data_byteA[$3ip[1]]++
        
	{
         data_packA[$3ip[1]]++
         split($9,y,":")
         data_byteA[$3ip[1]] = data_byteA[$3ip[1]] + (y[2] - y[1])
        }
     }

}

else
{
     if(flag[ip[1]$3] != 1){
         time1[ip[1]$3]=$1
         flag[ip[1]$3]=1
 
     }
      time2[ip[1]$3]=$1

    arr[ip[1]$3]++
    B[ip[1]$3]++
    split($3,x,".")
    nameofB[ip[1]$3]=x[1]"."x[2]"."x[3]"."x[4]":"x[5]
            if($10 != "ack")
            {
               if($9 ~ /:/ )
              # retrans_B[ip[1]$3]++
               
              {
                split($9,y,":")
                retrans_B[ip[1]$3] = retrans_B[ip[1]$3] + (y[2] - y[1])
              }
            }

                if($8 == "seq")
          {
              
             if($9 ~ /:/ )
              #data_byteB[ip[1]$3]++
	     { 
              
                data_packB[ip[1]$3]++
                split($9,y,":")
                data_byteB[ip[1]$3] = data_byteB[ip[1]$3]
	}
          }
}

 }


END{




for(i in arr)
{
      split(time1[i],a,":")
      split(time2[i],b,":")
      time = (b[2] - a[2])*60 + (b[3] - a[3])


print "Connection (A = " nameofA[i] ", B = " nameofB[i] ")"
print "--------------------------------------------------------"
print " A -- > B"
print "#of packets (all) =" A[i]+0 "#of data packets =" data_packA[i]+0 "#Data (bytes) =" data_byteA[i]+0 "#Retransimitted (bytes) =" retrans_A[i]+0 "Throughput (bytes/sec) =" (data_byteA[i]-retransA[i]+0)/time
print " B -- > A"
print "#of packets (all) =" B[i]+0 "#of data packets = " data_packB[i]+0 "#Data (bytes) =" data_byteB[i]+0 "#Retransimitted (bytes) = " retransB[i]+0 "Throughput (bytes/sec) = " (data_byteB[i]-retransB[i]+0)/time
print "\n"
   }




}
