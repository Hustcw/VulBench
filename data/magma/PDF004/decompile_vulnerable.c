void __fastcall SplashXPathScanner::clipAALine(SplashXPathScanner *this, SplashBitmap *aaBuf, int *x0, int *x1, int y)
{
  int v5;
  int v6;
  bool v7;
  int v8;
  int v9;
  int v10;
  std::vector<boost::container::small_vector<SplashIntersect,4,boost::container::new_allocator<SplashIntersect> >>::reference v11;
  boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect> > >::size_type v12;
  int v13;
  int v14;
  int Width;
  int v16;
  _BOOL8 v17;
  unsigned __int8 *v18;
  unsigned int v19;
  unsigned int v20;
  int v21;
  SplashColorPtr v22;
  unsigned __int8 *v23;
  unsigned int v24;
  unsigned int v25;
  int v26;
  int v27;
  int v28;
  int v29;
  int v31;
  SplashColorPtr DataPtr;

  v5 = *((_DWORD *)this + 4);
  v6 = 0;
  v7 = v5 <= 4 * y;
  v8 = v5 - 4 * y;
  if ( v7 )
    v8 = 0;
  v28 = v8;
  v31 = 4 * y;
  v9 = 3;
  if ( 4 * y + 3 > *((_DWORD *)this + 6) )
    v9 = *((_DWORD *)this + 6) - 4 * y;
  v27 = v9;
  do
  {
    v10 = 4 * *x0;
    v29 = v6;
    if ( v6 >= v28 && v6 <= v27 )
    {
      v11 = std::vector<boost::container::small_vector<SplashIntersect,4ul,boost::container::new_allocator<SplashIntersect>>>::operator[](
              (SplashXPathScanner *)((char *)this + 32),
              v6 + v31 - *((_DWORD *)this + 4));
      if ( boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::size(v11) )
      {
        v12 = 0LL;
        v13 = 0;
        do
        {
          if ( v10 >= 4 * *x1 + 4 )
            break;
          Width = boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::operator[](
                    v11,
                    v12)->x0;
LABEL_17:
          v16 = boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::operator[](
                  v11,
                  v12)->x1;
          while ( 1 )
          {
            v13 += boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::operator[](
                     v11,
                     v12)->count;
            if ( ++v12 >= boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::size(v11) )
              break;
            if ( boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::operator[](
                   v11,
                   v12)->x0 > v16 )
            {
              v17 = v13 != 0;
              if ( *((_BYTE *)this + 8) )
                LODWORD(v17) = v13 & 1;
              if ( !v17 )
                break;
            }
            if ( boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::operator[](
                   v11,
                   v12)->x1 > v16 )
              goto LABEL_17;
          }
          if ( Width > SplashBitmap::getWidth(aaBuf) )
            Width = SplashBitmap::getWidth(aaBuf);
          if ( v10 >= Width )
          {
            v14 = v10;
          }
          else
          {
            DataPtr = SplashBitmap::getDataPtr(aaBuf);
            v18 = &DataPtr[v29 * SplashBitmap::getRowSize(aaBuf) + (v10 >> 3)];
            if ( (v10 & 7) != 0 )
            {
              v19 = 0xFF00u >> (v10 & 7);
              v20 = v10 & 0xFFFFFFF8;
              if ( v20 == (Width & 0xFFFFFFF8) )
                v19 = (0xFFu >> (Width & 7)) | v19 & 0xFE;
              *v18++ &= v19;
              v10 = v20 + 8;
            }
            if ( v10 + 7 < Width )
            {
              do
              {
                *v18++ = 0;
                v14 = v10 + 8;
                v7 = v10 + 15 < Width;
                v10 += 8;
              }
              while ( v7 );
              if ( v14 >= Width )
                goto LABEL_12;
LABEL_37:
              *v18 &= 0xFFu >> (Width & 7);
              goto LABEL_12;
            }
            v14 = v10;
            if ( v10 < Width )
              goto LABEL_37;
          }
LABEL_12:
          v10 = v16 + 1;
          if ( v16 < v14 )
            v10 = v14;
        }
        while ( v12 < boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::size(v11) );
      }
    }
    v21 = 4 * *x1 + 4;
    if ( v21 > SplashBitmap::getWidth(aaBuf) )
      v21 = SplashBitmap::getWidth(aaBuf);
    if ( v10 >= 0 && v10 < v21 )
    {
      v22 = SplashBitmap::getDataPtr(aaBuf);
      v23 = &v22[v29 * SplashBitmap::getRowSize(aaBuf) + ((unsigned int)v10 >> 3)];
      if ( (v10 & 7) != 0 )
      {
        v24 = 0xFF00u >> (v10 & 7);
        v25 = v10 & 0xFFFFFFF8;
        if ( v25 == (v21 & 0xFFFFFFF8) )
          LOBYTE(v24) = (0xFFu >> (v21 & 7)) & v24 & 0xFE;
        *v23++ &= v24;
        v10 = v25 + 8;
      }
      if ( v10 + 7 >= v21 )
      {
        if ( v10 >= v21 )
          goto LABEL_6;
LABEL_51:
        *v23 &= 0xFFu >> (v21 & 7);
        goto LABEL_6;
      }
      do
      {
        *v23++ = 0;
        v26 = v10 + 8;
        v7 = v10 + 15 < v21;
        v10 += 8;
      }
      while ( v7 );
      if ( v26 < v21 )
        goto LABEL_51;
    }
LABEL_6:
    v6 = v29 + 1;
  }
  while ( v29 != 3 );
}
