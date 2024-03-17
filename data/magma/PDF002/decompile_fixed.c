void __fastcall JPXStream::init(JPXStream *this)
{
  const Dict *v1;
  const Dict *v2;
  const Dict *v3;
  int Int;
  bool isName;
  unsigned __int8 *v6;
  JPXStreamPrivate *priv;
  __int64 image;
  __int64 v9;
  bool v10;
  opj_image_comp_t *comps;
  __int64 npixels;
  _BOOL8 v13;
  int *data;
  __int64 v15;
  __int64 v16;
  unsigned int v17;
  int v18;
  int v19;
  __int64 v20;
  __int64 v21;
  __int64 v22;
  int v23;
  int v24;
  unsigned int v25;
  __int64 v26;
  unsigned __int8 v27;
  JPXStreamPrivate *v28;
  Object other;
  int *v31;
  Object v32;
  Object v33;
  Object v34;
  __int64 v35;

  Object::Object(&v33);
  Object::Object(&v32);
  Object::Object(&v34);
  if ( (*((__int64 (__fastcall **)(JPXStream *))this->_vptr$Stream + 19))(this) )
  {
    v1 = (const Dict *)(*((__int64 (__fastcall **)(JPXStream *))this->_vptr$Stream + 19))(this);
    Dict::lookup(v1, "Length", 0);
    Object::operator=(&v33, &other);
    Object::~Object(&other);
    v2 = (const Dict *)(*((__int64 (__fastcall **)(JPXStream *))this->_vptr$Stream + 19))(this);
    Dict::lookup(v2, "ColorSpace", 0);
    Object::operator=(&v32, &other);
    Object::~Object(&other);
    v3 = (const Dict *)(*((__int64 (__fastcall **)(JPXStream *))this->_vptr$Stream + 19))(this);
    Dict::lookup(v3, "SMaskInData", 0);
    Object::operator=(&v34, &other);
    Object::~Object(&other);
  }
  Int = 4096;
  if ( Object::isInt(&v33) && Object::getInt(&v33) > 0 )
    Int = Object::getInt(&v33);
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
  if ( Object::isInt(&v34) )
    this->priv->smaskInData = Object::getInt(&v34);
  other.type = ObjType::objBool;
  v6 = Stream::toUnsignedChars(this->str, (int *)&other, Int, 4096);
  JPXStreamPrivate::init2(this->priv, CODEC_FORMAT::OPJ_CODEC_JP2, v6, other.type, isName);
  gfree(v6);
  priv = this->priv;
  image = (__int64)priv->image;
  if ( priv->image )
  {
    v9 = *(unsigned int *)(image + 16);
    v10 = (*(_DWORD *)(image + 16) ^ 4 | (*(_DWORD *)(image + 20) | 2) ^ 3) == 0;
    comps = *(opj_image_comp_t **)(image + 24);
    npixels = comps->w * comps->h;
    priv->npixels = npixels;
    priv->ncomps = v9;
    if ( ((_DWORD)v9 == 2 || v10 || (int)v9 >= 5) && !priv->smaskInData )
    {
      v9 = (unsigned int)(v9 - 1);
      priv->ncomps = v9;
    }
    v13 = isName;
    if ( (int)v9 > 0 )
    {
      data = comps->data;
      if ( data )
      {
        image = 0LL;
        while ( 1 )
        {
          v15 = image << 6;
          npixels = comps[image].w * comps[image].h;
          if ( (_DWORD)npixels != priv->npixels )
            break;
          v35 = image;
          v16 = *(unsigned int *)((char *)&comps->prec + v15);
          v17 = v16 - 8;
          v18 = 0;
          if ( (unsigned int)v16 <= 8 )
            v17 = 0;
          if ( *(OPJ_UINT32 *)((char *)&comps->sgnd + v15) )
            v18 = 1 << (LOBYTE(comps->prec) - 1);
          if ( (int)npixels > 0 )
          {
            v19 = *data;
            v31 = data;
            npixels = v17;
            v20 = v16;
            *(_BYTE *)v31 = adjustComp(v19, v17, v16, v18, v13);
            priv = this->priv;
            if ( priv->npixels < 2 )
            {
              v13 = isName;
            }
            else
            {
              v21 = 1LL;
              v22 = v20;
              v23 = v18;
              do
              {
                v24 = v17;
                v25 = v17;
                v26 = v22;
                v27 = adjustComp((*(OPJ_INT32 **)((char *)&priv->image->comps->data + v15))[v21], v24, v22, v23, isName);
                v22 = v26;
                v17 = v25;
                v13 = isName;
                *((_BYTE *)v31 + v21++) = v27;
                priv = this->priv;
                npixels = priv->npixels;
              }
              while ( v21 < npixels );
            }
          }
          image = v35 + 1;
          if ( v35 + 1 >= priv->ncomps )
            goto LABEL_38;
          comps = priv->image->comps;
          v9 = image << 6;
          data = comps[image].data;
          if ( !data )
            goto LABEL_37;
        }
        npixels = -1LL;
        error(ErrorCategory::errSyntaxWarning, -1LL, "Component {0:d} has different WxH than component 0", image, v13);
      }
LABEL_37:
      (*((void (__fastcall **)(JPXStream *, __int64, __int64, __int64, _BOOL8))this->_vptr$Stream + 4))(
        this,
        npixels,
        v9,
        image,
        v13);
    }
  }
  else
  {
    priv->npixels = 0;
  }
LABEL_38:
  v28 = this->priv;
  *(_QWORD *)&v28->counter = 0LL;
  v28->inited = 1;
  Object::~Object(&v34);
  Object::~Object(&v32);
  Object::~Object(&v33);
}
