main proc
    push    rbp
    mov     rbp, rsp
    mov     edi, 20h ; ' '; size
    call    _malloc
    mov     cs:s2, rax
    lea     rsi, handler; handler
    mov     edi, 0Eh; sig
    call    _signal
    mov     edi, 28h ; '('; seconds
    call    _alarm
    call    sub_40128B
    mov     rax, cs:s2
    mov     eax, [rax+20h]
    cmp     eax, 796573h
    jnz     short loc_40139F
    lea     rdi, aWelcomeToWatSq; "Welcome to wat-sql!"
    call    _puts
    lea     rdi, aThisProjectWas; "This project was made as an extention t"...
    call    _puts
    lea     rdi, aValidQueriesAr; "Valid queries are read, write. You are "...
    call    _puts
    push    qword ptr ds:_gets
    push    0
    push    qword ptr ds:_exit
    push    offset sub_40115F
    retn
loc_40139F:
    mov     edi, 0; status
    call    _exit
main endp

