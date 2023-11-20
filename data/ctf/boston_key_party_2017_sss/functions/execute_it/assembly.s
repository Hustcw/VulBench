execute_it proc
    push    rbp
    mov     rbp, rsp
    push    r13
    push    r12
    push    rbx
    sub     rsp, 58h
    mov     rax, fs:28h
    mov     [rbp+var_28], rax
    xor     eax, eax
    mov     rax, cs:exec_guy
    test    rax, rax
    jnz     short loc_40111C
    mov     esi, 1; size
    mov     edi, 24h ; '$'; nmemb
    call    _calloc
    mov     cs:exec_guy, rax
    mov     rax, cs:exec_guy
    mov     cs:s_exec_guy, rax
    mov     rax, cs:exec_guy
    add     rax, 1
    mov     cs:m_exec_guy, rax
    mov     rax, cs:s_exec_guy
    mov     qword ptr [rax+14h], offset deny_command
    mov     rax, cs:s_exec_guy
    mov     qword ptr [rax+1Ch], offset exec_command
loc_40111C:
    movzx   eax, cs:byte_602240
    movsx   eax, al
    mov     [rbp+var_58], eax
    mov     rax, cs:m_exec_guy
    mov     [rbp+dest], rax
    cmp     [rbp+var_58], 0
    jnz     short loc_401145
    mov     rax, cs:s_exec_guy
    mov     [rbp+dest], rax
loc_401145:
    mov     edi, offset aWhatCommandDoY_0; "what command do you want to run?"
    call    _puts
    mov     edi, offset asc_401622; ">_ "
    mov     eax, 0
    call    _printf
    mov     edx, 100h; nbytes
    mov     esi, offset global; buf
    mov     edi, 0; fd
    call    _read
    mov     [rbp+var_54], eax
    mov     eax, [rbp+var_54]
    cdqe
    mov     ds:global[rax], 0
    mov     [rbp+s], offset global
    movzx   eax, cs:byte_602240
    test    al, al
    jz      short loc_4011F2
    mov     rax, [rbp+s]
    mov     rdi, rax; s
    call    _strlen
    mov     r13, rax
    mov     rax, cs:key
    mov     rdi, rax; s
    call    _strlen
    mov     r12d, eax
    mov     rbx, cs:key
    call    _EVP_md5
    mov     rdi, rax
    mov     rax, [rbp+s]
    sub     rsp, 8
    lea     rdx, [rbp+n]
    push    rdx
    mov     r9d, 0
    mov     r8, r13
    mov     rcx, rax
    mov     edx, r12d
    mov     rsi, rbx
    call    _HMAC
    add     rsp, 10h
    mov     [rbp+src], rax
    jmp     short loc_40124E
loc_4011F2:
    mov     rax, [rbp+s]
    mov     rdi, rax; s
    call    _strlen
    mov     r13, rax
    mov     rax, cs:key
    mov     rdi, rax; s
    call    _strlen
    mov     r12d, eax
    mov     rbx, cs:key
    call    _EVP_sha1
    mov     rdi, rax
    mov     rax, [rbp+s]
    sub     rsp, 8
    lea     rdx, [rbp+n]
    push    rdx
    mov     r9d, 0
    mov     r8, r13
    mov     rcx, rax
    mov     edx, r12d
    mov     rsi, rbx
    call    _HMAC
    add     rsp, 10h
    mov     [rbp+src], rax
loc_40124E:
    mov     eax, dword ptr [rbp+n]
    mov     edx, eax; n
    mov     rcx, [rbp+src]
    mov     rax, [rbp+dest]
    mov     rsi, rcx; src
    mov     rdi, rax; dest
    call    _memcpy
    mov     eax, dword ptr [rbp+n]
    add     eax, eax
    add     eax, 1
    mov     eax, eax
    mov     rsi, rax; size
    mov     edi, 1; nmemb
    call    _calloc
    mov     [rbp+s1], rax
    mov     eax, dword ptr [rbp+n]
    add     eax, eax
    add     eax, 1
    mov     eax, eax
    mov     rsi, rax; size
    mov     edi, 1; nmemb
    call    _calloc
    mov     [rbp+buf], rax
    mov     edi, offset aGimmeSignature; "gimme signature:\n>_ "
    mov     eax, 0
    call    _printf
    mov     eax, dword ptr [rbp+n]
    add     eax, eax
    add     eax, 1
    mov     edx, eax; nbytes
    mov     rax, [rbp+buf]
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    mov     [rbp+var_54], eax
    mov     dword ptr [rbp+n+4], 0
    jmp     short loc_4012FC
loc_4012D2:
    mov     eax, dword ptr [rbp+n+4]
    movsxd  rdx, eax
    mov     rax, [rbp+buf]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    cmp     al, 0Ah
    jnz     short loc_4012F8
    mov     eax, dword ptr [rbp+n+4]
    movsxd  rdx, eax
    mov     rax, [rbp+buf]
    add     rax, rdx
    mov     byte ptr [rax], 0
    jmp     short loc_40130B
loc_4012F8:
    add     dword ptr [rbp+n+4], 1
loc_4012FC:
    mov     eax, dword ptr [rbp+n]
    add     eax, eax
    lea     edx, [rax+1]
    mov     eax, dword ptr [rbp+n+4]
    cmp     edx, eax
    ja      short loc_4012D2
loc_40130B:
    mov     [rbp+var_5C], 0
    jmp     short loc_40134A
loc_401314:
    mov     edx, [rbp+var_5C]
    mov     rax, [rbp+src]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    movzx   eax, al
    mov     edx, [rbp+var_5C]
    add     edx, edx
    mov     ecx, edx
    mov     rdx, [rbp+s1]
    add     rcx, rdx
    mov     edx, eax
    mov     esi, offset a02x; "%02x"
    mov     rdi, rcx; s
    mov     eax, 0
    call    _sprintf
    add     [rbp+var_5C], 1
loc_40134A:
    mov     eax, dword ptr [rbp+n]
    cmp     [rbp+var_5C], eax
    jb      short loc_401314
    mov     rdx, [rbp+buf]
    mov     rax, [rbp+s1]
    mov     rsi, rdx; s2
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jz      short loc_40137D
    mov     rax, cs:m_exec_guy
    mov     rax, [rax+13h]
    mov     edi, offset global
    call    rax
    jmp     short loc_40138F
loc_40137D:
    mov     rax, cs:m_exec_guy
    mov     rax, [rax+1Bh]
    mov     edi, offset global
    call    rax
loc_40138F:
    mov     edi, offset byte_40165B; s
    call    _puts
    nop
    mov     rax, [rbp+var_28]
    xor     rax, fs:28h
    jz      short loc_4013AE
    call    ___stack_chk_fail
loc_4013AE:
    lea     rsp, [rbp-18h]
    pop     rbx
    pop     r12
    pop     r13
    pop     rbp
    retn
execute_it endp

