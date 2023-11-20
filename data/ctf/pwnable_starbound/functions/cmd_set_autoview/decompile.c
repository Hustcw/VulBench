_BOOL4 cmd_set_autoview()
{
  _BOOL4 result;

  result = dword_80580CC == 0;
  dword_80580CC = result;
  return result;
}
