av_cold void ff_vp8dsp_init_ppc(VP8DSPContext *c)

{

#if HAVE_ALTIVEC

    if (!(av_get_cpu_flags() & AV_CPU_FLAG_ALTIVEC))

        return;



    c->put_vp8_epel_pixels_tab[0][0][0] = put_vp8_pixels16_altivec;

    c->put_vp8_epel_pixels_tab[0][0][2] = put_vp8_epel16_h6_altivec;

    c->put_vp8_epel_pixels_tab[0][2][0] = put_vp8_epel16_v6_altivec;

    c->put_vp8_epel_pixels_tab[0][2][2] = put_vp8_epel16_h6v6_altivec;



    c->put_vp8_epel_pixels_tab[1][0][2] = put_vp8_epel8_h6_altivec;

    c->put_vp8_epel_pixels_tab[1][2][0] = put_vp8_epel8_v6_altivec;

    c->put_vp8_epel_pixels_tab[1][0][1] = put_vp8_epel8_h4_altivec;

    c->put_vp8_epel_pixels_tab[1][1][0] = put_vp8_epel8_v4_altivec;



    c->put_vp8_epel_pixels_tab[1][2][2] = put_vp8_epel8_h6v6_altivec;

    c->put_vp8_epel_pixels_tab[1][1][1] = put_vp8_epel8_h4v4_altivec;

    c->put_vp8_epel_pixels_tab[1][1][2] = put_vp8_epel8_h6v4_altivec;

    c->put_vp8_epel_pixels_tab[1][2][1] = put_vp8_epel8_h4v6_altivec;



    c->put_vp8_epel_pixels_tab[2][0][2] = put_vp8_epel4_h6_altivec;

    c->put_vp8_epel_pixels_tab[2][2][0] = put_vp8_epel4_v6_altivec;

    c->put_vp8_epel_pixels_tab[2][0][1] = put_vp8_epel4_h4_altivec;

    c->put_vp8_epel_pixels_tab[2][1][0] = put_vp8_epel4_v4_altivec;



    c->put_vp8_epel_pixels_tab[2][2][2] = put_vp8_epel4_h6v6_altivec;

    c->put_vp8_epel_pixels_tab[2][1][1] = put_vp8_epel4_h4v4_altivec;

    c->put_vp8_epel_pixels_tab[2][1][2] = put_vp8_epel4_h6v4_altivec;

    c->put_vp8_epel_pixels_tab[2][2][1] = put_vp8_epel4_h4v6_altivec;

#endif /* HAVE_ALTIVEC */

}
