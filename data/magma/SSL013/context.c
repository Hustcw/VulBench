/*
 * From PSS AlgorithmIdentifier set public key parameters. If pkey isn't NULL
 * then the EVP_MD_CTX is setup and initialised. If it is NULL parameters are
 * passed to pkctx instead.
 */

int ossl_rsa_pss_to_ctx(EVP_MD_CTX *ctx, EVP_PKEY_CTX *pkctx,
                        const X509_ALGOR *sigalg, EVP_PKEY *pkey)
{
    int rv = -1;
    int saltlen;
    const EVP_MD *mgf1md = NULL, *md = NULL;
    RSA_PSS_PARAMS *pss;

    /* Sanity check: make sure it is PSS */
    if (OBJ_obj2nid(sigalg->algorithm) != EVP_PKEY_RSA_PSS) {
        ERR_raise(ERR_LIB_RSA, RSA_R_UNSUPPORTED_SIGNATURE_TYPE);
        return -1;
    }
    /* Decode PSS parameters */
    pss = ossl_rsa_pss_decode(sigalg);

    if (!ossl_rsa_pss_get_param(pss, &md, &mgf1md, &saltlen)) {
        ERR_raise(ERR_LIB_RSA, RSA_R_INVALID_PSS_PARAMETERS);
        goto err;
    }

    /* We have all parameters now set up context */
    if (pkey) {
        if (!EVP_DigestVerifyInit(ctx, &pkctx, md, NULL, pkey))
            goto err;
    } else {
        const EVP_MD *checkmd;
        if (EVP_PKEY_CTX_get_signature_md(pkctx, &checkmd) <= 0)
            goto err;
        if (EVP_MD_get_type(md) != EVP_MD_get_type(checkmd)) {
            ERR_raise(ERR_LIB_RSA, RSA_R_DIGEST_DOES_NOT_MATCH);
            goto err;
        }
    }

    if (EVP_PKEY_CTX_set_rsa_padding(pkctx, RSA_PKCS1_PSS_PADDING) <= 0)
        goto err;

    if (EVP_PKEY_CTX_set_rsa_pss_saltlen(pkctx, saltlen) <= 0)
        goto err;

    if (EVP_PKEY_CTX_set_rsa_mgf1_md(pkctx, mgf1md) <= 0)
        goto err;
    /* Carry on */
    rv = 1;

 err:
    RSA_PSS_PARAMS_free(pss);
    return rv;
}
