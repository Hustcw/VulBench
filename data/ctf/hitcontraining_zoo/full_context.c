
struct VirtualTable
{
  void *speak;
  void *info;
};

struct Animal
{
  VirtualTable **virtual_table;
  char data[24];
  __int64 a;
};

__int64 (__fastcall *off_403120[2])(Cat *__hidden this) = { &Cat::speak, &Cat::info }; // weak
__int64 (__fastcall *off_403140[2])(Dog *__hidden this) = { &Dog::speak, &Dog::info }; // weak
__int64 (__fastcall *off_403160[2])(Animal *__hidden this) = { &Animal::speak, &Animal::info }; // weak
char edata[7]; // weak
char nameofzoo[112]; // weak
_QWORD animallist[3]; // weak

__int64 menu(void)
{
  __int64 v0; // rax
  __int64 v1; // rax
  __int64 v2; // rax
  __int64 v3; // rax
  __int64 v4; // rax
  __int64 v5; // rax
  __int64 v6; // rax
  __int64 v7; // rax

  v0 = std::operator<<<std::char_traits<char>>(&std::cout, "*********************************");
  std::ostream::operator<<(v0, &std::endl<char,std::char_traits<char>>);
  v1 = std::operator<<<std::char_traits<char>>(&std::cout, " 1. Add a dog                    ");
  std::ostream::operator<<(v1, &std::endl<char,std::char_traits<char>>);
  v2 = std::operator<<<std::char_traits<char>>(&std::cout, " 2. Add a cat                    ");
  std::ostream::operator<<(v2, &std::endl<char,std::char_traits<char>>);
  v3 = std::operator<<<std::char_traits<char>>(&std::cout, " 3. Listen a animal              ");
  std::ostream::operator<<(v3, &std::endl<char,std::char_traits<char>>);
  v4 = std::operator<<<std::char_traits<char>>(&std::cout, " 4. Show a animal info           ");
  std::ostream::operator<<(v4, &std::endl<char,std::char_traits<char>>);
  v5 = std::operator<<<std::char_traits<char>>(&std::cout, " 5. Remove a animal              ");
  std::ostream::operator<<(v5, &std::endl<char,std::char_traits<char>>);
  v6 = std::operator<<<std::char_traits<char>>(&std::cout, " 6. Exit                         ");
  std::ostream::operator<<(v6, &std::endl<char,std::char_traits<char>>);
  v7 = std::operator<<<std::char_traits<char>>(&std::cout, "*********************************");
  return std::ostream::operator<<(v7, &std::endl<char,std::char_traits<char>>);
}

void adddog(void)
{
  Animal *v0; // rbx
  int v1; // [rsp+Ch] [rbp-74h] BYREF
  Animal *v2; // [rsp+10h] [rbp-70h] BYREF
  Animal *v3; // [rsp+18h] [rbp-68h]
  char v4[32]; // [rsp+20h] [rbp-60h] BYREF
  char v5[40]; // [rsp+40h] [rbp-40h] BYREF
  unsigned __int64 v6; // [rsp+68h] [rbp-18h]

  v6 = __readfsqword(0x28u);
  std::string::basic_string(v4);
  std::operator<<<std::char_traits<char>>(&std::cout, "Name : ");
  std::operator>><char>((__int64)edata, (__int64)v4);
  std::operator<<<std::char_traits<char>>(&std::cout, "Weight : ");
  std::istream::operator>>(edata, &v1);
  std::string::basic_string((__int64)v5, (__int64)v4);
  v0 = (Animal *)operator new(0x28uLL);
  Dog::Dog(v0, v5, v1);
  v3 = v0;
  std::string::~string(v5);
  v2 = v3;
  std::vector<Animal *>::push_back((__int64)animallist, (__int64 *)&v2);
  std::string::~string(v4);
}

