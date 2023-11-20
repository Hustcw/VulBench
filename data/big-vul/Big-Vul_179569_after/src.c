hstore_from_arrays(PG_FUNCTION_ARGS)
{
	int32		buflen;
	HStore	   *out;
	Pairs	   *pairs;
	Datum	   *key_datums;
	bool	   *key_nulls;
	int			key_count;
	Datum	   *value_datums;
	bool	   *value_nulls;
	int			value_count;
	ArrayType  *key_array;
	ArrayType  *value_array;
	int			i;

	if (PG_ARGISNULL(0))
		PG_RETURN_NULL();

	key_array = PG_GETARG_ARRAYTYPE_P(0);

	Assert(ARR_ELEMTYPE(key_array) == TEXTOID);

	/*
	 * must check >1 rather than != 1 because empty arrays have 0 dimensions,
	 * not 1
	 */

	if (ARR_NDIM(key_array) > 1)
		ereport(ERROR,
				(errcode(ERRCODE_ARRAY_SUBSCRIPT_ERROR),
				 errmsg("wrong number of array subscripts")));

	deconstruct_array(key_array,
 					  TEXTOID, -1, false, 'i',
 					  &key_datums, &key_nulls, &key_count);
 
	/* see discussion in hstoreArrayToPairs() */
	if (key_count > MaxAllocSize / sizeof(Pairs))
		ereport(ERROR,
				(errcode(ERRCODE_PROGRAM_LIMIT_EXCEEDED),
			  errmsg("number of pairs (%d) exceeds the maximum allowed (%d)",
					 key_count, (int) (MaxAllocSize / sizeof(Pairs)))));

 	/* value_array might be NULL */
 
 	if (PG_ARGISNULL(1))
	{
		value_array = NULL;
		value_count = key_count;
		value_datums = NULL;
		value_nulls = NULL;
	}
	else
	{
		value_array = PG_GETARG_ARRAYTYPE_P(1);

		Assert(ARR_ELEMTYPE(value_array) == TEXTOID);

		if (ARR_NDIM(value_array) > 1)
			ereport(ERROR,
					(errcode(ERRCODE_ARRAY_SUBSCRIPT_ERROR),
					 errmsg("wrong number of array subscripts")));

		if ((ARR_NDIM(key_array) > 0 || ARR_NDIM(value_array) > 0) &&
			(ARR_NDIM(key_array) != ARR_NDIM(value_array) ||
			 ARR_DIMS(key_array)[0] != ARR_DIMS(value_array)[0] ||
			 ARR_LBOUND(key_array)[0] != ARR_LBOUND(value_array)[0]))
			ereport(ERROR,
					(errcode(ERRCODE_ARRAY_SUBSCRIPT_ERROR),
					 errmsg("arrays must have same bounds")));

		deconstruct_array(value_array,
						  TEXTOID, -1, false, 'i',
						  &value_datums, &value_nulls, &value_count);

		Assert(key_count == value_count);
	}

	pairs = palloc(key_count * sizeof(Pairs));

	for (i = 0; i < key_count; ++i)
	{
		if (key_nulls[i])
			ereport(ERROR,
					(errcode(ERRCODE_NULL_VALUE_NOT_ALLOWED),
					 errmsg("null value not allowed for hstore key")));

		if (!value_nulls || value_nulls[i])
		{
			pairs[i].key = VARDATA_ANY(key_datums[i]);
			pairs[i].val = NULL;
			pairs[i].keylen = hstoreCheckKeyLen(VARSIZE_ANY_EXHDR(key_datums[i]));
			pairs[i].vallen = 4;
			pairs[i].isnull = true;
			pairs[i].needfree = false;
		}
		else
		{
			pairs[i].key = VARDATA_ANY(key_datums[i]);
			pairs[i].val = VARDATA_ANY(value_datums[i]);
			pairs[i].keylen = hstoreCheckKeyLen(VARSIZE_ANY_EXHDR(key_datums[i]));
			pairs[i].vallen = hstoreCheckValLen(VARSIZE_ANY_EXHDR(value_datums[i]));
			pairs[i].isnull = false;
			pairs[i].needfree = false;
		}
	}

	key_count = hstoreUniquePairs(pairs, key_count, &buflen);

	out = hstorePairs(pairs, key_count, buflen);

	PG_RETURN_POINTER(out);
}
