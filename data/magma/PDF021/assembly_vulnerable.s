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
    test    r8d, r8d
    jle     short loc_4477EF
    mov     r9d, edx
    mov     eax, 7FFFFFFFh
    xor     edx, edx
    div     r8d
    add     eax, 0FFFFFFF9h
    cmp     esi, eax
    jg      short loc_4477EF
    mov     eax, 7FFFFFFFh
    xor     edx, edx
    idiv    ecx
    cmp     eax, r9d
    jge     short loc_4477FB
loc_4477EF:
    mov     dword ptr [this+18h], 0FFFFFFFFh
    mov     edi, 0FFFFFFFFh; count
loc_4477FB:
    mov     esi, 1; size
    call    _Z22gmallocn_checkoverflowii; gmallocn_checkoverflow(int,int)
    mov     [this+20h], rax
    mov     ecx, [this+10h]
    cmp     ecx, 8
    jz      short loc_447841
    mov     edi, [this+8]
    mov     eax, [this+14h]
    lea     esi, [rax+7]
    and     esi, 0FFFFFFF8h
    cmp     ecx, 1
    cmovnz  esi, eax
    mov     eax, 7FFFFFFFh
    xor     edx, edx
    idiv    dword ptr [this+0Ch]
    cmp     edi, eax
    mov     edi, 0FFFFFFFFh
    cmovle  edi, esi; count
    mov     esi, 1; size
    call    _Z22gmallocn_checkoverflowii; gmallocn_checkoverflow(int,int)
loc_447841:
    mov     [this+28h], rax
    mov     eax, [this+14h]
    mov     [this+30h], eax
    pop     this
    retn
ImageStream::ImageStream(Stream *,int,int,int) endp

