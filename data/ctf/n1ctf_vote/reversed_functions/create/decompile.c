void create()
{
  int i;
  int v1;
  Vote *v2;

  for ( i = 0; i <= 15; ++i )
  {
    if ( !ptr[i] )
    {
      print("Please enter the name's size: ");
      v1 = read_int();
      if ( v1 > 0 && v1 <= 4096 )
      {
        v2 = (Vote *)malloc(v1 + 16);
        v2->count = 0LL;
        v2->time = time(0LL);
        print("Please enter the name: ");
        read_str(v2->name, v1);
        ptr[i] = v2;
      }
      return;
    }
  }
}