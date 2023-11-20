readpostsfromfile proc
    push    ebp
    mov     ebp, esp
    sub     esp, 158h
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    sub     esp, 8
    push    offset modes; "r"
    push    offset filename; "blogposts.txt"
    call    _fopen
    add     esp, 10h
    mov     [ebp+stream], eax
    cmp     [ebp+stream], 0
    jnz     short loc_8048C07
    sub     esp, 0Ch
    push    offset aCanTReadBlogPo; "Can't read blog posts!"
    call    _printf
    add     esp, 10h
    sub     esp, 0Ch
    push    1; status
    call    _exit
loc_8048C07:
    sub     esp, 4
    push    [ebp+stream]; stream
    push    140h; n
    lea     eax, [ebp+s]
    push    eax; s
    call    _fgets
    add     esp, 10h
    sub     esp, 4
    push    offset numposts
    push    offset aD; "%d"
    lea     eax, [ebp+s]
    push    eax
    call    ___isoc99_sscanf
    add     esp, 10h
    mov     [ebp+var_158], 0
    jmp     loc_8048D4F
loc_8048C4F:
    mov     eax, [ebp+var_158]
    mov     eax, ds:posts[eax*4]
    mov     [ebp+var_150], eax
    sub     esp, 4
    push    [ebp+stream]
    push    140h
    lea     eax, [ebp+s]
    push    eax
    call    readline
    add     esp, 10h
    mov     eax, [ebp+var_150]
    sub     esp, 4
    push    eax
    push    offset aD; "%d"
    lea     eax, [ebp+s]
    push    eax
    call    ___isoc99_sscanf
    add     esp, 10h
    sub     esp, 4
    push    [ebp+stream]
    push    140h
    lea     eax, [ebp+s]
    push    eax
    call    readline
    add     esp, 10h
    mov     eax, [ebp+var_150]
    lea     edx, [eax+4]
    sub     esp, 8
    lea     eax, [ebp+s]
    push    eax; src
    push    edx; dest
    call    _strcpy
    add     esp, 10h
    sub     esp, 4
    push    [ebp+stream]
    push    140h
    lea     eax, [ebp+s]
    push    eax
    call    readline
    add     esp, 10h
    mov     eax, [ebp+var_150]
    lea     edx, [eax+24h]
    sub     esp, 8
    lea     eax, [ebp+s]
    push    eax; src
    push    edx; dest
    call    _strcpy
    add     esp, 10h
    sub     esp, 4
    push    [ebp+stream]
    push    140h
    lea     eax, [ebp+s]
    push    eax
    call    readline
    add     esp, 10h
    mov     eax, [ebp+var_150]
    lea     edx, [eax+44h]
    sub     esp, 8
    lea     eax, [ebp+s]
    push    eax; src
    push    edx; dest
    call    _strcpy
    add     esp, 10h
    add     [ebp+var_158], 1
loc_8048D4F:
    mov     eax, ds:numposts
    cmp     [ebp+var_158], eax
    jl      loc_8048C4F
    sub     esp, 0Ch
    push    [ebp+stream]; stream
    call    _fclose
    add     esp, 10h
    mov     eax, [ebp+var_C]
    xor     eax, large gs:14h
    jz      short locret_8048D82
    call    ___stack_chk_fail
locret_8048D82:
    leave
    retn
readpostsfromfile endp