void addcat(void)
{
  Animal *v0; // rbx
  int v1; // [rsp+Ch] [rbp-74h] BYREF
  Animal *v2; // [rsp+10h] [rbp-70h] BYREF
  Animal *v3; // [rsp+18h] [rbp-68h]
  char v4[32]; // [rsp+20h] [rbp-60h] BYREF
  char v5[40]; // [rsp+40h] [rbp-40h] BYREF
  unsigned __int64 v6; // [rsp+68h] [rbp-18h]

  v6 = __readfsqword(0x28u);
  std::string::basic_string(v4);
  std::operator<<<std::char_traits<char>>(&std::cout, "Name : ");
  std::operator>><char>((__int64)edata, (__int64)v4);
  std::operator<<<std::char_traits<char>>(&std::cout, "Weight : ");
  std::istream::operator>>(edata, &v1);
  std::string::basic_string((__int64)v5, (__int64)v4);
  v0 = (Animal *)operator new(0x28uLL);
  Cat::Cat(v0, v5, v1);
  v3 = v0;
  std::string::~string(v5);
  v2 = v3;
  std::vector<Animal *>::push_back((__int64)animallist, (__int64 *)&v2);
  std::string::~string(v4);
}

unsigned __int64 remove(void)
{
  __int64 v0; // rax
  unsigned __int64 v1; // rbx
  __int64 v2; // rax
  void **v3; // rax
  __int64 v4; // rbx
  __int64 v5; // rax
  unsigned int v7; // [rsp+Ch] [rbp-24h] BYREF
  __int64 v8; // [rsp+10h] [rbp-20h] BYREF
  unsigned __int64 v9; // [rsp+18h] [rbp-18h]

  v9 = __readfsqword(0x28u);
  if ( std::vector<Animal *>::size(animallist) )
  {
    std::operator<<<std::char_traits<char>>(&std::cout, "index of animal : ");
    std::istream::operator>>(edata, &v7);
    v1 = v7;
    if ( v1 < std::vector<Animal *>::size(animallist) )
    {
      v3 = (void **)std::vector<Animal *>::operator[](animallist, v7);
      operator delete(*v3);
      v4 = v7;
      v8 = std::vector<Animal *>::begin(animallist);
      v5 = __gnu_cxx::__normal_iterator<Animal **,std::vector<Animal *>>::operator+(&v8, v4);
      std::vector<Animal *>::erase((__int64)animallist, v5);
    }
    else
    {
      v2 = std::operator<<<std::char_traits<char>>(&std::cout, "out of bound !");
      std::ostream::operator<<(v2, &std::endl<char,std::char_traits<char>>);
    }
  }
  else
  {
    v0 = std::operator<<<std::char_traits<char>>(&std::cout, "no any animal!");
    std::ostream::operator<<(v0, &std::endl<char,std::char_traits<char>>);
  }
  return __readfsqword(0x28u) ^ v9;
}

void showinfo(void)
{
  __int64 v0; // rax
  unsigned __int64 v1; // rbx
  __int64 v2; // rax
  Animal *v3; // rax
  unsigned int v4; // [rsp+4h] [rbp-1Ch] BYREF
  unsigned __int64 v5; // [rsp+8h] [rbp-18h]

  v5 = __readfsqword(0x28u);
  if ( std::vector<Animal *>::size(animallist) )
  {
    std::operator<<<std::char_traits<char>>(&std::cout, "index of animal : ");
    std::istream::operator>>(edata, &v4);
    v1 = v4;
    if ( v1 < std::vector<Animal *>::size(animallist) )
    {
      v3 = (Animal *)std::vector<Animal *>::operator[](animallist, v4);
      ((void (__fastcall *)(VirtualTable **))(*v3->virtual_table)->info)(v3->virtual_table);
    }
    else
    {
      v2 = std::operator<<<std::char_traits<char>>(&std::cout, "out of bound !");
      std::ostream::operator<<(v2, &std::endl<char,std::char_traits<char>>);
    }
  }
  else
  {
    v0 = std::operator<<<std::char_traits<char>>(&std::cout, "no any animal!");
    std::ostream::operator<<(v0, &std::endl<char,std::char_traits<char>>);
  }
}

