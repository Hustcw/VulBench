void sub_400C2A()
{
  unsigned int v0;
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  puts("Input the user id:");
  v0 = 0;
  _isoc99_scanf("%d", &v0);
  if ( v0 > 5 )
  {
    puts("Wrong id!");
  }
  else if ( qword_602040[v0] )
  {
    free(*(void **)qword_602040[v0]);
    free((void *)qword_602040[v0]);
    puts("Delete success!");
  }
  else
  {
    puts("No such user!");
  }
}