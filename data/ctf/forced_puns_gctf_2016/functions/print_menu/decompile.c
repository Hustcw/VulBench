ssize_t __fastcall print_menu(int a1)
{
  __int64 v1;
  size_t v2;
  const char *v3;
  ssize_t result;

  switch ( a1 )
  {
    case 0:
      v1 = 116LL;
      v2 = 116LL;
      v3 = "\n"
           "Q. When does a joke become a Dad joke?\n"
           "A. When it becomes apparent.\n"
           "\n"
           "1. Add an entry\n"
           "2. Print entries\n"
           "3. Quit\n"
           "\n"
           "--> ";
      break;
    case 1:
      v1 = 185LL;
      v2 = 185LL;
      v3 = "\n"
           "My duck got arrested.\n"
           ".. Apparently he's a quackhead.\n"
           ".. I tried to bail him out, they wouldn't let me. Said he was a flight risk.\n"
           "\n"
           "1. Set name\n"
           "2. Set small\n"
           "3. Set large\n"
           "4. cd ..\n"
           "\n"
           "--> ";
      break;
    case 2:
      v1 = 137LL;
      v2 = 137LL;
      v3 = "\n"
           "Person A: I once met a dog with no nose.\n"
           "Person B: How does he smell?\n"
           "Person A: Terrible.\n"
           "\n"
           "What name would you like for this entry?\n"
           "--> ";
      break;
    case 3:
      v1 = 154LL;
      v2 = 154LL;
      v3 = "\n"
           "My fridge is full of German sausages... I made the wurst mistake when I went shopping last time.\n"
           "\n"
           "What value do you want to set for the small value?\n"
           "--> ";
      break;
    case 4:
      v1 = 88LL;
      v2 = 88LL;
      v3 = "\nWhy did Fred fall off a bike?\nBecause Fred was a fish.\n\nWhat size should large be?\n--> ";
      break;
    default:
      err(1, "invalid state reached?");
  }
  result = write(1, v3, v2);
  if ( result != v1 )
    err(1, "writing menu to stdout");
  return result;
}
