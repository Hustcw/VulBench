GfxGouraudTriangleShading *
GfxGouraudTriangleShading::parse(GfxResources *res, int typeA, Dict *dict,
                                 Stream *str, OutputDev *out,
                                 GfxState *gfxState) {
  GfxGouraudTriangleShading *shading;
  std::vector<std::unique_ptr<Function>> funcsA;
  int coordBits, compBits, flagBits, vertsPerRow, nRows;
  double xMin, xMax, yMin, yMax;
  double cMin[gfxColorMaxComps], cMax[gfxColorMaxComps];
  double xMul, yMul;
  double cMul[gfxColorMaxComps];
  GfxGouraudVertex *verticesA;
  int(*trianglesA)[3];
  int nComps, nVerticesA, nTrianglesA, vertSize, triSize;
  unsigned int x, y, flag;
  unsigned int c[gfxColorMaxComps];
  GfxShadingBitBuf *bitBuf;
  Object obj1;
  int i, j, k, state;

  obj1 = dict->lookup("BitsPerCoordinate");
  if (obj1.isInt()) {
    coordBits = obj1.getInt();
  } else {
    error(errSyntaxWarning, -1,
          "Missing or invalid BitsPerCoordinate in shading dictionary");
    return nullptr;
  }
  if (unlikely(coordBits <= 0)) {
    error(errSyntaxWarning, -1,
          "Invalid BitsPerCoordinate in shading dictionary");
    return nullptr;
  }
  obj1 = dict->lookup("BitsPerComponent");
  if (obj1.isInt()) {
    compBits = obj1.getInt();
  } else {
    error(errSyntaxWarning, -1,
          "Missing or invalid BitsPerComponent in shading dictionary");
    return nullptr;
  }
  if (unlikely(compBits <= 0 || compBits > 31)) {
    error(errSyntaxWarning, -1,
          "Invalid BitsPerComponent in shading dictionary");
    return nullptr;
  }
  flagBits = vertsPerRow = 0; // make gcc happy
  if (typeA == 4) {
    obj1 = dict->lookup("BitsPerFlag");
    if (obj1.isInt()) {
      flagBits = obj1.getInt();
    } else {
      error(errSyntaxWarning, -1,
            "Missing or invalid BitsPerFlag in shading dictionary");
      return nullptr;
    }
  } else {
    obj1 = dict->lookup("VerticesPerRow");
    if (obj1.isInt()) {
      vertsPerRow = obj1.getInt();
    } else {
      error(errSyntaxWarning, -1,
            "Missing or invalid VerticesPerRow in shading dictionary");
      return nullptr;
    }
  }
  obj1 = dict->lookup("Decode");
  if (obj1.isArray() && obj1.arrayGetLength() >= 6) {
    bool decodeOk = true;
    xMin = obj1.arrayGet(0).getNum(&decodeOk);
    xMax = obj1.arrayGet(1).getNum(&decodeOk);
    xMul = (xMax - xMin) / (pow(2.0, coordBits) - 1);
    yMin = obj1.arrayGet(2).getNum(&decodeOk);
    yMax = obj1.arrayGet(3).getNum(&decodeOk);
    yMul = (yMax - yMin) / (pow(2.0, coordBits) - 1);
    for (i = 0; 5 + 2 * i < obj1.arrayGetLength() && i < gfxColorMaxComps;
         ++i) {
      cMin[i] = obj1.arrayGet(4 + 2 * i).getNum(&decodeOk);
      cMax[i] = obj1.arrayGet(5 + 2 * i).getNum(&decodeOk);
      cMul[i] = (cMax[i] - cMin[i]) / (double)((1u << compBits) - 1);
    }
    nComps = i;

    if (!decodeOk) {
      error(errSyntaxWarning, -1,
            "Missing or invalid Decode array in shading dictionary");
      return nullptr;
    }
  } else {
    error(errSyntaxWarning, -1,
          "Missing or invalid Decode array in shading dictionary");
    return nullptr;
  }

  obj1 = dict->lookup("Function");
  if (!obj1.isNull()) {
    if (obj1.isArray()) {
      const int nFuncsA = obj1.arrayGetLength();
      if (nFuncsA > gfxColorMaxComps) {
        error(errSyntaxWarning, -1,
              "Invalid Function array in shading dictionary");
        return nullptr;
      }
      for (i = 0; i < nFuncsA; ++i) {
        Object obj2 = obj1.arrayGet(i);
        Function *f = Function::parse(&obj2);
        if (!f) {
          return nullptr;
        }
        funcsA.emplace_back(f);
      }
    } else {
      Function *f = Function::parse(&obj1);
      if (!f) {
        return nullptr;
      }
      funcsA.emplace_back(f);
    }
  }

  nVerticesA = nTrianglesA = 0;
  verticesA = nullptr;
  trianglesA = nullptr;
  vertSize = triSize = 0;
  state = 0;
  flag = 0; // make gcc happy
  bitBuf = new GfxShadingBitBuf(str);
  while (true) {
    if (typeA == 4) {
      if (!bitBuf->getBits(flagBits, &flag)) {
        break;
      }
    }
    if (!bitBuf->getBits(coordBits, &x) || !bitBuf->getBits(coordBits, &y)) {
      break;
    }
    for (i = 0; i < nComps; ++i) {
      if (!bitBuf->getBits(compBits, &c[i])) {
        break;
      }
    }
    if (i < nComps) {
      break;
    }
    if (nVerticesA == vertSize) {
      int oldVertSize = vertSize;
      vertSize = (vertSize == 0) ? 16 : 2 * vertSize;
      verticesA = (GfxGouraudVertex *)greallocn_checkoverflow(
          verticesA, vertSize, sizeof(GfxGouraudVertex));
      if (unlikely(!verticesA)) {
        error(errSyntaxWarning, -1,
              "GfxGouraudTriangleShading::parse: vertices size overflow");
        gfree(trianglesA);
        delete bitBuf;
        return nullptr;
      }
      memset(verticesA + oldVertSize, 0,
             (vertSize - oldVertSize) * sizeof(GfxGouraudVertex));
    }
    verticesA[nVerticesA].x = xMin + xMul * (double)x;
    verticesA[nVerticesA].y = yMin + yMul * (double)y;
    for (i = 0; i < nComps; ++i) {
      verticesA[nVerticesA].color.c[i] =
          dblToCol(cMin[i] + cMul[i] * (double)c[i]);
    }
    ++nVerticesA;
    bitBuf->flushBits();
    if (typeA == 4) {
      if (state == 0 || state == 1) {
        ++state;
      } else if (state == 2 || flag > 0) {
        if (nTrianglesA == triSize) {
          triSize = (triSize == 0) ? 16 : 2 * triSize;
          trianglesA =
              (int(*)[3])greallocn(trianglesA, triSize * 3, sizeof(int));
        }
        if (state == 2) {
          trianglesA[nTrianglesA][0] = nVerticesA - 3;
          trianglesA[nTrianglesA][1] = nVerticesA - 2;
          trianglesA[nTrianglesA][2] = nVerticesA - 1;
          ++state;
        } else if (flag == 1) {
          trianglesA[nTrianglesA][0] = trianglesA[nTrianglesA - 1][1];
          trianglesA[nTrianglesA][1] = trianglesA[nTrianglesA - 1][2];
          trianglesA[nTrianglesA][2] = nVerticesA - 1;
        } else { // flag == 2
          trianglesA[nTrianglesA][0] = trianglesA[nTrianglesA - 1][0];
          trianglesA[nTrianglesA][1] = trianglesA[nTrianglesA - 1][2];
          trianglesA[nTrianglesA][2] = nVerticesA - 1;
        }
        ++nTrianglesA;
      } else { // state == 3 && flag == 0
        state = 1;
      }
    }
  }
  delete bitBuf;
  if (typeA == 5 && nVerticesA > 0 && vertsPerRow > 0) {
    nRows = nVerticesA / vertsPerRow;
    nTrianglesA = (nRows - 1) * 2 * (vertsPerRow - 1);
    trianglesA =
        (int(*)[3])gmallocn_checkoverflow(nTrianglesA * 3, sizeof(int));
    if (unlikely(!trianglesA)) {
      gfree(verticesA);
      return nullptr;
    }
    k = 0;
    for (i = 0; i < nRows - 1; ++i) {
      for (j = 0; j < vertsPerRow - 1; ++j) {
        trianglesA[k][0] = i * vertsPerRow + j;
        trianglesA[k][1] = i * vertsPerRow + j + 1;
        trianglesA[k][2] = (i + 1) * vertsPerRow + j;
        ++k;
        trianglesA[k][0] = i * vertsPerRow + j + 1;
        trianglesA[k][1] = (i + 1) * vertsPerRow + j;
        trianglesA[k][2] = (i + 1) * vertsPerRow + j + 1;
        ++k;
      }
    }
  }

  shading = new GfxGouraudTriangleShading(
      typeA, verticesA, nVerticesA, trianglesA, nTrianglesA, std::move(funcsA));
  if (!shading->init(res, dict, out, gfxState)) {
    delete shading;
    return nullptr;
  }
  return shading;
}
