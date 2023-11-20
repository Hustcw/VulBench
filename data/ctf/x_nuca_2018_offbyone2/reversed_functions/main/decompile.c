void __fastcall __noreturn main(int a1, char **a2, char **a3)
{
  int v3;

  while ( 1 )
  {
    __isoc99_scanf("%d", &v3);
    switch ( v3 )
    {
      case 2:
        sub_D73();
        break;
      case 3:
        sub_E37();
        break;
      case 1:
        sub_C0E();
        break;
      default:
        puts("invalid~");
        break;
    }
  }
}