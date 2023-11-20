void AnnotInk::draw(Gfx *gfx, bool printing) {
  double ca = 1;

  if (!isVisible(printing))
    return;

  annotLocker();
  if (appearance.isNull()) {
    appearBBox = std::make_unique<AnnotAppearanceBBox>(rect.get());
    ca = opacity;

    AnnotAppearanceBuilder appearBuilder;
    appearBuilder.append("q\n");

    if (color) {
      appearBuilder.setDrawColor(color.get(), false);
    }

    appearBuilder.setLineStyleForBorder(border.get());
    appearBBox->setBorderWidth(std::max(1., border->getWidth()));

    for (int i = 0; i < inkListLength; ++i) {
      const AnnotPath *path = inkList[i];
      if (path && path->getCoordsLength() != 0) {
        appearBuilder.appendf("{0:.2f} {1:.2f} m\n", path->getX(0) - rect->x1,
                              path->getY(0) - rect->y1);
        appearBBox->extendTo(path->getX(0) - rect->x1,
                             path->getY(0) - rect->y1);

        for (int j = 1; j < path->getCoordsLength(); ++j) {
          appearBuilder.appendf("{0:.2f} {1:.2f} l\n", path->getX(j) - rect->x1,
                                path->getY(j) - rect->y1);
          appearBBox->extendTo(path->getX(j) - rect->x1,
                               path->getY(j) - rect->y1);
        }

        appearBuilder.append("S\n");
      }
    }

    appearBuilder.append("Q\n");

    double bbox[4];
    appearBBox->getBBoxRect(bbox);
    if (ca == 1) {
      appearance = createForm(appearBuilder.buffer(), bbox, false, nullptr);
    } else {
      Object aStream = createForm(appearBuilder.buffer(), bbox, true, nullptr);

      GooString appearBuf("/GS0 gs\n/Fm0 Do");
      Dict *resDict =
          createResourcesDict("Fm0", std::move(aStream), "GS0", ca, nullptr);
      appearance = createForm(&appearBuf, bbox, false, resDict);
    }
  }

  // draw the appearance stream
  Object obj = appearance.fetch(gfx->getXRef());
  if (appearBBox) {
    gfx->drawAnnot(&obj, nullptr, color.get(), appearBBox->getPageXMin(),
                   appearBBox->getPageYMin(), appearBBox->getPageXMax(),
                   appearBBox->getPageYMax(), getRotation());
  } else {
    gfx->drawAnnot(&obj, nullptr, color.get(), rect->x1, rect->y1, rect->x2,
                   rect->y2, getRotation());
  }
}
