  void FillConstant(uint8_t *data, int stride, uint8_t fill_constant) {
     for (int h = 0; h < height_; ++h) {
       for (int w = 0; w < width_; ++w) {
        data[h * stride + w] = fill_constant;
       }
     }
   }
