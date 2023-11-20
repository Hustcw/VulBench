void sub_1DD0()
{
  puts("************************************************");
  puts("welcome to the manual of myshell");
  puts("the following commands supported by myshell");
  putchar(10);
  puts("\x1B[1;33mNAMES\x1B[m      \x1B[1;33mFORMATS\x1B[m                         \x1B[1;33mDESCRIPTIONS\x1B[m");
  puts("\x1B[1;32mpwd\x1B[m:       pwd                             Print the current working directory");
  puts("\x1B[1;32mecho\x1B[m:      echo ...                        Print strings after echo");
  puts("           echo ... >(>>) [FILE]           Redirection is supported");
  puts("\x1B[1;32mls\x1B[m:        ls [DIR]                        List the file names in the target directory");
  puts("\x1B[1;32mcd\x1B[m:        cd [DIR]                        Go to a specified directory");
  puts("\x1B[1;32mmkdir\x1B[m:     mkdir [DIR]                     Create a file directory");
  puts("\x1B[1;32mmonitor\x1B[m:   monitor                         Enter monitor mode ");
  puts(
    "\x1B[1;32mwc\x1B[m:        wc [FILE]                       Statistics the number of bytes, words and rows in the spe"
    "cified file, and display");
  puts("\x1B[1;32mclear\x1B[m:     clear                           Clear the screen");
  puts(
    "\x1B[1;32mhelp\x1B[m:      help                           Show the manual of help/get help info of a sepcified command");
  puts("\x1B[1;32mquit\x1B[m:      quit                            Quit the shell ");
  puts("************************************************");
  fflush(stdout);
}