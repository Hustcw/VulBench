xmlReallocLoc proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    push    rax
    mov     ebx, ecx
    mov     r15, file
    mov     r12, size
    test    ptr, ptr
    jz      loc_435292
    mov     rbp, ptr
    cmp     cs:xmlMemInitialized, 0
    jnz     short loc_43518D
    call    xmlInitMemory
loc_43518D:
    lea     r13, [ptr-28h]
    mov     r14, [ptr-20h]
    mov     eax, cs:xmlMemStopAtBlock
    cmp     number, rax
    jnz     short loc_4351A5
    call    xmlMallocBreakpoint
loc_4351A5:
    cmp     dword ptr [p+0], 5AA5h
    jnz     loc_4352AD
    mov     [rsp+38h+var_34], ebx
    mov     dword ptr [ptr-28h], 0FFFFA55Ah
    mov     rdi, cs:xmlMemMutex; tok
    call    xmlMutexLock
    mov     rax, [ptr-18h]
    sub     cs:debugMemSize, rax
    add     cs:debugMemBlocks, 0FFFFFFFFFFFFFFFFh
    mov     rdi, cs:xmlMemMutex; tok
    call    xmlMutexUnlock
    lea     rsi, [size+28h]; size
    mov     rdi, p; ptr
    call    _realloc
    test    rax, rax
    jz      loc_4352B7
    mov     rbx, rax
    cmp     cs:xmlMemTraceBlockAt, ptr
    jnz     short loc_43522E
    mov     rdi, cs:xmlGenericErrorContext; ctx
    mov     rcx, [tmp+10h]
    mov     esi, offset aPReallocedLuLu; "%p : Realloced(%lu -> %lu) Ok\n"
    mov     rdx, ptr
    mov     r8, size
    xor     eax, eax
    call    cs:xmlGenericError
    call    xmlMallocBreakpoint
loc_43522E:
    mov     rax, 200005AA5h
    mov     [tmp], rax
    mov     [tmp+8], number
    mov     [tmp+10h], size
    mov     [tmp+18h], file
    mov     eax, [rsp+38h+var_34]
    mov     [tmp+20h], eax
    mov     rdi, cs:xmlMemMutex; tok
    call    xmlMutexLock
    add     size, cs:debugMemSize
    add     cs:debugMemBlocks, 1
    mov     cs:debugMemSize, r12
    cmp     r12, cs:debugMaxMemSize
    jbe     short loc_435280
    mov     cs:debugMaxMemSize, r12
loc_435280:
    mov     rdi, cs:xmlMemMutex; tok
    call    xmlMutexUnlock
    add     tmp, 28h ; '('
    jmp     short loc_4352C1
loc_435292:
    mov     ptr, size
    mov     rsi, file
    mov     edx, ebx
    add     rsp, 8
    pop     line
    pop     size
    pop     r13
    pop     r14
    pop     file
    pop     rbp
    jmp     xmlMallocLoc
loc_4352AD:
    mov     rdi, p; p
    call    debugmem_tag_error
    jmp     short loc_4352BF
loc_4352B7:
    mov     rdi, p; ptr
    call    _free
loc_4352BF:
    xor     ebx, ebx
loc_4352C1:
    mov     rax, rbx
    add     rsp, 8
    pop     rbx
    pop     r12
    pop     r13
    pop     number
    pop     file
    pop     ptr
    retn
xmlReallocLoc endp



xmlMemStrdupLoc proc
    push    rbp
    push    r15
    push    r14
    push    r12
    push    rbx
    mov     r12d, edx
    mov     rbp, file
    mov     r14, str
    call    _strlen
    mov     rbx, rax
    cmp     cs:xmlMemInitialized, 0
    jnz     short loc_435437
    call    xmlInitMemory
loc_435437:
    lea     rdi, [rbx+29h]; size
    call    _malloc
    test    rax, rax
    jz      loc_4354FD
    mov     r15, rax
    add     rbx, 1
    mov     rax, 300005AA5h
    mov     [p], rax
    mov     [p+10h], size
    mov     [p+18h], file
    mov     [p+20h], r12d
    mov     rdi, cs:xmlMemMutex; tok
    call    xmlMutexLock
    mov     ebp, cs:block
    add     ebp, 1
    add     size, cs:debugMemSize
    mov     cs:block, ebp
    add     cs:debugMemBlocks, 1
    mov     [p+8], rbp
    mov     cs:debugMemSize, rbx
    cmp     rbx, cs:debugMaxMemSize
    jbe     short loc_4354AE
    mov     cs:debugMaxMemSize, rbx
loc_4354AE:
    mov     rdi, cs:xmlMemMutex; tok
    call    xmlMutexUnlock
    add     p, 28h ; '('
    cmp     ebp, cs:xmlMemStopAtBlock
    jnz     short loc_4354CB
    call    xmlMallocBreakpoint
loc_4354CB:
    mov     rdi, s; dest
    mov     rsi, str; src
    call    _strcpy
    cmp     cs:xmlMemTraceBlockAt, s
    jnz     short loc_435500
    mov     rdi, cs:xmlGenericErrorContext; ctx
    mov     esi, offset aPStrdupOk; "%p : Strdup() Ok\n"
    mov     rdx, s
    xor     eax, eax
    call    cs:xmlGenericError
    call    xmlMallocBreakpoint
    jmp     short loc_435500
