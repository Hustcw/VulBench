char unk_202060[0x200]; // weak
char byte_202260; // weak

__int64 qword_202040; // weak
char byte_202049; // weak
char byte_202048; // weak
unsigned __int64 sub_AFE()
{
  char v1[72]; // [rsp+0h] [rbp-58h] BYREF
  unsigned __int64 v2; // [rsp+48h] [rbp-10h]

  v2 = __readfsqword(0x28u);
  strcpy(v1, "(F)ormat String Bug\n(A)rbitrary Write\n(S)tack Overflow\n(E)xit\n");
  puts(v1);
  _printf_chk(1LL, (__int64)"Your choice: ");
  return __readfsqword(0x28u) ^ v2;
}

__int64 __fastcall sub_BC6(_BYTE *a1, unsigned int a2)
{
  _BYTE *v2; // rbp
  unsigned int v3; // ebx
  char buf; // [rsp+7h] [rbp-31h] BYREF
  unsigned __int64 v6; // [rsp+8h] [rbp-30h]

  v6 = __readfsqword(0x28u);
  if ( a2 )
  {
    v2 = a1;
    v3 = 0;
    while ( 1 )
    {
      read(0, &buf, 1uLL);
      if ( buf == 10 || !buf )
        break;
      ++v3;
      *v2++ = buf;
      if ( a2 == v3 )
        goto LABEL_7;
    }
    a1[v3] = 0;
    return v3;
  }
  else
  {
LABEL_7:
    a1[a2 - 1] = 0;
    return a2;
  }
}

int sub_C62()
{
  if ( byte_202260 )
    return puts("ain't it cool, bye now");
  byte_202260 = 1;
  read(0, unk_202060, 0x200uLL);
  return _printf_chk(1LL, &unk_202060);
}

unsigned __int64 sub_CB5()
{
  char v1[40]; // [rsp+0h] [rbp-38h] BYREF
  unsigned __int64 v2; // [rsp+28h] [rbp-10h]

  v2 = __readfsqword(0x28u);
  if ( byte_202049 )
  {
    puts("ain't it cool, bye now");
  }
  else
  {
    byte_202049 = 1;
    sub_BC6(v1, 0x200u);
  }
  return __readfsqword(0x28u) ^ v2;
}

int sub_D0E()
{
  int result; // eax

  if ( byte_202048 )
    return puts("ain't it cool, bye now");
  byte_202048 = 1;
  _isoc99_scanf("%llu", &qword_202040);
  result = qword_202040;
  *(_QWORD *)qword_202040 = 0x45524F5453475542LL;
  return result;
}

void __fastcall __noreturn main(__int64 a1, char **a2, char **a3)
{
  char v3[8]; // [rsp+0h] [rbp-18h] BYREF
  unsigned __int64 v4; // [rsp+8h] [rbp-10h]

  v4 = __readfsqword(0x28u);
  while ( 1 )
  {
    sub_AFE();
    read(0, v3, 2uLL);
    if ( v3[0] == 69 )
      break;
    if ( v3[0] > 69 )
    {
      if ( v3[0] == 70 )
      {
        sub_C62();
      }
      else if ( v3[0] == 83 )
      {
        sub_CB5();
      }
    }
    else if ( v3[0] == 65 )
    {
      sub_D0E();
    }
  }
  exit(0);
}