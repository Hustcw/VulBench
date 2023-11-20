void __fastcall JBIG2Bitmap::combine(JBIG2Bitmap *this, JBIG2Bitmap *bitmap, int x, int y, unsigned int combOp)
{
  __int64 v5;
  int v8;
  int h;
  int v10;
  __int64 v12;
  int w;
  bool v14;
  int v15;
  int v16;
  __int64 v17;
  int v18;
  int v19;
  char v20;
  int v21;
  unsigned int v22;
  int v23;
  unsigned __int8 *v24;
  int v25;
  unsigned int v26;
  unsigned __int8 *data;
  __int64 v28;
  unsigned int v29;
  int v30;
  unsigned __int8 *v31;
  unsigned __int8 v32;
  unsigned __int8 *v33;
  int v34;
  unsigned int v35;
  int v36;
  unsigned int v37;
  unsigned __int8 v38;
  unsigned __int8 *v39;
  int v40;
  char v41;
  int v42;
  int v43;
  unsigned int v44;
  unsigned int v45;
  int z;
  __int64 v47;
  JBIG2Bitmap *v48;
  unsigned int v49;
  unsigned int v50;
  unsigned int v51;
  int v52;
  int v53;
  __int64 v54;
  __int64 v55;
  unsigned __int64 v56;

  v48 = bitmap;
  if ( y != 0x80000000 )
  {
    v5 = (unsigned int)y;
    v8 = -y & (y >> 31);
    h = this->h;
    v10 = h - y;
    if ( v48->h + y <= h )
      v10 = v48->h;
    if ( v8 < v10 )
    {
      v12 = 0LL;
      if ( x >= 0 )
        v12 = x & 0xFFFFFFF8;
      w = v48->w;
      v43 = v10;
      v49 = x;
      v14 = checkedAdd<int>(x, w, &z);
      v15 = v10;
      v16 = v49;
      if ( !v14 )
      {
        v17 = v12;
        v18 = z;
        v19 = this->w;
        if ( z > v19 )
        {
          z = this->w;
          v18 = v19;
        }
        if ( (int)v12 < v18 )
        {
          v45 = 0xFFu >> (v18 & 7);
          v20 = v49 & 7;
          v21 = 255 << (8 - (v18 & 7));
          if ( (v18 & 7) == 0 )
            v21 = 255;
          v42 = v21;
          v22 = (v18 - 1) & 0xFFFFFFF8;
          v54 = (signed int)-v49 >> 3;
          v52 = 255 << (8 - v20);
          v56 = (unsigned __int64)v49 >> 3;
          v53 = v17 + 8;
          v51 = v21 & (0xFFu >> v20);
          v50 = ~v51;
          v55 = v5;
          v47 = v17;
          v44 = v22;
          do
          {
            v23 = v5 + v8;
            if ( (int)v5 + v8 >= 0 && v23 < this->h )
            {
              v24 = &this->data[this->line * (__int64)v23];
              if ( (_DWORD)v17 == v22 )
              {
                if ( v16 < 0 )
                {
                  LOBYTE(v25) = *v24;
                  v32 = v48->data[v54 + v48->line * (__int64)v8];
                  switch ( combOp )
                  {
                    case 0u:
                      LOBYTE(v25) = v42 & v32 | v25;
                      break;
                    case 1u:
                      LOBYTE(v25) = (v45 | v32) & v25;
                      break;
                    case 2u:
                      goto LABEL_60;
                    case 3u:
                      v32 = ~v32;
LABEL_60:
                      LOBYTE(v25) = v42 & v32 ^ v25;
                      break;
                    case 4u:
                      LOBYTE(v25) = v42 & v32 | v45 & v25;
                      break;
                    default:
                      break;
                  }
                }
                else
                {
                  v25 = v24[v56];
                  v24 += v56;
                  v26 = v48->data[v48->line * (__int64)v8];
                  switch ( combOp )
                  {
                    case 0u:
                      v25 |= v42 & (v26 >> v20);
                      break;
                    case 1u:
                      v25 &= v45 | ((v26 | 0xFF00) >> v20);
                      break;
                    case 2u:
                      goto LABEL_28;
                    case 3u:
                      v26 ^= 0xFFu;
LABEL_28:
                      v25 ^= v42 & (v26 >> v20);
                      break;
                    case 4u:
                      v25 = v51 & (v26 >> v20) | v50 & v25;
                      break;
                    default:
                      break;
                  }
                }
              }
              else
              {
                if ( v16 < 0 )
                {
                  v33 = &v48->data[v54 + v8 * (__int64)v48->line];
                  v29 = *v33;
                  v34 = 0;
                }
                else
                {
                  data = v48->data;
                  v28 = v8 * (__int64)v48->line;
                  v29 = data[v28];
                  v30 = v24[v56];
                  v31 = &v24[v56];
                  switch ( combOp )
                  {
                    case 0u:
                      goto LABEL_34;
                    case 1u:
                      v30 &= (v29 + 65280) >> v20;
                      break;
                    case 2u:
                      v35 = data[v28];
                      goto LABEL_32;
                    case 3u:
                      v35 = v29 ^ 0xFF;
LABEL_32:
                      v30 ^= v35 >> v20;
                      break;
                    case 4u:
                      v30 &= v52;
LABEL_34:
                      v30 |= v29 >> v20;
                      break;
                    default:
                      break;
                  }
                  v33 = &data[v28];
                  *v31 = v30;
                  v24 = v31 + 1;
                  v34 = v53;
                }
                v36 = v33[1];
                v37 = (v36 | (v29 << 8)) >> v20;
                LOBYTE(v25) = *v24;
                v38 = v37;
                if ( v34 >= z - 8 )
                {
                  LODWORD(v5) = v55;
                }
                else
                {
                  v39 = v33 + 2;
                  LODWORD(v5) = v55;
                  if ( combOp > 4 )
                  {
LABEL_43:
                    v38 = v25;
                    goto LABEL_40;
                  }
                  do
                  {
                    switch ( combOp )
                    {
                      case 0u:
                        v38 |= v25;
                        break;
                      case 1u:
                        v38 = v25 & v37;
                        break;
                      case 2u:
                        v38 ^= v25;
                        break;
                      case 3u:
                        v38 = ~(v25 ^ v38);
                        break;
                      case 4u:
                        break;
                      default:
                        goto LABEL_43;
                    }
LABEL_40:
                    *v24 = v38;
                    v34 += 8;
                    LOBYTE(v25) = v24[1];
                    v40 = *v39;
                    v37 = (v40 | (unsigned int)(v36 << 8)) >> v20;
                    ++v24;
                    v38 = v37;
                    ++v39;
                    v36 = v40;
                  }
                  while ( v34 < z - 8 );
                }
                v16 = v49;
                switch ( combOp )
                {
                  case 0u:
                    v41 = v42 & v38;
                    goto LABEL_53;
                  case 1u:
                    LOBYTE(v25) = v25 & (v45 | v37);
                    break;
                  case 2u:
                    goto LABEL_51;
                  case 3u:
                    v38 = ~v38;
LABEL_51:
                    LOBYTE(v25) = v42 & v38 ^ v25;
                    break;
                  case 4u:
                    v41 = v42 & v38;
                    LOBYTE(v25) = v45 & v25;
LABEL_53:
                    LOBYTE(v25) = v41 | v25;
                    break;
                  default:
                    break;
                }
                v15 = v43;
                LODWORD(v17) = v47;
                v22 = v44;
              }
              *v24 = v25;
            }
            ++v8;
          }
          while ( v8 < v15 );
        }
      }
    }
  }
}
