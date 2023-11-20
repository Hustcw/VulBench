void gd_egl_scanout(DisplayChangeListener *dcl,

                    uint32_t backing_id, bool backing_y_0_top,


                    uint32_t x, uint32_t y,

                    uint32_t w, uint32_t h)

{

    VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);



    vc->gfx.x = x;

    vc->gfx.y = y;

    vc->gfx.w = w;

    vc->gfx.h = h;

    vc->gfx.tex_id = backing_id;

    vc->gfx.y0_top = backing_y_0_top;



    eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,

                   vc->gfx.esurface, vc->gfx.ectx);



    if (vc->gfx.tex_id == 0 || vc->gfx.w == 0 || vc->gfx.h == 0) {

        gtk_egl_set_scanout_mode(vc, false);

        return;

    }



    gtk_egl_set_scanout_mode(vc, true);

    if (!vc->gfx.fbo_id) {

        glGenFramebuffers(1, &vc->gfx.fbo_id);

    }



    glBindFramebuffer(GL_FRAMEBUFFER_EXT, vc->gfx.fbo_id);

    glFramebufferTexture2DEXT(GL_FRAMEBUFFER_EXT, GL_COLOR_ATTACHMENT0_EXT,

                              GL_TEXTURE_2D, vc->gfx.tex_id, 0);

}