void __fastcall free2(Content *a1)
{
  free(a1->content);
  free(a1);
}