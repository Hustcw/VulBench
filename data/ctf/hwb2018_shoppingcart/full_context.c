struct Data
{
  char *field_0;
  __int64 field_8;
};

char byte_202088;
__int64 qword_202090;
__int64 qword_202098;
char byte_2020A0[20][8];
char *byte_202140[20];
Data *qword_2021E0[20];


void sub_9B0()
{
  __int64 v0;
  unsigned __int64 size;
  Data *v2;
  char s[24];
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  if ( (unsigned __int64)qword_202090 <= 0x13 )
  {
    puts("How long is your goods name?");
    fgets(s, 24, stdin);
    size = strtoul(s, 0LL, 0);
    v2 = (Data *)malloc(0x10uLL);
    v2->field_8 = 999LL;
    v2->field_0 = (char *)malloc(size);
    puts("What is your goods name?");
    v2->field_0[(int)read(0, v2->field_0, size) - 1] = 0;
    v0 = qword_202090++;
    qword_2021E0[v0] = v2;
  }
  else
  {
    puts("Your shopping cart is full now!");
  }
}

void __fastcall sub_AD0(__int64 a1)
{
  puts("You really don't need it?");
  free(qword_2021E0[a1]->field_0);
  free(qword_2021E0[a1]);
  qword_2021E0[a1] = 0LL;
}

void sub_B47()
{
  unsigned __int64 v0;
  char s[24];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  puts("Which goods that you don't need?");
  fgets(s, 24, stdin);
  v0 = strtoul(s, 0LL, 0);
  if ( v0 <= qword_202090 )
    sub_AD0(v0);
  else
    puts("That goods is out of your cart.");
}

void sub_BD9()
{
  unsigned __int64 v0;
  char s[24];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  puts("Which goods you need to modify?");
  fgets(s, 24, stdin);
  v0 = strtoul(s, 0LL, 0);
  printf("OK, what would you like to modify %s to?\n", qword_2021E0[v0]->field_0);
  qword_2021E0[v0]->field_0[read(0, qword_2021E0[v0]->field_0, 8uLL)] = 0;
}

void sub_CC7()
{
  unsigned __int64 v0;
  char s[24];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  do
  {
    while ( 1 )
    {
      while ( 1 )
      {
        while ( 1 )
        {
          puts("Now, buy buy buy!");
          fgets(s, 24, stdin);
          v0 = strtoul(s, 0LL, 0);
          if ( v0 != 2 )
            break;
          sub_B47();
        }
        if ( v0 > 2 )
          break;
        if ( v0 == 1 )
          sub_9B0();
      }
      if ( v0 != 3 )
        break;
      sub_BD9();
    }
  }
  while ( v0 != 4 );
}

void sub_D81()
{
  __int64 v0;
  Data *v1;

  if ( (unsigned __int64)qword_202098 <= 0x13 )
  {
    puts("I will give you $9999, but what's the  currency type you want, RMB or Dollar?");
    v1 = (Data *)malloc(0x10uLL);
    v1->field_8 = 9999LL;
    fgets(byte_2020A0[qword_202098], 8, stdin);
    v1->field_0 = (__int64)byte_2020A0[qword_202098];
    v0 = qword_202098++;
    byte_202140[v0] = (char *)v1;
  }
  else
  {
    puts("You already have enough money!");
  }
}

void sub_E48()
{
  puts("HHHaaa, You cannot remove any money!");
}

void sub_E5B()
{
  unsigned __int64 v0;
  char s[24];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  while ( 1 )
  {
    while ( 1 )
    {
      puts("EMMmmm, you will be a rich man!");
      fgets(s, 24, stdin);
      v0 = strtoul(s, 0LL, 0);
      if ( v0 != 2 )
        break;
      sub_E48();
    }
    if ( v0 == 3 )
      break;
    if ( v0 == 1 )
      sub_D81();
  }
}

__int64 __fastcall main(int a1, char **a2, char **a3)
{
  sub_E5B();
  sub_CC7();
  return 0LL;
}