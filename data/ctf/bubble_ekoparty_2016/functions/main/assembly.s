main proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 48h
    mov     [rbp+var_44], edi
    mov     [rbp+var_50], rsi
    mov     rax, fs:28h
    mov     [rbp+var_18], rax
    xor     eax, eax
    mov     [rbp+var_32], 0
    lea     rdi, s; "\t*** S.A.O. - Sorting Arrays Online **"...
    call    puts
    lea     rdi, aSendYourArrayS; "[!] Send your array size: "
    mov     eax, 0
    call    printf
    mov     rax, cs:stdout
    mov     rdi, rax; stream
    call    fflush
    mov     rax, cs:stdout
    mov     rdi, rax; stream
    call    fflush
    lea     rax, [rbp+var_30]
    mov     esi, 10h
    mov     rdi, rax
    call    sub_89A
    mov     cs:dword_202440, eax
    mov     eax, cs:dword_202440
    cmp     eax, 100h
    ja      loc_CAC
    mov     eax, cs:dword_202440
    test    eax, eax
    jz      loc_CAC
    lea     rdi, aSendYourNumber; "[!] Send your numbers: "
    mov     eax, 0
    call    printf
    mov     rax, cs:stdout
    mov     rdi, rax; stream
    call    fflush
    mov     [rbp+var_32], 0
    jmp     short loc_BEE
loc_BB7:
    movsx   ebx, [rbp+var_32]
    lea     rax, [rbp+var_30]
    mov     esi, 10h
    mov     rdi, rax
    call    sub_89A
    mov     ecx, eax
    movsxd  rax, ebx
    lea     rdx, ds:0[rax*4]
    lea     rax, dword_202040
    mov     [rdx+rax], ecx
    movzx   eax, [rbp+var_32]
    add     eax, 1
    mov     [rbp+var_32], ax
loc_BEE:
    movsx   edx, [rbp+var_32]
    mov     eax, cs:dword_202440
    cmp     edx, eax
    jbe     short loc_BB7
    mov     eax, cs:dword_202440
    mov     esi, eax
    lea     rdi, aSize0x08x; "Size: 0x%08x\n"
    mov     eax, 0
    call    printf
    mov     rax, cs:stdout
    mov     rdi, rax; stream
    call    fflush
    mov     eax, cs:dword_202440
    sub     eax, 1
    mov     edx, eax
    mov     esi, 0
    lea     rdi, dword_202040
    call    sub_A97
    lea     rdi, aSortedArray; "[+] Sorted array:"
    mov     eax, 0
    call    printf
    mov     rax, cs:stdout
    mov     rdi, rax; stream
    call    fflush
    mov     [rbp+var_32], 0
    jmp     short loc_C9E
loc_C68:
    movsx   eax, [rbp+var_32]
    cdqe
    lea     rdx, ds:0[rax*4]
    lea     rax, dword_202040
    mov     eax, [rdx+rax]
    mov     esi, eax
    lea     rdi, aU; " %u"
    mov     eax, 0
    call    printf
    movzx   eax, [rbp+var_32]
    add     eax, 1
    mov     [rbp+var_32], ax
loc_C9E:
    movsx   edx, [rbp+var_32]
    mov     eax, cs:dword_202440
    cmp     edx, eax
    jb      short loc_C68
loc_CAC:
    mov     eax, 0
    mov     rcx, [rbp+var_18]
    xor     rcx, fs:28h
    jz      short loc_CC5
    call    __stack_chk_fail
loc_CC5:
    add     rsp, 48h
    pop     rbx
    pop     rbp
    retn
main endp

