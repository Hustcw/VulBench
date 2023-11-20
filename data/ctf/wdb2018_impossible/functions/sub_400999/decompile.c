unsigned __int64 sub_400999()
{
  char buf[2];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  puts("Ok, as u r bored, do something boring to make u more bored...");
  read(0, &unk_602080, 0x1000uLL);
  puts("Satisfied?y/n");
  read(0, buf, 2uLL);
  if ( buf[0] == 110 )
  {
    puts("You r troublesome...Why do this boring thing again!?");
    sub_400999();
  }
  return __readfsqword(0x28u) ^ v2;
}
