xmlReallocLoc proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    push    rax
    mov     r13d, ecx
    mov     r15, file
    mov     r12, size
    test    ptr, ptr
    jz      loc_435303
    mov     rbx, ptr
    cmp     cs:xmlMemInitialized, 0
    jnz     short loc_43528E
    call    xmlInitMemory
loc_43528E:
    lea     rbp, [ptr-28h]
    mov     r14, [ptr-20h]
    mov     eax, cs:xmlMemStopAtBlock
    cmp     number, rax
    jnz     short loc_4352A6
    call    xmlMallocBreakpoint
loc_4352A6:
    cmp     dword ptr [p+0], 5AA5h
    jnz     short loc_43531F
    mov     dword ptr [ptr-28h], 0FFFFA55Ah
    mov     rdi, cs:xmlMemMutex; tok
    call    xmlMutexLock
    mov     rax, [ptr-18h]
    sub     cs:debugMemSize, rax
    add     cs:debugMemBlocks, 0FFFFFFFFFFFFFFFFh
    mov     rdi, cs:xmlMemMutex; tok
    call    xmlMutexUnlock
    cmp     size, 0FFFFFFFFFFFFFFD8h
    jb      short loc_43532F
    mov     rdi, cs:xmlGenericErrorContext; ctx
    xor     r13d, r13d
    mov     esi, offset aXmlrealloclocU; "xmlReallocLoc : Unsigned overflow\n"
    xor     eax, eax
    call    cs:xmlGenericError
    jmp     loc_4353DD
loc_435303:
    mov     ptr, size
    mov     rsi, file
    mov     edx, r13d
    add     rsp, 8
    pop     rbx
    pop     size
    pop     line
    pop     r14
    pop     file
    pop     rbp
    jmp     xmlMallocLoc
loc_43531F:
    mov     rdi, p; p
    call    debugmem_tag_error
loc_435327:
    xor     r13d, r13d
    jmp     loc_4353DD
loc_43532F:
    mov     [rsp+38h+var_34], r13d
    lea     rsi, [size+28h]; size
    mov     rdi, p; ptr
    call    _realloc
    test    rax, rax
    jz      loc_4353EF
    mov     r13, rax
    cmp     cs:xmlMemTraceBlockAt, ptr
    jnz     short loc_435379
    mov     rdi, cs:xmlGenericErrorContext; ctx
    mov     rcx, [tmp+10h]
    mov     esi, offset aPReallocedLuLu; "%p : Realloced(%lu -> %lu) Ok\n"
    mov     rdx, ptr
    mov     r8, size
    xor     eax, eax
    call    cs:xmlGenericError
    call    xmlMallocBreakpoint
loc_435379:
    mov     rax, 200005AA5h
    mov     [tmp+0], rax
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
    jbe     short loc_4353CD
    mov     cs:debugMaxMemSize, r12
loc_4353CD:
    mov     rdi, cs:xmlMemMutex; tok
    call    xmlMutexUnlock
    add     tmp, 28h ; '('
loc_4353DD:
    mov     rax, r13
    add     rsp, 8
    pop     ptr
    pop     r12
    pop     r13
    pop     number
    pop     file
    pop     rbp
    retn
loc_4353EF:
    mov     rdi, p; ptr
    call    _free
    jmp     loc_435327
xmlReallocLoc endp



xmlMemStrdupLoc proc
    push    rbp
    push    r15
    push    r14
    push    r12
    push    rbx
    mov     r15d, edx
    mov     r12, file
    mov     r14, str
    call    _strlen
    mov     rbx, rax
    lea     rbp, [rax+1]
    cmp     cs:xmlMemInitialized, 0
    jnz     short loc_43555B
    call    xmlInitMemory
loc_43555B:
    cmp     size, 0FFFFFFFFFFFFFFD8h
    jb      short loc_43557C
    mov     rdi, cs:xmlGenericErrorContext; ctx
    xor     ebx, ebx
    mov     esi, offset aXmlmemstrduplo; "xmlMemStrdupLoc : Unsigned overflow\n"
    xor     eax, eax
    call    cs:xmlGenericError
    jmp     loc_435647
loc_43557C:
    add     rbx, 29h ; ')'
    mov     rdi, rbx; size
    call    _malloc
    test    rax, rax
    jz      loc_435645
    mov     rbx, rax
    mov     rax, 300005AA5h
    mov     [p], rax
    mov     [p+10h], size
    mov     [p+18h], file
    mov     [p+20h], r15d
    mov     rdi, cs:xmlMemMutex; tok
    call    xmlMutexLock
    mov     r15d, cs:block
    add     r15d, 1
    add     size, cs:debugMemSize
    mov     cs:block, r15d
    add     cs:debugMemBlocks, 1
    mov     [p+8], r15
    mov     cs:debugMemSize, rbp
    cmp     rbp, cs:debugMaxMemSize
    jbe     short loc_4355F5
    mov     cs:debugMaxMemSize, rbp
