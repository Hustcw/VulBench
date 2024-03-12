/* This is the base type that holds just about everything :-) */
struct asn1_string_st {
    int length;
    int type;
    unsigned char *data;
    /*
     * The value of the following field depends on the type being held.  It
     * is mostly being used for BIT_STRING so if the input data has a
     * non-zero 'unused bits' value, it will be handled correctly
     */
    long flags;
};
typedef struct IPAddressFamily_st {
    ASN1_OCTET_STRING *addressFamily;
    IPAddressChoice *ipAddressChoice;
} IPAddressFamily;
typedef struct asn1_string_st ASN1_OCTET_STRING;
