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
  unsigned __int8 v23;
  int v24;
  unsigned __int8 *v25;
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
  unsigned __int8 *v38;
  int v39;
  char v40;
  int v41;
  int v42;
  unsigned int v43;
  unsigned int v44;
  int z;
  __int64 v46;
  JBIG2Bitmap *v47;
  unsigned int v48;
  unsigned int v49;
  unsigned int v50;
  int v51;
  int v52;
  __int64 v53;
  __int64 v54;
  unsigned __int64 v55;

  v47 = bitmap;
  if ( y != 0x80000000 )
  {
    v5 = (unsigned int)y;
    v8 = -y & (y >> 31);
    h = this->h;
    v10 = h - y;
    if ( v47->h + y <= h )
      v10 = v47->h;
    if ( v8 < v10 )
    {
      v12 = 0LL;
      if ( x >= 0 )
        v12 = x & 0xFFFFFFF8;
      w = v47->w;
      v42 = v10;
      v48 = x;
      v14 = checkedAdd<int>(x, w, &z);
      v15 = v10;
      v16 = v48;
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
          v44 = 0xFFu >> (v18 & 7);
          v20 = v48 & 7;
          v21 = 255 << (8 - (v18 & 7));
          if ( (v18 & 7) == 0 )
            v21 = 255;
          v41 = v21;
          v22 = (v18 - 1) & 0xFFFFFFF8;
          v53 = (signed int)-v48 >> 3;
          v51 = 255 << (8 - v20);
          v55 = (unsigned __int64)v48 >> 3;
          v52 = v17 + 8;
          v50 = v21 & (0xFFu >> v20);
          v49 = ~v50;
          v54 = v5;
          v46 = v17;
          v43 = v22;
          do
          {
            v25 = &this->data[this->line * (__int64)(v8 + (int)v5)];
            if ( (_DWORD)v17 == v22 )
            {
              if ( v16 < 0 )
              {
                LOBYTE(v24) = *v25;
                v32 = v47->data[v53 + v47->line * (__int64)v8];
                switch ( combOp )
                {
                  case 0u:
                    LOBYTE(v24) = v41 & v32 | v24;
                    break;
                  case 1u:
                    LOBYTE(v24) = (v44 | v32) & v24;
                    break;
                  case 2u:
                    goto LABEL_56;
                  case 3u:
                    v32 = ~v32;
LABEL_56:
                    LOBYTE(v24) = v41 & v32 ^ v24;
                    break;
                  case 4u:
                    LOBYTE(v24) = v41 & v32 | v44 & v24;
                    break;
                  default:
                    break;
                }
              }
              else
              {
                v24 = v25[v55];
                v25 += v55;
                v26 = v47->data[v47->line * (__int64)v8];
                switch ( combOp )
                {
                  case 0u:
                    v24 |= v41 & (v26 >> v20);
                    break;
                  case 1u:
                    v24 &= v44 | ((v26 | 0xFF00) >> v20);
                    break;
                  case 2u:
                    goto LABEL_30;
                  case 3u:
                    v26 ^= 0xFFu;
LABEL_30:
                    v24 ^= v41 & (v26 >> v20);
                    break;
                  case 4u:
                    v24 = v50 & (v26 >> v20) | v49 & v24;
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
                v33 = &v47->data[v53 + v8 * (__int64)v47->line];
                v29 = *v33;
                v34 = 0;
              }
              else
              {
                data = v47->data;
                v28 = v8 * (__int64)v47->line;
                v29 = data[v28];
                v30 = v25[v55];
                v31 = &v25[v55];
                switch ( combOp )
                {
                  case 0u:
                    goto LABEL_36;
                  case 1u:
                    v30 &= (v29 + 65280) >> v20;
                    break;
                  case 2u:
                    v35 = data[v28];
                    goto LABEL_34;
                  case 3u:
                    v35 = v29 ^ 0xFF;
LABEL_34:
                    v30 ^= v35 >> v20;
                    break;
                  case 4u:
                    v30 &= v51;
LABEL_36:
                    v30 |= v29 >> v20;
                    break;
                  default:
                    break;
                }
                v33 = &data[v28];
                *v31 = v30;
                v25 = v31 + 1;
                v34 = v52;
              }
              v36 = v33[1];
              v37 = (v36 | (v29 << 8)) >> v20;
              LOBYTE(v24) = *v25;
              v23 = v37;
              if ( v34 >= z - 8 )
              {
                LODWORD(v5) = v54;
              }
              else
              {
                v38 = v33 + 2;
                LODWORD(v5) = v54;
                if ( combOp > 4 )
                {
LABEL_45:
                  v23 = v24;
                  goto LABEL_42;
                }
                do
                {
                  switch ( combOp )
                  {
                    case 0u:
                      v23 |= v24;
                      break;
                    case 1u:
                      v23 = v24 & v37;
                      break;
                    case 2u:
                      v23 ^= v24;
                      break;
                    case 3u:
                      v23 = ~(v24 ^ v23);
                      break;
                    case 4u:
                      break;
                    default:
                      goto LABEL_45;
                  }
LABEL_42:
                  *v25 = v23;
                  v34 += 8;
                  LOBYTE(v24) = v25[1];
                  v39 = *v38;
                  v37 = (v39 | (unsigned int)(v36 << 8)) >> v20;
                  ++v25;
                  v23 = v37;
                  ++v38;
                  v36 = v39;
                }
                while ( v34 < z - 8 );
              }
              v16 = v48;
              switch ( combOp )
              {
                case 0u:
                  v40 = v41 & v23;
                  goto LABEL_53;
                case 1u:
                  LOBYTE(v24) = v24 & (v44 | v37);
                  break;
                case 2u:
                  goto LABEL_15;
                case 3u:
                  v23 = ~v23;
LABEL_15:
                  LOBYTE(v24) = v41 & v23 ^ v24;
                  break;
                case 4u:
                  v40 = v41 & v23;
                  LOBYTE(v24) = v44 & v24;
LABEL_53:
                  LOBYTE(v24) = v40 | v24;
                  break;
                default:
                  break;
              }
              v15 = v42;
              LODWORD(v17) = v46;
              v22 = v43;
            }
            *v25 = v24;
            ++v8;
          }
          while ( v8 < v15 );
        }
      }
    }
  }
}
