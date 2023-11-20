void __fastcall AnnotInk::draw(AnnotInk *this, Gfx *gfx, bool printing)
{
  double v3;
  double v4;
  Gfx *v5;
  AnnotInk *v6;
  Object *p_appearance;
  std::unique_ptr<PDFRectangle> *p_rect;
  std::unique_ptr<AnnotAppearanceBBox> *p_appearBBox;
  AnnotColor *v10;
  AnnotBorder *v11;
  AnnotAppearanceBBox *v12;
  AnnotBorder *v13;
  double v14;
  AnnotPath **inkList;
  const AnnotPath *v16;
  PDFRectangle *v17;
  AnnotAppearanceBBox *v18;
  PDFRectangle *v19;
  int v20;
  PDFRectangle *v21;
  std::unique_ptr<AnnotAppearanceBBox> *v22;
  AnnotAppearanceBBox *v23;
  PDFRectangle *v24;
  AnnotAppearanceBBox *v25;
  AnnotAppearanceBBox *v26;
  const GooString *v27;
  Object *p_args;
  const GooString *v29;
  Object *v30;
  Dict *ResourcesDict;
  XRef *XRef;
  bool v33;
  AnnotColor *v34;
  AnnotAppearanceBBox *v35;
  AnnotAppearanceBBox *v36;
  AnnotAppearanceBBox *v37;
  AnnotAppearanceBBox *v38;
  double PageYMax;
  int Rotation;
  double xMina;
  double xMinb;
  double xMinc;
  double xMind;
  double xMin;
  double yMina;
  double yMinb;
  double yMinc;
  double yMind;
  double yMin;
  AnnotAppearanceBuilder v51;
  double opacity;
  double xMax;
  Object *v54;
  Gfx *v55;
  Object __u[2];
  AnnotInk *v57;
  Object __args;
  std::unique_lock<std::recursive_mutex> v59;
  Object other;
  Object __t;

  v5 = gfx;
  v6 = this;
  if ( Annot::isVisible(this, printing) )
  {
    std::unique_lock<std::recursive_mutex>::unique_lock(&v59, &this->mutex);
    p_appearance = &this->appearance;
    if ( Object::isNull(&this->appearance) )
    {
      v54 = &this->appearance;
      v55 = gfx;
      p_rect = &this->rect;
      *(_QWORD *)&__args.type = std::unique_ptr<PDFRectangle>::get(&this->rect);
      std::make_unique<AnnotAppearanceBBox,PDFRectangle *>((PDFRectangle **)&__args);
      p_appearBBox = &this->appearBBox;
      std::unique_ptr<AnnotAppearanceBBox>::operator=(&this->appearBBox, (std::unique_ptr<AnnotAppearanceBBox> *)__u);
      std::unique_ptr<AnnotAppearanceBBox>::~unique_ptr((std::unique_ptr<AnnotAppearanceBBox> *)__u);
      opacity = this->opacity;
      AnnotAppearanceBuilder::AnnotAppearanceBuilder(&v51);
      AnnotAppearanceBuilder::append(&v51, "q\n");
      if ( std::unique_ptr<AnnotColor>::operator bool(&this->color) )
      {
        v10 = std::unique_ptr<AnnotColor>::get(&this->color);
        AnnotAppearanceBuilder::setDrawColor(&v51, v10, 0);
      }
      v11 = std::unique_ptr<AnnotBorder>::get(&this->border);
      AnnotAppearanceBuilder::setLineStyleForBorder(&v51, v11);
      v12 = std::unique_ptr<AnnotAppearanceBBox>::operator->(&this->appearBBox);
      *(_QWORD *)&__u[0].type = 0x3FF0000000000000LL;
      v13 = std::unique_ptr<AnnotBorder>::operator->(&this->border);
      *(_QWORD *)&__args.type = (*((double (__fastcall **)(AnnotBorder *))v13->_vptr$AnnotBorder + 4))(v13);
      std::max<double>((const double *)__u, (const double *)&__args);
      AnnotAppearanceBBox::setBorderWidth(v12, v3);
      if ( this->inkListLength > 0 )
      {
        v14 = 0.0;
        v57 = this;
        do
        {
          inkList = v6->inkList;
          v16 = inkList[*(_QWORD *)&v14];
          if ( v16 && AnnotPath::getCoordsLength(inkList[*(_QWORD *)&v14]) )
          {
            xMax = v14;
            xMina = AnnotPath::getX(v16, 0);
            xMinb = xMina - std::unique_ptr<PDFRectangle>::operator->(p_rect)->x1;
            yMina = AnnotPath::getY(v16, 0);
            v17 = std::unique_ptr<PDFRectangle>::operator->(p_rect);
            AnnotAppearanceBuilder::appendf(&v51, "{0:.2f} {1:.2f} m\n", xMinb, yMina - v17->y1);
            v18 = std::unique_ptr<AnnotAppearanceBBox>::operator->(p_appearBBox);
            AnnotPath::getX(v16, 0);
            std::unique_ptr<PDFRectangle>::operator->(p_rect);
            yMinb = AnnotPath::getY(v16, 0);
            v19 = std::unique_ptr<PDFRectangle>::operator->(p_rect);
            AnnotAppearanceBBox::extendTo(v18, yMinb - v19->y1, v4);
            if ( AnnotPath::getCoordsLength(v16) >= 2 )
            {
              v20 = 1;
              do
              {
                xMinc = AnnotPath::getX(v16, v20);
                xMind = xMinc - std::unique_ptr<PDFRectangle>::operator->(p_rect)->x1;
                yMinc = AnnotPath::getY(v16, v20);
                v21 = std::unique_ptr<PDFRectangle>::operator->(p_rect);
                AnnotAppearanceBuilder::appendf(&v51, "{0:.2f} {1:.2f} l\n", xMind, yMinc - v21->y1);
                v22 = p_appearBBox;
                v23 = std::unique_ptr<AnnotAppearanceBBox>::operator->(p_appearBBox);
                AnnotPath::getX(v16, v20);
                std::unique_ptr<PDFRectangle>::operator->(p_rect);
                yMind = AnnotPath::getY(v16, v20);
                v24 = std::unique_ptr<PDFRectangle>::operator->(p_rect);
                v25 = v23;
                p_appearBBox = v22;
                AnnotAppearanceBBox::extendTo(v25, yMind - v24->y1, v4);
                ++v20;
              }
              while ( v20 < AnnotPath::getCoordsLength(v16) );
            }
            AnnotAppearanceBuilder::append(&v51, "S\n");
            v6 = v57;
            v14 = xMax;
          }
          ++*(_QWORD *)&v14;
        }
        while ( *(__int64 *)&v14 < v6->inkListLength );
      }
      AnnotAppearanceBuilder::append(&v51, "Q\n");
      v26 = std::unique_ptr<AnnotAppearanceBBox>::operator->(p_appearBBox);
      AnnotAppearanceBBox::getBBoxRect(v26, (double *)__u);
      if ( opacity == 1.0 )
      {
        v27 = AnnotAppearanceBuilder::buffer(&v51);
        p_args = &__args;
        Annot::createForm(v6, v27, (double *)__u, 0, 0LL);
        p_appearance = v54;
        Object::operator=(v54, &__args);
      }
      else
      {
        p_args = &__t;
        v29 = AnnotAppearanceBuilder::buffer(&v51);
        Annot::createForm(v6, v29, (double *)__u, 1, 0LL);
        GooString::GooString((GooString *)&__args, "/GS0 gs\n/Fm0 Do");
        v30 = std::move<Object &>(&__t);
        ResourcesDict = Annot::createResourcesDict(v6, "Fm0", v30, "GS0", opacity, 0LL);
        Annot::createForm(v6, (const GooString *)&__args, (double *)__u, 0, ResourcesDict);
        p_appearance = v54;
        Object::operator=(v54, &other);
        Object::~Object(&other);
        std::string::~string(&__args);
      }
      v5 = v55;
      Object::~Object(p_args);
      AnnotAppearanceBuilder::~AnnotAppearanceBuilder(&v51);
    }
    XRef = Gfx::getXRef(v5);
    Object::fetch(p_appearance, XRef, 0);
    v33 = std::unique_ptr<AnnotAppearanceBBox>::operator bool(&v6->appearBBox);
    v34 = std::unique_ptr<AnnotColor>::get(&v6->color);
    if ( v33 )
    {
      v35 = std::unique_ptr<AnnotAppearanceBBox>::operator->(&v6->appearBBox);
      xMin = AnnotAppearanceBBox::getPageXMin(v35);
      v36 = std::unique_ptr<AnnotAppearanceBBox>::operator->(&v6->appearBBox);
      yMin = AnnotAppearanceBBox::getPageYMin(v36);
      v37 = std::unique_ptr<AnnotAppearanceBBox>::operator->(&v6->appearBBox);
      xMax = AnnotAppearanceBBox::getPageXMax(v37);
      v38 = std::unique_ptr<AnnotAppearanceBBox>::operator->(&v6->appearBBox);
      PageYMax = AnnotAppearanceBBox::getPageYMax(v38);
    }
    else
    {
      xMin = std::unique_ptr<PDFRectangle>::operator->(&v6->rect)->x1;
      yMin = std::unique_ptr<PDFRectangle>::operator->(&v6->rect)->y1;
      xMax = std::unique_ptr<PDFRectangle>::operator->(&v6->rect)->x2;
      PageYMax = std::unique_ptr<PDFRectangle>::operator->(&v6->rect)->y2;
    }
    opacity = PageYMax;
    Rotation = Annot::getRotation(v6);
    Gfx::drawAnnot(v5, __u, 0LL, v34, xMin, yMin, xMax, opacity, Rotation);
    Object::~Object(__u);
    std::unique_lock<std::recursive_mutex>::~unique_lock(&v59);
  }
}


void __fastcall AnnotInk::parseInkList(AnnotInk *this, Array *array)
{
  int Length;
  AnnotPath **v3;
  __int64 v4;
  AnnotPath *v5;
  Array *v6;
  Object v7[3];

  Length = Array::getLength(array);
  this->inkListLength = Length;
  v3 = (AnnotPath **)gmallocn(Length, 8, 0);
  this->inkList = v3;
  memset(v3, 0, 8LL * this->inkListLength);
  if ( this->inkListLength > 0 )
  {
    v4 = 0LL;
    do
    {
      Array::get(array, v4, 0);
      if ( Object::isArray(v7) )
      {
        v5 = (AnnotPath *)operator new(0x18uLL);
        v6 = Object::getArray(v7);
        AnnotPath::AnnotPath(v5, v6);
        this->inkList[v4] = v5;
      }
      Object::~Object(v7);
      ++v4;
    }
    while ( v4 < this->inkListLength );
  }
}
