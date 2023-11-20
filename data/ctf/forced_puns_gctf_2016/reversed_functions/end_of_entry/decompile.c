Entry *__fastcall end_of_entry(Entry *result)
{
  while ( result->next )
    result = result->next;
  return result;
}