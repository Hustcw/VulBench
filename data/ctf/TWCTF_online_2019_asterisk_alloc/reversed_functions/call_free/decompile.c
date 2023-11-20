void __fastcall call_free()
{
  char v0; // [rsp+7h] [rbp-9h] BYREF
  unsigned __int64 v1; // [rsp+8h] [rbp-8h]

  v1 = __readfsqword(0x28u);
  printf("Which: ");
  __isoc99_scanf("%c", &v0);
  getchar();
  switch ( v0 )
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
}