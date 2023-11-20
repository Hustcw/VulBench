void __cdecl encryptNode()
{
  char seed[80]; // [rsp+0h] [rbp-60h] BYREF
  int index; // [rsp+58h] [rbp-8h]
  int size; // [rsp+5Ch] [rbp-4h]

  myputs("input the index to encrypt >>", 0);
  index = getNumber();
  myputs("input the size of the seed (max 0x50) >>", 0);
  size = getNumber();
  if ( (unsigned int)size >= 0x71 )
    size = 112;
  myputs("input the crypt seed >>", 0);
  getContent(seed, size);
  doSomeThing(seed, index);
}