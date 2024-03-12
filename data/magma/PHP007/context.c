# define PHAR_GET_32(buffer, var) \
	memcpy(&var, buffer, sizeof(var)); \
	buffer += 4
