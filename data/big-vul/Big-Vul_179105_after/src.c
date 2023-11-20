setup_server_realm(krb5_principal sprinc)
{
    krb5_error_code     kret;
     kdc_realm_t         *newrealm;
 
     kret = 0;
    if (sprinc == NULL)
        return NULL;

     if (kdc_numrealms > 1) {
         if (!(newrealm = find_realm_data(sprinc->realm.data,
                                          (krb5_ui_4) sprinc->realm.length)))
            kret = ENOENT;
        else
            kdc_active_realm = newrealm;
    }
    else
        kdc_active_realm = kdc_realmlist[0];
    return(kret);
}
