int sub_400BC2()
{
  __int64 v0;
  int i;
  int v3;
  void *v4;

  if ( *(_QWORD *)(qword_6020A8 + 8) < *(_QWORD *)qword_6020A8 )
  {
    for ( i = 0; ; ++i )
    {
      v0 = *(_QWORD *)qword_6020A8;
      if ( i >= *(_QWORD *)qword_6020A8 )
        break;
      if ( !*(_QWORD *)(qword_6020A8 + 24LL * i + 16) )
      {
        printf("Length of new note: ");
        v3 = sub_40094E();
        if ( v3 > 0 )
        {
          if ( v3 > 4096 )
            v3 = 4096;
          v4 = malloc((128 - v3 % 128) % 128 + v3);
          printf("Enter your note: ");
          sub_40085D((__int64)v4, v3);
          *(_QWORD *)(qword_6020A8 + 24LL * i + 16) = 1LL;
          *(_QWORD *)(qword_6020A8 + 24LL * i + 24) = v3;
          *(_QWORD *)(qword_6020A8 + 24LL * i + 32) = v4;
          ++*(_QWORD *)(qword_6020A8 + 8);
          LODWORD(v0) = puts("Done.");
        }
        else
        {
          LODWORD(v0) = puts("Invalid length!");
        }
        return v0;
      }
    }
  }
  else
  {
    LODWORD(v0) = puts("Unable to create new note.");
  }
  return v0;
}
