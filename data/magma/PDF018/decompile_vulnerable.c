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
  const AnnotPath *v15;
  PDFRectangle *v16;
  AnnotAppearanceBBox *v17;
  PDFRectangle *v18;
  int v19;
  PDFRectangle *v20;
  std::unique_ptr<AnnotAppearanceBBox> *v21;
  AnnotAppearanceBBox *v22;
  PDFRectangle *v23;
  AnnotAppearanceBBox *v24;
  AnnotAppearanceBBox *v25;
  const GooString *v26;
  Object *p_args;
  const GooString *v28;
  Object *v29;
  Dict *ResourcesDict;
  XRef *XRef;
  bool v32;
  AnnotColor *v33;
  AnnotAppearanceBBox *v34;
  AnnotAppearanceBBox *v35;
  AnnotAppearanceBBox *v36;
  AnnotAppearanceBBox *v37;
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
  AnnotAppearanceBuilder v50;
  double opacity;
  double xMax;
  Object *v53;
  Gfx *v54;
  Object __u[2];
  AnnotInk *v56;
  Object __args;
  std::unique_lock<std::recursive_mutex> v58;
  Object other;
  Object __t;

  v5 = gfx;
  v6 = this;
  if ( Annot::isVisible(this, printing) )
  {
    std::unique_lock<std::recursive_mutex>::unique_lock(&v58, &this->mutex);
    p_appearance = &this->appearance;
    if ( Object::isNull(&this->appearance) )
    {
      v53 = &this->appearance;
      v54 = gfx;
      p_rect = &this->rect;
      *(_QWORD *)&__args.type = std::unique_ptr<PDFRectangle>::get(&this->rect);
      std::make_unique<AnnotAppearanceBBox,PDFRectangle *>((PDFRectangle **)&__args);
      p_appearBBox = &this->appearBBox;
      std::unique_ptr<AnnotAppearanceBBox>::operator=(&this->appearBBox, (std::unique_ptr<AnnotAppearanceBBox> *)__u);
      std::unique_ptr<AnnotAppearanceBBox>::~unique_ptr((std::unique_ptr<AnnotAppearanceBBox> *)__u);
      opacity = this->opacity;
      AnnotAppearanceBuilder::AnnotAppearanceBuilder(&v50);
      AnnotAppearanceBuilder::append(&v50, "q\n");
      if ( std::unique_ptr<AnnotColor>::operator bool(&this->color) )
      {
        v10 = std::unique_ptr<AnnotColor>::get(&this->color);
        AnnotAppearanceBuilder::setDrawColor(&v50, v10, 0);
      }
      v11 = std::unique_ptr<AnnotBorder>::get(&this->border);
      AnnotAppearanceBuilder::setLineStyleForBorder(&v50, v11);
      v12 = std::unique_ptr<AnnotAppearanceBBox>::operator->(&this->appearBBox);
      *(_QWORD *)&__u[0].type = 0x3FF0000000000000LL;
      v13 = std::unique_ptr<AnnotBorder>::operator->(&this->border);
      *(_QWORD *)&__args.type = (*((double (__fastcall **)(AnnotBorder *))v13->_vptr$AnnotBorder + 4))(v13);
      std::max<double>((const double *)__u, (const double *)&__args);
      AnnotAppearanceBBox::setBorderWidth(v12, v3);
      if ( this->inkListLength > 0 )
      {
        v14 = 0.0;
        v56 = this;
        do
        {
          v15 = v6->inkList[*(_QWORD *)&v14];
          if ( AnnotPath::getCoordsLength(v15) )
          {
            xMax = v14;
            xMina = AnnotPath::getX(v15, 0);
            xMinb = xMina - std::unique_ptr<PDFRectangle>::operator->(p_rect)->x1;
            yMina = AnnotPath::getY(v15, 0);
            v16 = std::unique_ptr<PDFRectangle>::operator->(p_rect);
            AnnotAppearanceBuilder::appendf(&v50, "{0:.2f} {1:.2f} m\n", xMinb, yMina - v16->y1);
            v17 = std::unique_ptr<AnnotAppearanceBBox>::operator->(p_appearBBox);
            AnnotPath::getX(v15, 0);
            std::unique_ptr<PDFRectangle>::operator->(p_rect);
            yMinb = AnnotPath::getY(v15, 0);
            v18 = std::unique_ptr<PDFRectangle>::operator->(p_rect);
            AnnotAppearanceBBox::extendTo(v17, yMinb - v18->y1, v4);
            if ( AnnotPath::getCoordsLength(v15) >= 2 )
            {
              v19 = 1;
              do
              {
                xMinc = AnnotPath::getX(v15, v19);
                xMind = xMinc - std::unique_ptr<PDFRectangle>::operator->(p_rect)->x1;
                yMinc = AnnotPath::getY(v15, v19);
                v20 = std::unique_ptr<PDFRectangle>::operator->(p_rect);
                AnnotAppearanceBuilder::appendf(&v50, "{0:.2f} {1:.2f} l\n", xMind, yMinc - v20->y1);
                v21 = p_appearBBox;
                v22 = std::unique_ptr<AnnotAppearanceBBox>::operator->(p_appearBBox);
                AnnotPath::getX(v15, v19);
                std::unique_ptr<PDFRectangle>::operator->(p_rect);
                yMind = AnnotPath::getY(v15, v19);
                v23 = std::unique_ptr<PDFRectangle>::operator->(p_rect);
                v24 = v22;
                p_appearBBox = v21;
                AnnotAppearanceBBox::extendTo(v24, yMind - v23->y1, v4);
                ++v19;
              }
              while ( v19 < AnnotPath::getCoordsLength(v15) );
            }
            AnnotAppearanceBuilder::append(&v50, "S\n");
            v6 = v56;
            v14 = xMax;
          }
          ++*(_QWORD *)&v14;
        }
        while ( *(__int64 *)&v14 < v6->inkListLength );
      }
      AnnotAppearanceBuilder::append(&v50, "Q\n");
      v25 = std::unique_ptr<AnnotAppearanceBBox>::operator->(p_appearBBox);
      AnnotAppearanceBBox::getBBoxRect(v25, (double *)__u);
      if ( opacity == 1.0 )
      {
        v26 = AnnotAppearanceBuilder::buffer(&v50);
        p_args = &__args;
        Annot::createForm(v6, v26, (double *)__u, 0, 0LL);
        p_appearance = v53;
        Object::operator=(v53, &__args);
      }
      else
      {
        p_args = &__t;
        v28 = AnnotAppearanceBuilder::buffer(&v50);
        Annot::createForm(v6, v28, (double *)__u, 1, 0LL);
        GooString::GooString((GooString *)&__args, "/GS0 gs\n/Fm0 Do");
        v29 = std::move<Object &>(&__t);
        ResourcesDict = Annot::createResourcesDict(v6, "Fm0", v29, "GS0", opacity, 0LL);
        Annot::createForm(v6, (const GooString *)&__args, (double *)__u, 0, ResourcesDict);
        p_appearance = v53;
        Object::operator=(v53, &other);
        Object::~Object(&other);
        std::string::~string(&__args);
      }
      v5 = v54;
      Object::~Object(p_args);
      AnnotAppearanceBuilder::~AnnotAppearanceBuilder(&v50);
    }
    XRef = Gfx::getXRef(v5);
    Object::fetch(p_appearance, XRef, 0);
    v32 = std::unique_ptr<AnnotAppearanceBBox>::operator bool(&v6->appearBBox);
    v33 = std::unique_ptr<AnnotColor>::get(&v6->color);
    if ( v32 )
    {
      v34 = std::unique_ptr<AnnotAppearanceBBox>::operator->(&v6->appearBBox);
      xMin = AnnotAppearanceBBox::getPageXMin(v34);
      v35 = std::unique_ptr<AnnotAppearanceBBox>::operator->(&v6->appearBBox);
      yMin = AnnotAppearanceBBox::getPageYMin(v35);
      v36 = std::unique_ptr<AnnotAppearanceBBox>::operator->(&v6->appearBBox);
      xMax = AnnotAppearanceBBox::getPageXMax(v36);
      v37 = std::unique_ptr<AnnotAppearanceBBox>::operator->(&v6->appearBBox);
      PageYMax = AnnotAppearanceBBox::getPageYMax(v37);
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
    Gfx::drawAnnot(v5, __u, 0LL, v33, xMin, yMin, xMax, opacity, Rotation);
    Object::~Object(__u);
    std::unique_lock<std::recursive_mutex>::~unique_lock(&v58);
  }
}