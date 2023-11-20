grimoire_edit proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 220h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     eax, cs:init
    test    eax, eax
    jnz     short loc_126F
    lea     rdi, aYouMustReadThe; "You must read the book before editing i"...
    call    _puts
    jmp     loc_1364
loc_126F:
    lea     rdi, aOffset; "Offset: "
    mov     eax, 0
    call    _printf
    call    read_int
    mov     [rbp+var_212], ax
    cmp     [rbp+var_212], 200h
    jbe     short loc_12A8
    lea     rdi, aYouCanTAddANew; "You can't add a new page."
    call    _puts
    jmp     loc_1364
loc_12A8:
    lea     rdi, aText; "Text: "
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+buf]
    mov     edx, 200h; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    mov     [rbp+var_214], ax
    cmp     [rbp+var_214], 0
    jnz     short loc_1300
    lea     rsi, aReceivedNothin; "Received nothing"
    lea     rdi, aRead; "read"
    call    error
    mov     edi, 1; status
    call    _exit
loc_1300:
    movzx   eax, [rbp+var_214]
    sub     eax, 1
    cdqe
    movzx   eax, [rbp+rax+buf]
    cmp     al, 0Ah
    jnz     short loc_1329
    movzx   eax, [rbp+var_214]
    sub     eax, 1
    mov     [rbp+var_214], ax
loc_1329:
    movzx   eax, [rbp+var_214]
    cdqe
    mov     [rbp+rax+buf], 0
    movzx   edx, [rbp+var_214]; n
    movzx   ecx, [rbp+var_212]
    lea     rax, text
    add     rcx, rax
    lea     rax, [rbp+buf]
    mov     rsi, rax; src
    mov     rdi, rcx; dest
    call    _memcpy
loc_1364:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_1378
    call    ___stack_chk_fail
locret_1378:
    leave
    retn
grimoire_edit endp

