#!/usr/bin/gawk
BEGIN{
   FS=""
   cnt_comment=0
   cnt_strings=0
   var_comment=0
   var_strings=0
   i=1
}

{
 if( var_comment == 0 && var_strings == 0 )
  {
    if( $0 ~ /\/\// )
    cnt_comment++
 
    if( $0 ~ /\/\*/ )
    {
      if( $0 !~ /\*\/$/ )
      {
       cnt_comment++
       var_comment = 1
      }
      else
      {
       cnt_comment++
       var_comment = 0
      }
    }
  }
 if( var_comment == 1 )
  {
      if( $0 ~ /\/\*/ )
      {
         cnt_comment++
         var_comment = 0
      }
      else
      {
         cnt_comment++
         var_comment = 0
      }
  }
  
 if( var_strings == 0 )
  {
    if( $0 ~ /\"/ )
  {
      if( $0 !~ /\"/ )
    {
      var_strings = 1
    }
      else
    {
      cnt_strings++
      var_strings = 0
    }
  }
  }    

 if( var_strings == 1 )
 {
     if( $0 ~ /\"/ )
   {
      cnt_strings++
      var_strings = 0
   }
     else
       var_strings = 1
 }   

}
END{
 printf("%d %d",cnt_comment,cnt_strings)
 #printf("%d %d",2,3)


}

 
