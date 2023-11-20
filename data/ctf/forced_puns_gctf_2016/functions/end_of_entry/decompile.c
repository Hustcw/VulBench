__int64 __fastcall end_of_entry(__int64 result)
{
  while ( *(_QWORD *)(result + 16) )
    result = *(_QWORD *)(result + 16);
  return result;
}
