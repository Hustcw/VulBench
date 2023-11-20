unsigned __int64 sub_400C2A()
{
  unsigned int v1;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  puts("Input the user id:");
  v1 = 0;
  _isoc99_scanf("%d", &v1);
  if ( v1 > 5 )
  {
    puts("Wrong id!");
  }
  else if ( qword_602040[v1] )
  {
    free(*(void **)qword_602040[v1]);
    free((void *)qword_602040[v1]);
    puts("Delete success!");
  }
  else
  {
    puts("No such user!");
  }
  return __readfsqword(0x28u) ^ v2;
}
