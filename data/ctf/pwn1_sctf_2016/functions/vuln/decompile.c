int vuln()
{
  const char *v0;
  int v2;
  int v3;
  int v4;
  char s[32];
  char v6[4];
  char v7[7];
  char v8;
  char v9[7];
  char v10[5];

  printf("Tell me something about yourself: ");
  fgets(s, 32, edata);
  std::string::operator=(&input, s);
  std::allocator<char>::allocator(&v8);
  std::string::string(v7, "you", &v8);
  std::allocator<char>::allocator(v10);
  std::string::string(v9, "I", v10);
  replace((std::string *)v6, (std::string *)&input, (std::string *)v9);
  std::string::operator=(&input, v6, v4);
  std::string::~string(v6);
  std::string::~string(v9);
  std::allocator<char>::~allocator(v10, v2);
  std::string::~string(v7);
  std::allocator<char>::~allocator(&v8, v3);
  v0 = (const char *)std::string::c_str((std::string *)&input);
  strcpy(s, v0);
  return printf("So, %s\n", s);
}
