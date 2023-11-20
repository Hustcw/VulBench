void PEM_dek_info(char *buf, const char *type, int len, char *str)
	{
	static const unsigned char map[17]="0123456789ABCDEF";
	long i;
	int j;

	strcat(buf,"DEK-Info: ");
	strcat(buf,type);
	strcat(buf,",");
	j=strlen(buf);
	for (i=0; i<len; i++)
		{
		buf[j+i*2]  =map[(str[i]>>4)&0x0f];
		buf[j+i*2+1]=map[(str[i]   )&0x0f];
		}
	buf[j+i*2]='\n';
	buf[j+i*2+1]='\0';
	}