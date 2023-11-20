ssize_t menu()
{
  write(1, "***********************\n", 0x18uLL);
  write(1, "1.Add new note\n", 0xFuLL);
  write(1, "2.Delete a note\n", 0x10uLL);
  write(1, "3.Show a note\n", 0xEuLL);
  write(1, "4.Exit\n", 7uLL);
  write(1, "***********************\n", 0x18uLL);
  return write(1, "Your choice: ", 0xDuLL);
}
