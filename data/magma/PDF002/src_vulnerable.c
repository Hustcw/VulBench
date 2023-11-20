void JPXStream::init() {
  Object oLen, cspace, smaskInData;
  if (getDict()) {
    oLen = getDict()->lookup("Length");
    cspace = getDict()->lookup("ColorSpace");
    smaskInData = getDict()->lookup("SMaskInData");
  }

  int bufSize = BUFFER_INITIAL_SIZE;
  if (oLen.isInt())
    bufSize = oLen.getInt();

  bool indexed = false;
  if (cspace.isArray() && cspace.arrayGetLength() > 0) {
    const Object cstype = cspace.arrayGet(0);
    if (cstype.isName("Indexed"))
      indexed = true;
  }

  priv->smaskInData = 0;
  if (smaskInData.isInt())
    priv->smaskInData = smaskInData.getInt();

  int length = 0;
  unsigned char *buf = str->toUnsignedChars(&length, bufSize);
  priv->init2(OPJ_CODEC_JP2, buf, length, indexed);
  gfree(buf);

  if (priv->image) {
    int numComps = priv->image->numcomps;
    int alpha = 0;
    if (priv->image->color_space == OPJ_CLRSPC_SRGB && numComps == 4) {
      numComps = 3;
      alpha = 1;
    } else if (priv->image->color_space == OPJ_CLRSPC_SYCC && numComps == 4) {
      numComps = 3;
      alpha = 1;
    } else if (numComps == 2) {
      numComps = 1;
      alpha = 1;
    } else if (numComps > 4) {
      numComps = 4;
      alpha = 1;
    } else {
      alpha = 0;
    }
    priv->npixels = priv->image->comps[0].w * priv->image->comps[0].h;
    priv->ncomps = priv->image->numcomps;
    if (alpha == 1 && priv->smaskInData == 0)
      priv->ncomps--;
    for (int component = 0; component < priv->ncomps; component++) {
      if (priv->image->comps[component].data == nullptr) {
        close();
        break;
      }
      const int componentPixels =
          priv->image->comps[component].w * priv->image->comps[component].h;
      if (componentPixels != priv->npixels) {
        error(errSyntaxWarning, -1,
              "Component {0:d} has different WxH than component 0", component);
        close();
        break;
      }
      unsigned char *cdata =
          (unsigned char *)priv->image->comps[component].data;
      int adjust = 0;
      int depth = priv->image->comps[component].prec;
      if (priv->image->comps[component].prec > 8)
        adjust = priv->image->comps[component].prec - 8;
      int sgndcorr = 0;
      if (priv->image->comps[component].sgnd)
        sgndcorr = 1 << (priv->image->comps[0].prec - 1);
      for (int i = 0; i < priv->npixels; i++) {
        int r = priv->image->comps[component].data[i];
        *(cdata++) = adjustComp(r, adjust, depth, sgndcorr, indexed);
      }
    }
  } else {
    priv->npixels = 0;
  }

  priv->counter = 0;
  priv->ccounter = 0;
  priv->inited = true;
}

