void ASessionDescription::getFormatType(
 size_t index, unsigned long *PT,
 AString *desc, AString *params) const {
 AString format;
    getFormat(index, &format);

 const char *lastSpacePos = strrchr(format.c_str(), ' ');
    CHECK(lastSpacePos != NULL);

 char *end;
 unsigned long x = strtoul(lastSpacePos + 1, &end, 10);
    CHECK_GT(end, lastSpacePos + 1);
    CHECK_EQ(*end, '\0');

 
     *PT = x;
 
    char key[32];
    snprintf(key, sizeof(key), "a=rtpmap:%lu", x);
 
     CHECK(findAttribute(index, key, desc));
 
    snprintf(key, sizeof(key), "a=fmtp:%lu", x);
     if (!findAttribute(index, key, params)) {
         params->clear();
     }
}
