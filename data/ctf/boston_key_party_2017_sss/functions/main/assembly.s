main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_4], edi
    mov     [rbp+var_10], rsi
    mov     rax, cs:stdout@@GLIBC_2_2_5
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setvbuf
    mov     rax, cs:stderr@@GLIBC_2_2_5
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setvbuf
    mov     cs:byte_602240, 1
    cmp     [rbp+var_4], 2
    jnz     short loc_4014CD
    mov     cs:byte_602240, 0
loc_4014CD:
    mov     eax, 0
    call    init_key
    mov     esi, offset ALARMhandler; handler
    mov     edi, 0Eh; sig
    call    _signal
    mov     edi, 0Ah; seconds
    call    _alarm
    mov     edi, offset aWelcomeToSecur; "Welcome to Secure Signed Shell"
    call    _puts
loc_4014FA:
    mov     eax, 0
    call    handle_it
    test    eax, eax
    jnz     short loc_40150A
    jmp     short loc_4014FA
loc_40150A:
    nop
    mov     eax, 0
    leave
    retn
main endp

