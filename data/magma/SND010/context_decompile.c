
void __fastcall header_put_le_int(SF_PRIVATE *psf, int x)
{
  unsigned __int8 v2;
  unsigned __int8 *ptr;
  sf_count_t indx;
  unsigned __int8 *v5;
  sf_count_t v6;
  unsigned __int8 *v7;
  sf_count_t v8;
  unsigned __int8 *v9;
  sf_count_t v10;

  v2 = HIBYTE(x);
  ptr = psf->header.ptr;
  indx = psf->header.indx;
  psf->header.indx = indx + 1;
  ptr[indx] = x;
  v5 = psf->header.ptr;
  v6 = psf->header.indx;
  psf->header.indx = v6 + 1;
  v5[v6] = BYTE1(x);
  LODWORD(v5) = HIWORD(x);
  v7 = psf->header.ptr;
  v8 = psf->header.indx;
  psf->header.indx = v8 + 1;
  v7[v8] = (unsigned __int8)v5;
  v9 = psf->header.ptr;
  v10 = psf->header.indx;
  psf->header.indx = v10 + 1;
  v9[v10] = v2;
}


void __fastcall header_put_be_int(SF_PRIVATE *psf, int x)
{
  unsigned int v3;
  unsigned __int8 *ptr;
  sf_count_t indx;
  unsigned __int8 *v6;
  sf_count_t v7;
  unsigned __int8 *v8;
  sf_count_t v9;
  unsigned __int8 *v10;
  sf_count_t v11;

  v3 = HIBYTE(x);
  ptr = psf->header.ptr;
  indx = psf->header.indx;
  psf->header.indx = indx + 1;
  ptr[indx] = v3;
  v6 = psf->header.ptr;
  v7 = psf->header.indx;
  psf->header.indx = v7 + 1;
  v6[v7] = BYTE2(x);
  v8 = psf->header.ptr;
  v9 = psf->header.indx;
  psf->header.indx = v9 + 1;
  v8[v9] = BYTE1(x);
  v10 = psf->header.ptr;
  v11 = psf->header.indx;
  psf->header.indx = v11 + 1;
  v10[v11] = x;
}
