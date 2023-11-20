ImageStream::ImageStream(Stream *,int,int,int) proc
    push    rbx; Alternative name is 'ImageStream::ImageStream(Stream *, int, int, int)'
    mov     rbx, this
    mov     [rdi], strA
    mov     [rdi+8], edx
    mov     [rdi+0Ch], ecx
    mov     [rdi+10h], r8d
    mov     esi, ecx
    imul    esi, edx
    mov     [rdi+14h], esi
    mov     edi, esi
    imul    edi, r8d
    add     edi, 7
    sar     edi, 3
    mov     [this+18h], edi
    test    ecx, ecx
    jle     short loc_49DF43
    test    r8d, r8d
    jle     short loc_49DF43
    mov     r9d, edx
    mov     eax, 7FFFFFFFh
    xor     edx, edx
    div     r8d
    add     eax, 0FFFFFFF9h
    cmp     esi, eax
    jg      short loc_49DF43
    mov     eax, 7FFFFFFFh
    xor     edx, edx
    div     ecx
    cmp     eax, r9d
    jge     short loc_49DF4F
loc_49DF43:
    mov     dword ptr [this+18h], 0FFFFFFFFh
    mov     edi, 0FFFFFFFFh; count
loc_49DF4F:
    mov     esi, 1; size
    call    _Z22gmallocn_checkoverflowii; gmallocn_checkoverflow(int,int)
    mov     [this+20h], rax
    mov     edx, [this+10h]
    cmp     edx, 8
    jz      short loc_49DF9A
    mov     ecx, [this+0Ch]
    test    ecx, ecx
    jle     short loc_49DF8B
    mov     eax, [this+14h]
    lea     edi, [rax+7]
    and     edi, 0FFFFFFF8h
    cmp     edx, 1
    cmovnz  edi, eax
    mov     esi, [this+8]
    mov     eax, 7FFFFFFFh
    xor     edx, edx
    div     ecx
    cmp     esi, eax
    jle     short loc_49DF90
loc_49DF8B:
    mov     edi, 0FFFFFFFFh; count
loc_49DF90:
    mov     esi, 1; size
    call    _Z22gmallocn_checkoverflowii; gmallocn_checkoverflow(int,int)
loc_49DF9A:
    mov     [this+28h], rax
    mov     eax, [this+14h]
    mov     [this+30h], eax
    pop     this
    retn
ImageStream::ImageStream(Stream *,int,int,int) endp

