__int64 __fastcall run(Link *instr, Link *stack, Link *mem)
{
  unsigned int v5;
  __int64 v6;

  v5 = 1;
  while ( v5 && (unsigned int)pop_internal(instr, &v6) )
  {
    switch ( v6 )
    {
      case 17LL:
        v5 = get_from_stack(mem, stack);
        break;
      case 18LL:
        v5 = move_to_stack(mem, stack);
        break;
      case 33LL:
        v5 = add(mem);
        break;
      case 34LL:
        v5 = sub(mem);
        break;
      case 35LL:
        v5 = mul(mem);
        break;
      case 36LL:
        v5 = div(mem);
        break;
      case 49LL:
        v5 = load(mem);
        break;
      case 50LL:
        v5 = save(mem);
        break;
      default:
        v5 = 0;
        break;
    }
  }
  return v5;
}