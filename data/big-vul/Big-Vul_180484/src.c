static const char *skip( const char *in )
{
	while ( in && *in && (unsigned char) *in <= 32 )
		in++;
	return in;
}
