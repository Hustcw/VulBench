static int xan_huffman_decode(unsigned char *dest, int dest_len,

                              const unsigned char *src, int src_len)

{

    unsigned char byte = *src++;

    unsigned char ival = byte + 0x16;

    const unsigned char * ptr = src + byte*2;

    int ptr_len = src_len - 1 - byte*2;

    unsigned char val = ival;

    unsigned char *dest_end = dest + dest_len;

    GetBitContext gb;



    if (ptr_len < 0)

        return AVERROR_INVALIDDATA;



    init_get_bits(&gb, ptr, ptr_len * 8);



    while ( val != 0x16 ) {

        val = src[val - 0x17 + get_bits1(&gb) * byte];



        if ( val < 0x16 ) {

            if (dest >= dest_end)

                return 0;

            *dest++ = val;

            val = ival;

        }

    }



    return 0;

}