void listen(void)
{
  __int64 v0; // rax
  unsigned __int64 v1; // rbx
  __int64 v2; // rax
  Animal *v3; // rax
  unsigned int v4; // [rsp+4h] [rbp-1Ch] BYREF
  unsigned __int64 v5; // [rsp+8h] [rbp-18h]

  v5 = __readfsqword(0x28u);
  if ( std::vector<Animal *>::size(animallist) )
  {
    std::operator<<<std::char_traits<char>>(&std::cout, "index of animal : ");
    std::istream::operator>>(edata, &v4);
    v1 = v4;
    if ( v1 < std::vector<Animal *>::size(animallist) )
    {
      v3 = (Animal *)std::vector<Animal *>::operator[](animallist, v4);
      (**(void (__fastcall ***)(VirtualTable **))v3->virtual_table)(v3->virtual_table);
    }
    else
    {
      v2 = std::operator<<<std::char_traits<char>>(&std::cout, "out of bound !");
      std::ostream::operator<<(v2, &std::endl<char,std::char_traits<char>>);
    }
  }
  else
  {
    v0 = std::operator<<<std::char_traits<char>>(&std::cout, "no any animal!");
    std::ostream::operator<<(v0, &std::endl<char,std::char_traits<char>>);
  }
}

int __cdecl main(int argc, const char **argv, const char **envp)
{
  __int64 v3; // rax
  int v5; // [rsp+4h] [rbp-Ch] BYREF
  unsigned __int64 v6; // [rsp+8h] [rbp-8h]

  v6 = __readfsqword(0x28u);
  setvbuf(stdout, 0LL, 2, 0LL);
  setvbuf(stdin, 0LL, 2, 0LL);
  std::operator<<<std::char_traits<char>>(&std::cout, "Name of Your zoo :");
  read(0, nameofzoo, 0x64uLL);
  while ( 1 )
  {
    menu();
    std::operator<<<std::char_traits<char>>(&std::cout, "Your choice :");
    std::istream::operator>>(&edata, &v5);
    std::ostream::operator<<(&std::cout, &std::endl<char,std::char_traits<char>>);
    switch ( v5 )
    {
      case 1:
        adddog();
        break;
      case 2:
        addcat();
        break;
      case 3:
        listen();
        break;
      case 4:
        showinfo();
        break;
      case 5:
        remove();
        break;
      case 6:
        _exit(0);
      default:
        v3 = std::operator<<<std::char_traits<char>>(&std::cout, "Invaild choice");
        std::ostream::operator<<(v3, &std::endl<char,std::char_traits<char>>);
        break;
    }
  }
}

int __fastcall __static_initialization_and_destruction_0(int a1, int a2)
{
  int result; // eax

  if ( a1 == 1 && a2 == 0xFFFF )
  {
    std::ios_base::Init::Init((std::ios_base::Init *)&std::__ioinit);
    __cxa_atexit(std::ios_base::Init::~Init, &std::__ioinit, &_dso_handle);
    std::vector<Animal *>::vector(animallist);
    return __cxa_atexit((void (__fastcall *)(void *))std::vector<Animal *>::~vector, animallist, &_dso_handle);
  }
  return result;
}

int GLOBAL__sub_I_nameofzoo()
{
  return __static_initialization_and_destruction_0(1, 0xFFFF);
}

void *__fastcall operator new(unsigned __int64 a1, void *a2)
{
  return a2;
}

void __fastcall Animal::Animal(Animal *this)
{
  *(_QWORD *)this = off_403160;
  memset((char *)this + 8, 0, 0x18uLL);
  *((_DWORD *)this + 8) = 0;
}

void __fastcall Animal::speak(Animal *this)
{
  ;
}

void __fastcall Animal::info(Animal *this)
{
  ;
}

Animal *__fastcall Dog::Dog(Animal *a1, char *a2, int a3)
{
  const char *v3; // rax
  Animal *result; // rax

  Animal::Animal(a1);
  a1->virtual_table = (VirtualTable *)off_403140;
  v3 = (const char *)std::string::c_str(a2);
  strcpy(a1->data, v3);
  result = a1;
  LODWORD(a1->a) = a3;
  return result;
}

__int64 __fastcall Dog::speak(Dog *this)
{
  __int64 v1; // rax

  v1 = std::operator<<<std::char_traits<char>>(&std::cout, "Wow ~ Wow ~ Wow ~");
  return std::ostream::operator<<(v1, &std::endl<char,std::char_traits<char>>);
}

