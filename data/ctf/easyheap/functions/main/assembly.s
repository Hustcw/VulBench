main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     rax, cs:stdout@@GLIBC_2_2_5
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setvbuf
    mov     rax, cs:stdin@@GLIBC_2_2_5
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setvbuf
loc_400C87:
    mov     eax, 0
    call    menu
    lea     rax, [rbp+buf]
    mov     edx, 8; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    lea     rax, [rbp+buf]
    mov     rdi, rax; nptr
    call    _atoi
    cmp     eax, 3
    jz      short loc_400CEF
    cmp     eax, 3
    jg      short loc_400CC9
    cmp     eax, 1
    jz      short loc_400CD7
    cmp     eax, 2
    jz      short loc_400CE3
    jmp     short loc_400D36
loc_400CC9:
    cmp     eax, 4
    jz      short loc_400CFB
    cmp     eax, 1305h
    jz      short loc_400D05
    jmp     short loc_400D36
loc_400CD7:
    mov     eax, 0
    call    create_heap
    jmp     short loc_400D41
loc_400CE3:
    mov     eax, 0
    call    edit_heap
    jmp     short loc_400D41
loc_400CEF:
    mov     eax, 0
    call    delete_heap
    jmp     short loc_400D41
loc_400CFB:
    mov     edi, 0; status
    call    _exit
loc_400D05:
    mov     rax, cs:magic
    cmp     rax, 1305h
    jbe     short loc_400D2A
    mov     edi, offset aCongrt; "Congrt !"
    call    _puts
    mov     eax, 0
    call    l33t
    jmp     short loc_400D41
loc_400D2A:
    mov     edi, offset aSoSad; "So sad !"
    call    _puts
    jmp     short loc_400D41
loc_400D36:
    mov     edi, offset aInvalidChoice; "Invalid Choice"
    call    _puts
    nop
loc_400D41:
    jmp     loc_400C87
main endp

