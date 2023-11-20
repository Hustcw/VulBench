unsigned __int64 sendMessage()
{
  char buf[136];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  puts("Enter message to be sent: ");
  read(0, buf, 0x7FuLL);
  puts("Message recieved: ");
  puts(buf);
  puts("\nSaving it for admin to see!\n");
  message = (__int64)strdup(buf);
  return __readfsqword(0x28u) ^ v2;
}
