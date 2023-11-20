modify_policy_2_svc(mpol_arg *arg, struct svc_req *rqstp)
 {
     static generic_ret              ret;
     char                            *prime_arg;
    gss_buffer_desc                 client_name,
        service_name;
     OM_uint32                       minor_stat;
     kadm5_server_handle_t           handle;
     const char                      *errmsg = NULL;

    xdr_free(xdr_generic_ret, &ret);

    if ((ret.code = new_server_handle(arg->api_version, rqstp, &handle)))
        goto exit_func;

    if ((ret.code = check_handle((void *)handle)))
        goto exit_func;

    ret.api_version = handle->api_version;

    if (setup_gss_names(rqstp, &client_name, &service_name) < 0) {
        ret.code = KADM5_FAILURE;
        goto exit_func;
    }
    prime_arg = arg->rec.policy;

    if (CHANGEPW_SERVICE(rqstp) || !kadm5int_acl_check(handle->context,
                                                       rqst2name(rqstp),
                                                       ACL_MODIFY, NULL, NULL)) {
        log_unauth("kadm5_modify_policy", prime_arg,
                   &client_name, &service_name, rqstp);
        ret.code = KADM5_AUTH_MODIFY;
    } else {
        ret.code = kadm5_modify_policy((void *)handle, &arg->rec,
                                       arg->mask);
        if( ret.code != 0 )
            errmsg = krb5_get_error_message(handle->context, ret.code);

        log_done("kadm5_modify_policy",
                 ((prime_arg == NULL) ? "(null)" : prime_arg), errmsg,
                 &client_name, &service_name, rqstp);

         if (errmsg != NULL)
             krb5_free_error_message(handle->context, errmsg);
     }
     gss_release_buffer(&minor_stat, &client_name);
     gss_release_buffer(&minor_stat, &service_name);
exit_func:
     free_server_handle(handle);
     return &ret;
 }
