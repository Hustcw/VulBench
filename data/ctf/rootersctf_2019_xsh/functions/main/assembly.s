main proc
    lea     ecx, [esp+4]
    and     esp, 0FFFFFFF0h
    push    dword ptr [ecx-4]
    push    ebp
    mov     ebp, esp
    push    ebx
    push    ecx
    sub     esp, 260h
    call    __x86_get_pc_thunk_bx
    add     ebx, (offset _GLOBAL_OFFSET_TABLE_ - $)
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    mov     eax, ds:(stdout_ptr - 4000h)[ebx]
    mov     eax, [eax]
    push    0; n
    push    2; modes
    push    0; buf
    push    eax; stream
    call    _setvbuf
    add     esp, 10h
loc_13B4:
    sub     esp, 8
    push    64h ; 'd'; size
    lea     eax, [ebp+buf]
    push    eax; buf
    call    _getcwd
    add     esp, 10h
    test    eax, eax
    jnz     short loc_13E8
    sub     esp, 0Ch
    lea     eax, (aBye - 4000h)[ebx]; "BYE"
    push    eax; s
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    1; status
    call    _exit
loc_13E8:
    sub     esp, 8
    lea     eax, [ebp+buf]
    push    eax
    lea     eax, (a131mXsh0m034mS - 4000h)[ebx]; "\x1B[1;31m[xsh]\x1B[0m-\x1B[0;34m[%s]"...
    push    eax; format
    call    _printf
    add     esp, 10h
    mov     eax, ds:(stdin_ptr - 4000h)[ebx]
    mov     eax, [eax]
    sub     esp, 4
    push    eax; stream
    push    128h; n
    lea     eax, [ebp+s]
    push    eax; s
    call    _fgets
    add     esp, 10h
    mov     eax, ds:(stdout_ptr - 4000h)[ebx]
    mov     eax, [eax]
    sub     esp, 0Ch
    push    eax; stream
    call    _fflush
    add     esp, 10h
    sub     esp, 0Ch
    lea     eax, [ebp+s]
    push    eax
    call    run
    add     esp, 10h
    jmp     loc_13B4
main endp

