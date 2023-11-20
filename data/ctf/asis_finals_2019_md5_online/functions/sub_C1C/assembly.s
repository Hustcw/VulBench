sub_C1C proc
    push    ebp
    mov     ebp, esp
    push    ebx
    sub     esp, 214h
    call    sub_890
    add     ebx, (offset off_2F74 - $)
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    mov     eax, ds:(stdin_ptr - 2F74h)[ebx]
    mov     eax, [eax]
    sub     esp, 8
    push    0; buf
    push    eax; stream
    call    _setbuf
    add     esp, 10h
    mov     eax, ds:(stdout_ptr - 2F74h)[ebx]
    mov     eax, [eax]
    sub     esp, 8
    push    0; buf
    push    eax; stream
    call    _setbuf
    add     esp, 10h
    mov     eax, ds:(stderr_ptr - 2F74h)[ebx]
    mov     eax, [eax]
    sub     esp, 8
    push    0; buf
    push    eax; stream
    call    _setbuf
    add     esp, 10h
    sub     esp, 0Ch
    push    0; timer
    call    _time
    add     esp, 10h
    sub     esp, 0Ch
    push    eax; seed
    call    _srand
    add     esp, 10h
    sub     esp, 0Ch
    push    244h; size
    call    _malloc
    add     esp, 10h
    mov     edx, eax
    lea     eax, (unk_300C - 2F74h)[ebx]
    mov     [eax], edx
    lea     eax, (unk_300C - 2F74h)[ebx]
    mov     eax, [eax]
    lea     edx, (unk_300C - 2F74h)[ebx]
    mov     edx, [edx]
    add     edx, 40h ; '@'
    sub     edx, 4
    mov     [eax+240h], edx
    sub     esp, 8
    lea     eax, (aR - 2F74h)[ebx]; "r"
    push    eax; modes
    lea     eax, (aBannerTxt - 2F74h)[ebx]; "banner.txt"
    push    eax; filename
    call    _fopen
    add     esp, 10h
    mov     edx, eax
    lea     eax, (dword_3010 - 2F74h)[ebx]
    mov     [eax], edx
    lea     eax, (dword_3010 - 2F74h)[ebx]
    mov     eax, [eax]
    test    eax, eax
    jnz     short loc_D18
    sub     esp, 0Ch
    lea     eax, (aFopen_0 - 2F74h)[ebx]; "fopen"
    push    eax; s
    call    _perror
    add     esp, 10h
    sub     esp, 0Ch
    push    1; status
    call    _exit
loc_D18:
    sub     esp, 4
    push    200h; n
    push    0; c
    lea     eax, [ebp+s]
    push    eax; s
    call    _memset
    add     esp, 10h
    lea     eax, (dword_3010 - 2F74h)[ebx]
    mov     eax, [eax]
    push    eax; stream
    push    200h; n
    push    1; size
    lea     eax, [ebp+s]
    push    eax; ptr
    call    _fread
    add     esp, 10h
    sub     esp, 8
    lea     eax, [ebp+s]
    push    eax
    lea     eax, (aS - 2F74h)[ebx]; "%s"
    push    eax; format
    call    _printf
    add     esp, 10h
    nop
    mov     eax, [ebp+var_C]
    xor     eax, large gs:14h
    jz      short loc_D7B
    call    sub_FF0
loc_D7B:
    mov     ebx, [ebp+var_4]
    leave
    retn
sub_C1C endp

