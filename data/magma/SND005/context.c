const AIFF_CAF_CHANNEL_MAP *
aiff_caf_of_channel_layout_tag (int tag)
{	const AIFF_CAF_CHANNEL_MAP * curr_map ;
	unsigned k, len ;
	int channels = tag & 0xffff ;

	if (channels < 0 || channels >= ARRAY_LEN (map))
		return NULL ;

	curr_map = map [channels].map ;
	len = map [channels].len ;

	for (k = 0 ; k < len ; k++)
		if (curr_map [k].channel_layout_tag == tag)
			return curr_map + k ;

	return NULL ;
} /* aiff_caf_of_channel_layout_tag */
