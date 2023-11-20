unsigned __int8 *__fastcall Stream::toUnsignedChars(Stream *this, int *length, int initialSize, int sizeIncrement)
{
  int v5;
  unsigned __int8 *v7;
  int Chars;
  int v9;

  v5 = initialSize;
  v7 = (unsigned __int8 *)gmalloc(initialSize, 0);
  *length = 0;
  (*((void (__fastcall **)(Stream *))this->_vptr$Stream + 3))(this);
  Chars = Stream::doGetChars(this, initialSize, &v7[*length]);
  if ( Chars )
  {
    v9 = sizeIncrement + v5;
    do
    {
      *length += Chars;
      if ( Chars != v5 )
        break;
      if ( (*((unsigned int (__fastcall **)(Stream *))this->_vptr$Stream + 6))(this) == -1 )
        break;
      v7 = (unsigned __int8 *)grealloc(v7, v9, 0);
      Chars = Stream::doGetChars(this, sizeIncrement, &v7[*length]);
      v9 += sizeIncrement;
      v5 = sizeIncrement;
    }
    while ( Chars );
  }
  return v7;
}


void __fastcall JPXStream::init(JPXStream *this)
{
  const Dict *v2;
  const Dict *v3;
  const Dict *v4;
  int Int;
  bool isName;
  unsigned __int8 *v7;
  JPXStreamPrivate *priv;
  opj_image_t *image;
  int numcomps;
  bool v11;
  opj_image_comp_t *comps;
  int *data;
  __int64 v14;
  __int64 v15;
  __int64 v16;
  int v17;
  int v18;
  int v19;
  __int64 v20;
  __int64 v21;
  __int64 v22;
  __int64 v23;
  int v24;
  __int64 v25;
  int v26;
  unsigned __int8 v27;
  JPXStream *v28;
  Object other;
  __int64 v30;
  int *v31;
  Object v32;
  Object v33;
  Object v34;
  __int64 v35;

  Object::Object(&v34);
  Object::Object(&v32);
  Object::Object(&v33);
  if ( (*((__int64 (__fastcall **)(JPXStream *))this->_vptr$Stream + 19))(this) )
  {
    v2 = (const Dict *)(*((__int64 (__fastcall **)(JPXStream *))this->_vptr$Stream + 19))(this);
    Dict::lookup(v2, "Length", 0);
    Object::operator=(&v34, &other);
    Object::~Object(&other);
    v3 = (const Dict *)(*((__int64 (__fastcall **)(JPXStream *))this->_vptr$Stream + 19))(this);
    Dict::lookup(v3, (const char *)&state.px1 + 7, 0);
    Object::operator=(&v32, &other);
    Object::~Object(&other);
    v4 = (const Dict *)(*((__int64 (__fastcall **)(JPXStream *))this->_vptr$Stream + 19))(this);
    Dict::lookup(v4, "SMaskInData", 0);
    Object::operator=(&v33, &other);
    Object::~Object(&other);
  }
  Int = 4096;
  if ( Object::isInt(&v34) )
    Int = Object::getInt(&v34);
  if ( Object::isArray(&v32) && Object::arrayGetLength(&v32) > 0 )
  {
    Object::arrayGet(&v32, 0, 0);
    isName = Object::isName(&other, (const char *)&state.ctm[1] + 4);
    Object::~Object(&other);
  }
  else
  {
    isName = 0;
  }
  this->priv->smaskInData = 0;
  if ( Object::isInt(&v33) )
    this->priv->smaskInData = Object::getInt(&v33);
  other.type = ObjType::objBool;
  v7 = Stream::toUnsignedChars(this->str, (int *)&other, Int, 4096);
  JPXStreamPrivate::init2(this->priv, CODEC_FORMAT::OPJ_CODEC_JP2, v7, other.type, isName);
  gfree(v7);
  priv = this->priv;
  image = priv->image;
  if ( priv->image )
  {
    numcomps = image->numcomps;
    v11 = (numcomps ^ 4 | (image->color_space | 2) ^ 3) == 0;
    comps = image->comps;
    priv->npixels = comps->w * comps->h;
    priv->ncomps = numcomps;
    if ( (numcomps == 2 || v11 || numcomps >= 5) && !priv->smaskInData )
      priv->ncomps = --numcomps;
    if ( numcomps > 0 )
    {
      v28 = this;
      data = comps->data;
      if ( data )
      {
        v14 = 0LL;
        while ( 1 )
        {
          v35 = v14;
          v15 = v14 << 6;
          v16 = *(unsigned int *)((char *)&comps->prec + v15);
          v17 = v16 - 8;
          if ( (unsigned int)v16 <= 8 )
            v17 = 0;
          v18 = 0;
          if ( *(OPJ_UINT32 *)((char *)&comps->sgnd + v15) )
            v18 = 1 << (LOBYTE(comps->prec) - 1);
          if ( priv->npixels > 0 )
          {
            v30 = v15;
            v19 = *data;
            v31 = data;
            v20 = v16;
            *(_BYTE *)v31 = adjustComp(v19, v17, v16, v18, isName);
            priv = v28->priv;
            if ( priv->npixels >= 2 )
            {
              v21 = 1LL;
              v22 = v20;
              v23 = v30;
              v24 = v18;
              do
              {
                v25 = v22;
                v26 = v24;
                v27 = adjustComp((*(OPJ_INT32 **)((char *)&priv->image->comps->data + v23))[v21], v17, v22, v24, isName);
                v24 = v26;
                v23 = v30;
                v22 = v25;
                *((_BYTE *)v31 + v21++) = v27;
                priv = v28->priv;
              }
              while ( v21 < priv->npixels );
            }
          }
          v14 = v35 + 1;
          if ( v35 + 1 >= priv->ncomps )
            break;
          comps = priv->image->comps;
          data = comps[v14].data;
          if ( !data )
            goto LABEL_30;
        }
      }
      else
      {
LABEL_30:
        (*((void (__fastcall **)(JPXStream *))v28->_vptr$Stream + 4))(v28);
        priv = v28->priv;
      }
    }
  }
  else
  {
    priv->npixels = 0;
  }
  *(_QWORD *)&priv->counter = 0LL;
  priv->inited = 1;
  Object::~Object(&v33);
  Object::~Object(&v32);
  Object::~Object(&v34);
}
