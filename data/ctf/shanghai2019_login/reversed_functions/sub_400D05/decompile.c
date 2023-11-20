void sub_400D05()
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
    puts("Input new pass:");
    read(0, *(void **)qword_602040[v0], *(int *)(qword_602040[v0] + 16LL));
  }
  else
  {
    puts("No such user!");
  }
}