loc_4354FD:
    xor     r15d, r15d
loc_435500:
    mov     rax, r15
    pop     rbx
    pop     line
    pop     str
    pop     r15
    pop     rbp
    retn
xmlMemStrdupLoc endp



xmlMallocLoc proc
    push    rbp
    push    r15
    push    r14
    push    rbx
    push    rax
    mov     r15d, edx
    mov     rbp, file
    mov     r14, size
    cmp     cs:xmlMemInitialized, 0
    jnz     short loc_434EEE
    call    xmlInitMemory
loc_434EEE:
    lea     rdi, [size+28h]; size
    call    _malloc
    test    rax, rax
    jz      loc_434FAB
    mov     rbx, rax
    mov     rax, 100005AA5h
    mov     [p], rax
    mov     [p+10h], size
    mov     [p+18h], file
    mov     [p+20h], r15d
    mov     rdi, cs:xmlMemMutex; tok
    call    xmlMutexLock
    mov     ebp, cs:block
    add     ebp, 1
    mov     cs:block, ebp
    mov     [p+8], rbp
    mov     rax, cs:debugMemSize
    add     cs:debugMemBlocks, 1
    add     rax, size
    mov     cs:debugMemSize, rax
    cmp     rax, cs:debugMaxMemSize
    jbe     short loc_434F64
    mov     cs:debugMaxMemSize, rax
loc_434F64:
    mov     rdi, cs:xmlMemMutex; tok
    call    xmlMutexUnlock
    cmp     ebp, cs:xmlMemStopAtBlock
    jnz     short loc_434F7D
    call    xmlMallocBreakpoint
loc_434F7D:
    add     p, 28h ; '('
    cmp     cs:xmlMemTraceBlockAt, ret
    jnz     short loc_434FC1
    mov     rdi, cs:xmlGenericErrorContext; ctx
    mov     esi, offset aPMallocLuOk; "%p : Malloc(%lu) Ok\n"
    mov     rdx, ret
    mov     rcx, size
    xor     eax, eax
    call    cs:xmlGenericError
    call    xmlMallocBreakpoint
    jmp     short loc_434FC1
loc_434FAB:
    mov     rdi, cs:xmlGenericErrorContext; ctx
    xor     ebx, ebx
    mov     esi, offset aXmlmalloclocOu; "xmlMallocLoc : Out of free space\n"
    xor     eax, eax
    call    cs:xmlGenericError
loc_434FC1:
    mov     rax, rbx
    add     rsp, 8
    pop     rbx
    pop     size
    pop     line
    pop     rbp
    retn
xmlMallocLoc endp



xmlMallocAtomicLoc proc
    push    rbp
    push    r15
    push    r14
    push    rbx
    push    rax
    mov     r15d, edx
    mov     rbp, file
    mov     r14, size
    cmp     cs:xmlMemInitialized, 0
    jnz     short loc_43506E
    call    xmlInitMemory
loc_43506E:
    lea     rdi, [size+28h]; size
    call    _malloc
    test    rax, rax
    jz      loc_43512B
    mov     rbx, rax
    mov     rax, 400005AA5h
    mov     [p], rax
    mov     [p+10h], size
    mov     [p+18h], file
    mov     [p+20h], r15d
    mov     rdi, cs:xmlMemMutex; tok
    call    xmlMutexLock
    mov     ebp, cs:block
    add     ebp, 1
    mov     cs:block, ebp
    mov     [p+8], rbp
    mov     rax, cs:debugMemSize
    add     cs:debugMemBlocks, 1
    add     rax, size
    mov     cs:debugMemSize, rax
    cmp     rax, cs:debugMaxMemSize
    jbe     short loc_4350E4
    mov     cs:debugMaxMemSize, rax
loc_4350E4:
    mov     rdi, cs:xmlMemMutex; tok
    call    xmlMutexUnlock
    cmp     ebp, cs:xmlMemStopAtBlock
    jnz     short loc_4350FD
    call    xmlMallocBreakpoint
loc_4350FD:
    add     p, 28h ; '('
    cmp     cs:xmlMemTraceBlockAt, ret
    jnz     short loc_435141
    mov     rdi, cs:xmlGenericErrorContext; ctx
    mov     esi, offset aPMallocLuOk; "%p : Malloc(%lu) Ok\n"
    mov     rdx, ret
    mov     rcx, size
    xor     eax, eax
    call    cs:xmlGenericError
    call    xmlMallocBreakpoint
    jmp     short loc_435141
loc_43512B:
    mov     rdi, cs:xmlGenericErrorContext; ctx
    xor     ebx, ebx
    mov     esi, offset aXmlmallocatomi; "xmlMallocAtomicLoc : Out of free space"...
    xor     eax, eax
    call    cs:xmlGenericError
loc_435141:
    mov     rax, rbx
    add     rsp, 8
    pop     rbx
    pop     size
    pop     line
    pop     rbp
    retn
xmlMallocAtomicLoc endp

