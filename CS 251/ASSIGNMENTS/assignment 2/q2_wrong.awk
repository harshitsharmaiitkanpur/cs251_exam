#!/usr/bin/gawk

BEGIN{

}

{
    if(NR == 1)   # nr gives us number of recordings
    time1 = $1 

    arr[$3 + $5]++

if( $3 < $5 )
{

 A[$3 + $5]++
 split($3,x,".")
 nameofA[$3 + $5]=x[1]"."x[2]"."x[3]"."x[4]":"x[5]
       if($10 != "ack")
       {
          if($9 !~ /:/ )
          retrans_A[$3 + $5]++
          else
         {
            split($9,y,":")
            retrans_A[$3 + $5] = retrans_A[$3 + $5] + (y[2] - y[1])
         }
       }

       if($8 == "seq")
     {
        data_packA[$3 + $5]++
        if($9 !~ /:/ )
        data_byteA[$3 + $5]++
        else
       {
         split($9,y,":")
         data_byteA[$3 + $5] = data_byteA[$3 + $5] + (y[2] - y[1])
       }
     }

}

else
{
    B[$3 + $5]++
    split($3,x,".")
    nameofB[$3 + $5]=x[1]"."x[2]"."x[3]"."x[4]":"x[5]
            if($10 != "ack")
            {
               if($9 !~ /:/ )
               retrans_B[$3 + $5]++
               else
              {
                split($9,y,":")
                retrans_B[$3 + $5] = retrans_B[$3 + $5] + (y[2] - y[1])
              }
            }

             if($8 == "seq")
          {
              data_packB[$3 + $5]++
              if($9 !~ /:/ )
              data_byteB[$3 + $5]++
              else
             {
                split($9,y,":")
                data_byteB[$3 + $5] = data_byteB[$3 + $5]
             }
          }

}

}


END{
time2=$1
split(time1,a,":")
split(time2,b,":")
time = (b[2] - a[2])*60 + (b[3] - a[3])

for(i in arr)
{

print "Connection (A = " nameofA[i] ", B = " nameofB[i] ")"
print "--------------------------------------------------------"
print " A -- > B"
print A[i]+0 " " data_packA[i]+0 " " data_byteA[i]+0 " " retrans_A[i]+0 " " (data_byteA[i]-retransA[i]+0)/time
print " B -- > A"
print  B[i]+0 " " data_packB[i]+0 " " data_byteB[i]+0 " " retransB[i]+0 " " (data_byteB[i]-retransB[i]+0)/time
}



}
