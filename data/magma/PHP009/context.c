/* {{{ php_ifd_get16u
 * Convert a 16 bit unsigned value from file's native byte order */
static int php_ifd_get16u(void *value, int motorola_intel)
{
	if (motorola_intel) {
		return (((uchar *)value)[0] << 8) | ((uchar *)value)[1];
	} else {
		return (((uchar *)value)[1] << 8) | ((uchar *)value)[0];
	}
}
