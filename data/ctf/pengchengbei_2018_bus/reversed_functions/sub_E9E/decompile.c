void sub_E9E()
{
  if ( idx == -1 )
  {
    puts("Select a destination first!");
  }
  else
  {
    puts("OK, let's go!");
    free(destination[idx]);
    destination[idx] = 0LL;
    people_count[idx] = 0LL;
    memcpy(&destination[idx], &destination[idx + 1], 8 * (dest_cnt - idx - 1));
    memcpy(&people_count[idx], &people_count[idx + 1], 8 * (dest_cnt - idx - 1));
    destination[--dest_cnt] = 0LL;
    people_count[dest_cnt] = 0LL;
    idx = -1LL;
  }
}