sub_B0E proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     eax, cs:dword_202050
    cmp     eax, 5
    jle     short loc_B46
    lea     rdi, aYouCanTAddAnyM; "You can't add any more notes!"
    call    puts
    mov     edi, 0; status
    call    exit
loc_B46:
    mov     [rbp+var_C], 0
    jmp     short loc_B6D
loc_B4F:
    mov     eax, [rbp+var_C]
    shl     rax, 5
    mov     rdx, rax
    lea     rax, unk_202070
    mov     rax, [rdx+rax]
    test    rax, rax
    jz      short loc_B75
    add     [rbp+var_C], 1
loc_B6D:
    cmp     [rbp+var_C], 4
    jbe     short loc_B4F
    jmp     short loc_B76
loc_B75:
    nop
loc_B76:
    lea     rdi, aHowLongIsYourN; "How long is your note?"
    call    puts
    lea     rax, [rbp+var_10]
    mov     rsi, rax
    lea     rdi, aU; "%u"
    mov     eax, 0
    call    __isoc99_scanf
    cmp     [rbp+var_C], 80h
    jbe     short loc_BB9
    lea     rdi, aTooLong; "Too long!"
    call    puts
    mov     edi, 0; status
    call    exit
loc_BB9:
    mov     eax, [rbp+var_C]
    shl     rax, 5
    mov     rdx, rax
    lea     rax, unk_202070
    mov     qword ptr [rdx+rax], 1
    mov     eax, [rbp+var_10]
    add     eax, 1
    mov     eax, eax
    mov     rdi, rax; size
    call    malloc
    mov     rcx, rax
    mov     eax, [rbp+var_C]
    shl     rax, 5
    mov     rdx, rax
    lea     rax, unk_202078
    mov     [rdx+rax], rcx
    lea     rdi, aInputYourNoteN; "Input your note name and note content:"
    call    puts
    mov     eax, [rbp+var_C]
    shl     rax, 5
    mov     rdx, rax
    lea     rax, unk_202060
    add     rax, rdx
    mov     esi, 15h
    mov     rdi, rax
    call    sub_AD6
    mov     eax, [rbp+var_10]
    mov     ecx, eax
    mov     eax, [rbp+var_C]
    shl     rax, 5
    mov     rdx, rax
    lea     rax, unk_202078
    mov     rax, [rdx+rax]
    mov     rsi, rcx
    mov     rdi, rax
    call    sub_AD6
    mov     eax, cs:dword_202050
    add     eax, 1
    mov     cs:dword_202050, eax
    lea     rdi, aDone; "Done!"
    call    puts
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_C7C
    call    __stack_chk_fail
locret_C7C:
    leave
    retn
sub_B0E endp