__int64 __fastcall Dog::info(Dog *this)
{
  __int64 v1; // rax
  __int64 v2; // rax
  __int64 v3; // rax
  unsigned int v4; // ebx
  __int64 v5; // rax
  __int64 v6; // rax
  __int64 v7; // rax
  __int64 v8; // rax
  __int64 v9; // rax

  v1 = std::operator<<<std::char_traits<char>>(&std::cout, "|---------------------|");
  std::ostream::operator<<(v1, &std::endl<char,std::char_traits<char>>);
  v2 = std::operator<<<std::char_traits<char>>(&std::cout, "| Animal info         |");
  std::ostream::operator<<(v2, &std::endl<char,std::char_traits<char>>);
  v3 = std::operator<<<std::char_traits<char>>(&std::cout, "|---------------------|");
  std::ostream::operator<<(v3, &std::endl<char,std::char_traits<char>>);
  v4 = *((_DWORD *)this + 8);
  v5 = std::operator<<<std::char_traits<char>>(&std::cout, "  Weight :");
  v6 = std::ostream::operator<<(v5, v4);
  std::ostream::operator<<(v6, &std::endl<char,std::char_traits<char>>);
  v7 = std::operator<<<std::char_traits<char>>(&std::cout, "  Name : ");
  v8 = std::operator<<<std::char_traits<char>>(v7, (char *)this + 8);
  std::ostream::operator<<(v8, &std::endl<char,std::char_traits<char>>);
  v9 = std::operator<<<std::char_traits<char>>(&std::cout, "|---------------------|");
  return std::ostream::operator<<(v9, &std::endl<char,std::char_traits<char>>);
}

Animal *__fastcall Cat::Cat(Animal *a1, char *a2, int a3)
{
  const char *v3; // rax
  Animal *result; // rax

  Animal::Animal(a1);
  a1->virtual_table = (VirtualTable *)off_403120;
  v3 = (const char *)std::string::c_str(a2);
  strcpy(a1->data, v3);
  result = a1;
  LODWORD(a1->a) = a3;
  return result;
}

__int64 __fastcall Cat::speak(Cat *this)
{
  __int64 v1; // rax

  v1 = std::operator<<<std::char_traits<char>>(&std::cout, "Meow ~ Meow ~ Meow ~");
  return std::ostream::operator<<(v1, &std::endl<char,std::char_traits<char>>);
}

__int64 __fastcall Cat::info(Cat *this)
{
  __int64 v1; // rax
  __int64 v2; // rax
  __int64 v3; // rax
  unsigned int v4; // ebx
  __int64 v5; // rax
  __int64 v6; // rax
  __int64 v7; // rax
  __int64 v8; // rax
  __int64 v9; // rax

  v1 = std::operator<<<std::char_traits<char>>(&std::cout, "|---------------------|");
  std::ostream::operator<<(v1, &std::endl<char,std::char_traits<char>>);
  v2 = std::operator<<<std::char_traits<char>>(&std::cout, "| Animal info         |");
  std::ostream::operator<<(v2, &std::endl<char,std::char_traits<char>>);
  v3 = std::operator<<<std::char_traits<char>>(&std::cout, "|---------------------|");
  std::ostream::operator<<(v3, &std::endl<char,std::char_traits<char>>);
  v4 = *((_DWORD *)this + 8);
  v5 = std::operator<<<std::char_traits<char>>(&std::cout, "  Weight :");
  v6 = std::ostream::operator<<(v5, v4);
  std::ostream::operator<<(v6, &std::endl<char,std::char_traits<char>>);
  v7 = std::operator<<<std::char_traits<char>>(&std::cout, "  Name : ");
  v8 = std::operator<<<std::char_traits<char>>(v7, (char *)this + 8);
  std::ostream::operator<<(v8, &std::endl<char,std::char_traits<char>>);
  v9 = std::operator<<<std::char_traits<char>>(&std::cout, "|---------------------|");
  return std::ostream::operator<<(v9, &std::endl<char,std::char_traits<char>>);
}
