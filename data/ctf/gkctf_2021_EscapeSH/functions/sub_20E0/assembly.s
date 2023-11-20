sub_20E0 proc
    sub     rsp, 8
    lea     rdx, qword_204040
    mov     rax, [rdx]
    test    rax, rax
    jz      loc_2290
    movzx   r8d, byte ptr [rax]
    cmp     r8d, 70h ; 'p'
    jnz     short loc_2128
    cmp     byte ptr [rax+1], 77h ; 'w'
    jnz     short loc_2168
    cmp     byte ptr [rax+2], 64h ; 'd'
    jnz     short loc_2168
    cmp     byte ptr [rax+3], 0
    jnz     short loc_2168
    call    sub_18C0
    mov     eax, 1
    add     rsp, 8
    retn
loc_2128:
    lea     rdi, aEcho; "echo"
    mov     ecx, 5
    mov     rsi, rax
    repe cmpsb
    jz      short loc_217B
    cmp     r8d, 6Ch ; 'l'
    jnz     loc_22B9
    cmp     byte ptr [rax+1], 73h ; 's'
    jnz     loc_21E0
    cmp     byte ptr [rax+2], 0
    jnz     loc_21E0
    call    sub_19A0
    mov     eax, 1
    jmp     short loc_21D2
loc_2168:
    lea     rdi, aEcho; "echo"
    mov     ecx, 5
    mov     rsi, rax
    repe cmpsb
    jnz     short loc_21E0
loc_217B:
    lea     rax, unk_205B40
    mov     ecx, [rax]
    cmp     ecx, 1
    jle     loc_2278
    sub     ecx, 2
    lea     rax, [rdx+8]
    lea     rsi, [rdx+rcx*8+10h]
    jmp     short loc_21AD
loc_21A0:
    add     rax, 8
    cmp     rsi, rax
    jz      loc_2278
loc_21AD:
    mov     rdx, [rax]
    cmp     byte ptr [rdx], 3Eh ; '>'
    jnz     short loc_21A0
    movzx   ecx, byte ptr [rdx+1]
    test    cl, cl
    jz      short loc_21C8
    cmp     cl, 3Eh ; '>'
    jnz     short loc_21A0
    cmp     byte ptr [rdx+2], 0
    jnz     short loc_21A0
loc_21C8:
    call    sub_1EC0
    mov     eax, 1
loc_21D2:
    add     rsp, 8
    retn
loc_21E0:
    lea     rdi, aMkdir_0; "mkdir"
    mov     ecx, 6
    mov     rsi, rax
    repe cmpsb
    jz      loc_2307
    cmp     r8d, 77h ; 'w'
    jnz     short loc_2207
    cmp     byte ptr [rax+1], 63h ; 'c'
    jz      loc_22A0
loc_2207:
    lea     rdi, aClear; "clear"
    mov     ecx, 6
    mov     rsi, rax
    repe cmpsb
    jz      loc_2316
    lea     rdi, aHelp; "help"
    mov     ecx, 5
    mov     rsi, rax
    repe cmpsb
    jz      loc_2325
    lea     rdi, aMonitor; "monitor"
    mov     ecx, 8
    mov     rsi, rax
    repe cmpsb
    jz      loc_2334
    lea     rdi, aQuit; "quit"
    mov     ecx, 5
    mov     rsi, rax
    repe cmpsb
    jz      short loc_22DE
    lea     rdi, aNoHasThisComma; "No has this command!"
    call    puts
    xor     eax, eax
    jmp     loc_21D2
loc_2278:
    call    sub_1930
    mov     eax, 1
    add     rsp, 8
    retn
loc_2290:
    xor     eax, eax
    add     rsp, 8
    retn
loc_22A0:
    cmp     byte ptr [rax+2], 0
    jnz     loc_2207
    call    sub_1D60
    mov     eax, 1
    jmp     loc_21D2
loc_22B9:
    cmp     r8d, 63h ; 'c'
    jnz     loc_21E0
    cmp     byte ptr [rax+1], 64h ; 'd'
    jnz     short loc_22F0
    cmp     byte ptr [rax+2], 0
    jnz     short loc_22F0
    call    sub_1B90
    mov     eax, 1
    jmp     loc_21D2
loc_22DE:
    call    sub_20D0
    mov     eax, 1
    jmp     loc_21D2
loc_22F0:
    lea     rdi, aMkdir_0; "mkdir"
    mov     ecx, 6
    mov     rsi, rax
    repe cmpsb
    jnz     loc_2207
loc_2307:
    call    sub_1D10
    mov     eax, 1
    jmp     loc_21D2
loc_2316:
    call    sub_1DA0
    mov     eax, 1
    jmp     loc_21D2
loc_2325:
    call    sub_1DD0
    mov     eax, 1
    jmp     loc_21D2
loc_2334:
    call    sub_1410
    mov     eax, 1
    jmp     loc_21D2
sub_20E0 endp

