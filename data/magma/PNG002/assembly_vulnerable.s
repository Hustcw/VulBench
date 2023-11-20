png_image_free_function proc
    push    rbx
    sub     rsp, 30h
    mov     rsi, [argument]; ptr
    cmp     qword ptr [cp], 0
    jz      short loc_40721A
    mov     rbx, argument
    movups  xmm0, xmmword ptr [cp]
    movups  xmm1, xmmword ptr [cp+10h]
    movups  xmm2, xmmword ptr [cp+20h]
    movaps  [rsp+38h+var_18], xmm2
    movaps  [rsp+38h+var_28], xmm1
    movaps  xmmword ptr [rsp+38h+png_ptr], xmm0
    mov     rax, rsp
    mov     [rdi], rax
    mov     rdi, [rsp+38h+png_ptr]; png_ptr
    call    MAGMA_png_free
    test    byte ptr [rsp+38h+var_18+8], 1
    jnz     short loc_407222
    lea     rsi, [rsp+38h+png_ptr+8]; info_ptr_ptr
    mov     rdi, rsp; png_ptr_ptr
    xor     edx, edx; end_info_ptr_ptr
    call    MAGMA_png_destroy_read_struct
    or      byte ptr [image+18h], 8
    mov     eax, 1
    jmp     short loc_40721C
loc_40721A:
    xor     eax, eax
loc_40721C:
    add     rsp, 30h
    pop     rbx
    retn
loc_407222:
    mov     rdi, [rsp+38h+png_ptr]; png_ptr
    mov     esi, offset aSimplifiedWrit; "simplified write not supported"
    call    MAGMA_png_error
png_image_free_function endp



MAGMA_png_safe_execute proc
    push    r15
    push    r14
    push    rbx
    sub     rsp, 0F0h
    mov     r14, arg
    mov     r15, function
    mov     [rsp+108h+var_F8], image_in
    mov     rax, [rsp+108h+var_F8]
    mov     rax, [rax]
    mov     rax, [rax+10h]
    mov     [rsp+108h+var_F0], rax
    lea     rbx, [rsp+108h+env]
    mov     image_in, rbx; env
    call    __setjmp
    xor     ecx, ecx
    test    eax, eax
    setz    cl
    mov     [rsp+108h+var_FC], ecx
    cmp     [rsp+108h+var_FC], 0
    jz      short loc_40810D
    mov     rax, [rsp+108h+var_F8]
    mov     rax, [rax]
    mov     [rax+10h], rbx
    mov     rdi, arg
    call    function
    mov     [rsp+108h+var_FC], eax
loc_40810D:
    mov     rax, [rsp+108h+var_F0]
    mov     rcx, [rsp+108h+var_F8]
    mov     rcx, [rcx]
    mov     [rcx+10h], rax
    cmp     [rsp+108h+var_FC], 0
    jnz     short loc_40812F
    mov     rdi, [rsp+108h+var_F8]; image
    call    MAGMA_png_image_free
loc_40812F:
    mov     eax, [rsp+108h+var_FC]
    add     rsp, 0F0h
    pop     rbx
    pop     arg
    pop     function
    retn
MAGMA_png_safe_execute endp



MAGMA_png_image_free proc
    push    rbx
    test    image, image
    jz      short loc_407198
    mov     rbx, image
    mov     rax, [rdi]
    test    rax, rax
    jz      short loc_407198
    cmp     qword ptr [rax+10h], 0
    jz      short loc_40719A
loc_407198:
    pop     rbx
    retn
loc_40719A:
    mov     esi, offset png_image_free_function; function
    mov     rdi, image; image_in
    mov     rdx, image; arg
    call    MAGMA_png_safe_execute
    mov     qword ptr [image], 0
    pop     image
    retn
MAGMA_png_image_free endp

