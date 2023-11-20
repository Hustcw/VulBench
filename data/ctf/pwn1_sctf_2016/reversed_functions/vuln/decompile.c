int vuln()
{
  const char *v0; 
  int v2; 
  int v3; 
  char s[32]; 
  char v5[4]; 
  char v6[7]; 
  char v7; 
  char v8[7]; 
  char v9[5]; 

  printf("Tell me something about yourself: ");
  fgets(s, 32, edata);
  std::string::operator=(&input, s);
  std::allocator<char>::allocator(&v7);
  std::string::string(v6, "you", &v7);
  std::allocator<char>::allocator(v9);
  std::string::string(v8, "I", v9);
  replace((std::string *)v5, (std::string *)&input, (std::string *)v8, (std::string *)v6);
  std::string::operator=(&input, v5);
  std::string::~string(v5);
  std::string::~string(v8);
  std::allocator<char>::~allocator(v9, v2);
  std::string::~string(v6);
  std::allocator<char>::~allocator(&v7, v3);
  v0 = (const char *)std::string::c_str((std::string *)&input);
  strcpy(s, v0);
  return printf("So, %s\n", s);
}