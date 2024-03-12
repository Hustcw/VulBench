/*
 * dtls1_max_handshake_message_len returns the maximum number of bytes
 * permitted in a DTLS handshake message for |s|. The minimum is 16KB, but
 * may be greater if the maximum certificate list size requires it.
 */
static size_t dtls1_max_handshake_message_len(const SSL *s)
{
    size_t max_len = DTLS1_HM_HEADER_LENGTH + SSL3_RT_MAX_ENCRYPTED_LENGTH;
    if (max_len < s->max_cert_list)
        return s->max_cert_list;
    return max_len;
}