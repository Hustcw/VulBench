void __fastcall SplashXPathScanner::clipAALine(SplashXPathScanner *this, SplashBitmap *aaBuf, int *x0, int *x1, int y)
{
  int v5;
  int v6;
  bool v7;
  int v8;
  int v9;
  int v10;
  int v11;
  std::vector<boost::container::small_vector<SplashIntersect,4,boost::container::new_allocator<SplashIntersect> >>::reference v12;
  boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect> > >::size_type v13;
  int v14;
  int v15;
  int Width;
  int v17;
  _BOOL8 v18;
  unsigned __int8 *v19;
  unsigned int v20;
  unsigned int v21;
  int v22;
  SplashColorPtr v23;
  unsigned __int8 *v24;
  unsigned int v25;
  unsigned int v26;
  int v27;
  int v28;
  int v29;
  int v30;
  std::vector<boost::container::small_vector<SplashIntersect,4,boost::container::new_allocator<SplashIntersect> >> *v31;
  int v33;
  SplashColorPtr DataPtr;

  v5 = *((_DWORD *)this + 4);
  v6 = 0;
  v7 = v5 <= 4 * y;
  v8 = v5 - 4 * y;
  if ( v7 )
    v8 = 0;
  v30 = v8;
  v33 = 4 * y;
  v9 = 3;
  if ( 4 * y + 3 > *((_DWORD *)this + 6) )
    v9 = *((_DWORD *)this + 6) - 4 * y;
  v29 = v9;
  v31 = (SplashXPathScanner *)((char *)this + 32);
  do
  {
    v10 = 4 * *x0;
    v28 = v6;
    if ( v6 < v30 || v6 > v29 )
      goto LABEL_40;
    v11 = v33 + v6 - *((_DWORD *)this + 4);
    if ( v11 < 0
      || std::vector<boost::container::small_vector<SplashIntersect,4ul,boost::container::new_allocator<SplashIntersect>>>::size(v31) <= (unsigned int)v11 )
    {
      break;
    }
    v12 = std::vector<boost::container::small_vector<SplashIntersect,4ul,boost::container::new_allocator<SplashIntersect>>>::operator[](
            v31,
            v11);
    if ( boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::size(v12) )
    {
      v13 = 0LL;
      v14 = 0;
      do
      {
        if ( v10 >= 4 * *x1 + 4 )
          break;
        Width = boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::operator[](
                  v12,
                  v13)->x0;
LABEL_19:
        v17 = boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::operator[](
                v12,
                v13)->x1;
        while ( 1 )
        {
          v14 += boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::operator[](
                   v12,
                   v13)->count;
          if ( ++v13 >= boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::size(v12) )
            break;
          if ( boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::operator[](
                 v12,
                 v13)->x0 > v17 )
          {
            v18 = v14 != 0;
            if ( *((_BYTE *)this + 8) )
              LODWORD(v18) = v14 & 1;
            if ( !v18 )
              break;
          }
          if ( boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::operator[](
                 v12,
                 v13)->x1 > v17 )
            goto LABEL_19;
        }
        if ( Width > SplashBitmap::getWidth(aaBuf) )
          Width = SplashBitmap::getWidth(aaBuf);
        if ( v10 >= Width )
        {
          v15 = v10;
        }
        else
        {
          DataPtr = SplashBitmap::getDataPtr(aaBuf);
          v19 = &DataPtr[v28 * SplashBitmap::getRowSize(aaBuf) + (v10 >> 3)];
          if ( (v10 & 7) != 0 )
          {
            v20 = 0xFF00u >> (v10 & 7);
            v21 = v10 & 0xFFFFFFF8;
            if ( v21 == (Width & 0xFFFFFFF8) )
              v20 = (0xFFu >> (Width & 7)) | v20 & 0xFE;
            *v19++ &= v20;
            v10 = v21 + 8;
          }
          if ( v10 + 7 < Width )
          {
            do
            {
              *v19++ = 0;
              v15 = v10 + 8;
              v7 = v10 + 15 < Width;
              v10 += 8;
            }
            while ( v7 );
            if ( v15 >= Width )
              goto LABEL_14;
LABEL_39:
            *v19 &= 0xFFu >> (Width & 7);
            goto LABEL_14;
          }
          v15 = v10;
          if ( v10 < Width )
            goto LABEL_39;
        }
LABEL_14:
        v10 = v17 + 1;
        if ( v17 < v15 )
          v10 = v15;
      }
      while ( v13 < boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::size(v12) );
    }
LABEL_40:
    v22 = 4 * *x1 + 4;
    if ( v22 > SplashBitmap::getWidth(aaBuf) )
      v22 = SplashBitmap::getWidth(aaBuf);
    if ( v10 < 0 || v10 >= v22 )
      goto LABEL_6;
    v23 = SplashBitmap::getDataPtr(aaBuf);
    v24 = &v23[v28 * SplashBitmap::getRowSize(aaBuf) + ((unsigned int)v10 >> 3)];
    if ( (v10 & 7) != 0 )
    {
      v25 = 0xFF00u >> (v10 & 7);
      v26 = v10 & 0xFFFFFFF8;
      if ( v26 == (v22 & 0xFFFFFFF8) )
        LOBYTE(v25) = (0xFFu >> (v22 & 7)) & v25 & 0xFE;
      *v24++ &= v25;
      v10 = v26 + 8;
    }
    if ( v10 + 7 < v22 )
    {
      do
      {
        *v24++ = 0;
        v27 = v10 + 8;
        v7 = v10 + 15 < v22;
        v10 += 8;
      }
      while ( v7 );
      if ( v27 >= v22 )
        goto LABEL_6;
LABEL_53:
      *v24 &= 0xFFu >> (v22 & 7);
      goto LABEL_6;
    }
    if ( v10 < v22 )
      goto LABEL_53;
LABEL_6:
    v6 = v28 + 1;
  }
  while ( v28 != 3 );
}