loc_4355F5:
    mov     rdi, cs:xmlMemMutex; tok
    call    xmlMutexUnlock
    add     p, 28h ; '('
    cmp     r15d, cs:xmlMemStopAtBlock
    jnz     short loc_435613
    call    xmlMallocBreakpoint
loc_435613:
    mov     rdi, s; dest
    mov     rsi, str; src
    call    _strcpy
    cmp     cs:xmlMemTraceBlockAt, s
    jnz     short loc_435647
    mov     rdi, cs:xmlGenericErrorContext; ctx
    mov     esi, offset aPStrdupOk; "%p : Strdup() Ok\n"
    mov     rdx, s
    xor     eax, eax
    call    cs:xmlGenericError
    call    xmlMallocBreakpoint
    jmp     short loc_435647
loc_435645:
    xor     ebx, ebx
loc_435647:
    mov     rax, rbx
    pop     rbx
    pop     file
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
    jnz     short loc_434FAE
    call    xmlInitMemory
loc_434FAE:
    cmp     size, 0FFFFFFFFFFFFFFD8h
    jb      short loc_434FC7
    mov     rdi, cs:xmlGenericErrorContext
    xor     ebx, ebx
    mov     esi, offset aXmlmalloclocUn; "xmlMallocLoc : Unsigned overflow\n"
    jmp     loc_435092
loc_434FC7:
    lea     rdi, [size+28h]; size
    call    _malloc
    test    rax, rax
    jz      loc_435084
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
    jbe     short loc_43503D
    mov     cs:debugMaxMemSize, rax
loc_43503D:
    mov     rdi, cs:xmlMemMutex; tok
    call    xmlMutexUnlock
    cmp     ebp, cs:xmlMemStopAtBlock
    jnz     short loc_435056
    call    xmlMallocBreakpoint
loc_435056:
    add     p, 28h ; '('
    cmp     cs:xmlMemTraceBlockAt, ret
    jnz     short loc_43509A
    mov     rdi, cs:xmlGenericErrorContext; ctx
    mov     esi, offset aPMallocLuOk; "%p : Malloc(%lu) Ok\n"
    mov     rdx, ret
    mov     rcx, size
    xor     eax, eax
    call    cs:xmlGenericError
    call    xmlMallocBreakpoint
    jmp     short loc_43509A
loc_435084:
    mov     rdi, cs:xmlGenericErrorContext; ctx
    xor     ebx, ebx
    mov     esi, offset aXmlmalloclocOu; "xmlMallocLoc : Out of free space\n"
loc_435092:
    xor     eax, eax
    call    cs:xmlGenericError
loc_43509A:
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
    jnz     short loc_43514E
    call    xmlInitMemory
loc_43514E:
    cmp     size, 0FFFFFFFFFFFFFFD8h
    jb      short loc_435167
    mov     rdi, cs:xmlGenericErrorContext
    xor     ebx, ebx
    mov     esi, offset aXmlmallocatomi; "xmlMallocAtomicLoc : Unsigned overflow"...
    jmp     loc_435232
loc_435167:
    lea     rdi, [size+28h]; size
    call    _malloc
    test    rax, rax
    jz      loc_435224
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
    jbe     short loc_4351DD
    mov     cs:debugMaxMemSize, rax
loc_4351DD:
    mov     rdi, cs:xmlMemMutex; tok
    call    xmlMutexUnlock
    cmp     ebp, cs:xmlMemStopAtBlock
    jnz     short loc_4351F6
    call    xmlMallocBreakpoint
loc_4351F6:
    add     p, 28h ; '('
    cmp     cs:xmlMemTraceBlockAt, ret
    jnz     short loc_43523A
    mov     rdi, cs:xmlGenericErrorContext; ctx
    mov     esi, offset aPMallocLuOk; "%p : Malloc(%lu) Ok\n"
    mov     rdx, ret
    mov     rcx, size
    xor     eax, eax
    call    cs:xmlGenericError
    call    xmlMallocBreakpoint
    jmp     short loc_43523A
loc_435224:
    mov     rdi, cs:xmlGenericErrorContext; ctx
    xor     ebx, ebx
    mov     esi, offset aXmlmallocatomi_0; "xmlMallocAtomicLoc : Out of free space"...
loc_435232:
    xor     eax, eax
    call    cs:xmlGenericError
loc_43523A:
    mov     rax, rbx
    add     rsp, 8
    pop     rbx
    pop     size
    pop     line
    pop     rbp
    retn
xmlMallocAtomicLoc endp

