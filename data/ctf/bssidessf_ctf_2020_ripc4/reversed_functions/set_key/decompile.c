void __cdecl set_key(workspace_t *ws)
{
  int byte;
  int rv;
  char tmp;
  size_t key_len;
  char *key_data;
  int i_1;
  int j;
  int i_0;
  int i;

  key_data = prompt("key (hex)");
  if ( key_data )
  {
    key_len = strlen(key_data);
    if ( key_len > 0x200 || key_len <= 1 || (key_len & 1) != 0 )
    {
      puts("Invalid key length!");
    }
    else
    {
      for ( i = 0; key_len > i; i += 2 )
      {
        rv = __isoc99_sscanf(&key_data[i], "%02x", &byte);
        if ( rv != 1 )
        {
          puts("Invalid key data!");
          return;
        }
        key_data[i / 2] = byte;
      }
      key_len >>= 1;
      if ( ws->_anon_0.enc_state )
      {
        secure_free(ws->_anon_0.enc_state);
        ws->_anon_0.enc_state = 0LL;
      }
      ws->_anon_0.enc_state = (char *)secure_malloc(0x100uLL);
      for ( i_0 = 0; i_0 <= 255; ++i_0 )
        ws->_anon_0.enc_state[i_0] = i_0;
      j = 0;
      for ( i_1 = 0; i_1 <= 255; ++i_1 )
      {
        j = (unsigned __int8)(ws->_anon_0.enc_state[i_1] + j + key_data[i_1 % key_len]);
        tmp = ws->_anon_0.enc_state[i_1];
        ws->_anon_0.enc_state[i_1] = ws->_anon_0.enc_state[j];
        ws->_anon_0.enc_state[j] = tmp;
      }
      memset(key_data, 0, 2 * key_len);
      puts("Key has been set.");
    }
  }
  else
  {
    puts("No key!");
  }
}