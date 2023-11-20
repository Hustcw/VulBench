unsigned __int64 call_free()
{
  char v1;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  printf("Which: ");
  __isoc99_scanf("%c", &v1);
  getchar();
  switch ( v1 )
  {
    case 'm':
      free(ptr_m);
      break;
    case 'c':
      free(ptr_c);
      break;
    case 'r':
      free(ptr_r);
      break;
    default:
      puts("Invalid choice");
      break;
  }
  return __readfsqword(0x28u) ^ v2;
}
