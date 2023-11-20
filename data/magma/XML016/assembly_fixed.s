xmlFAParseCharRange proc
    push    rbp
    push    rbx
    sub     rsp, 18h
    mov     rbx, ctxt
    mov     rsi, [rdi+8]; cur
    mov     al, [rsi]
    cmp     al, 5Bh ; '['
    jg      short loc_474D4B
    test    al, al
    jz      short loc_474D64
    cmp     al, 5Bh ; '['
    jz      short loc_474D53
loc_474D3B:
    lea     rdx, [rsp+28h+len]; len
    xor     edi, edi; ctxt
    call    xmlStringCurrentChar
    mov     ebp, eax
    jmp     short loc_474DA6
loc_474D4B:
    cmp     al, 5Ch ; '\'
    jz      short loc_474D75
    cmp     al, 5Dh ; ']'
    jnz     short loc_474D3B
loc_474D53:
    mov     dword ptr [ctxt+10h], 5AAh
    mov     esi, offset aExpectingAChar; "Expecting a char range"
    jmp     loc_474ECE
loc_474D64:
    mov     dword ptr [ctxt+10h], 5AAh
    mov     esi, offset aExpecting_1; "Expecting ']'"
    jmp     loc_474ECE
loc_474D75:
    lea     rax, [rsi+1]
    mov     [ctxt+8], rax
    movzx   eax, byte ptr [rsi+1]
    lea     ecx, [cur-28h]; switch 86 cases
    cmp     cl, 55h
    ja      def_474D95; jumptable 0000000000474D95 default case, cases 44,47-62,64-90,95-109,111-113,115,117-122
    mov     ebp, 0Ah
    movzx   ecx, cl
def_474D95:
    jmp     ds:jpt_474D95[rcx*8]; switch jump
    mov     ebp, eax; jumptable 0000000000474D95 cases 40-43,45,46,63,91-94,123-125
loc_474D9E:
    mov     [rsp+28h+len], 1; jumptable 0000000000474D95 case 110
loc_474DA6:
    mov     rax, [ctxt+8]
    cmp     ebp, 2Dh ; '-'
    jnz     short loc_474DC6
    cmp     byte ptr [rax+1], 5Dh ; ']'
    jz      short loc_474DC6
    mov     cl, [rax-1]
    cmp     cl, 5Bh ; '['
    jz      short loc_474DC6
    cmp     cl, 5Eh ; '^'
    jnz     loc_474E6B
loc_474DC6:
    movsxd  rcx, [rsp+28h+len]
    lea     rsi, [rax+rcx]
    mov     [ctxt+8], rsi
    cmp     byte ptr [rax+rcx], 2Dh ; '-'
    jnz     short loc_474DDF
    cmp     byte ptr [rsi+1], 5Dh ; ']'
    jnz     short loc_474E06
loc_474DDF:
    mov     rsi, [ctxt+30h]; atom
    mov     edx, [ctxt+14h]; neg
    mov     [rsp+28h+blockName], 0; blockName
    mov     rdi, ctxt; ctxt
    mov     ecx, 2; type
    mov     r8d, ebp; start
    mov     r9d, ebp; end
loc_474DFC:
    call    xmlRegAtomAddRange
    jmp     loc_474ED6
loc_474E06:
    add     rsi, 1; cur
    mov     [ctxt+8], rsi
    mov     al, [rsi]
    cmp     al, 5Bh ; '['
    jg      short loc_474E1E
    test    al, al
    jz      short loc_474E5D
    cmp     al, 5Bh ; '['
    jz      short loc_474E5D
    jmp     short loc_474E79
loc_474E1E:
    cmp     al, 5Dh ; ']'
    jz      short loc_474E5D
    cmp     al, 5Ch ; '\'
    jnz     short loc_474E79
    lea     cur, [rsi+1]
    mov     [ctxt+8], rax
    movzx   ecx, byte ptr [rsi+1]
    lea     edx, [cur-28h]; switch 86 cases
    cmp     dl, 55h
    ja      def_474D95; jumptable 0000000000474D95 default case, cases 44,47-62,64-90,95-109,111-113,115,117-122
    mov     eax, 0Ah
    movzx   edx, dl
    jmp     ds:jpt_474E46[rdx*8]; switch jump
    mov     eax, ecx; jumptable 0000000000474E46 cases 40-43,45,46,63,91-94,123-125
loc_474E4F:
    mov     [rsp+28h+len], 1; jumptable 0000000000474E46 case 110
    cmp     eax, ebp
    jl      short loc_474E89
    jmp     short loc_474E97
loc_474E5D:
    mov     dword ptr [ctxt+10h], 5AAh
    mov     esi, offset aExpectingTheEn; "Expecting the end of a char range"
    jmp     short loc_474ECE
loc_474E6B:
    movsxd  rcx, [rsp+28h+len]
    add     rax, rcx
    mov     [ctxt+8], rax
    jmp     short loc_474ED6
loc_474E79:
    lea     rdx, [rsp+28h+len]; len
    xor     edi, edi; ctxt
    call    xmlStringCurrentChar
    cmp     eax, ebp
    jge     short loc_474E97
loc_474E89:
    mov     dword ptr [ctxt+10h], 5AAh
    mov     esi, offset unk_4DF37D
    jmp     short loc_474ECE
loc_474E97:
    movsxd  rcx, [rsp+28h+len]
    add     [ctxt+8], rcx
    mov     rsi, [ctxt+30h]
    mov     edx, [ctxt+14h]
    mov     [rsp+28h+blockName], 0
    mov     rdi, ctxt
    mov     ecx, 2
    mov     r8d, ebp
    mov     r9d, eax
    jmp     loc_474DFC
    mov     dword ptr [ctxt+10h], 5AAh; jumptable 0000000000474D95 default case, cases 44,47-62,64-90,95-109,111-113,115,117-122
    mov     esi, offset aInvalidEscapeV; "Invalid escape value"
loc_474ECE:
    mov     rdi, ctxt; ctxt
    call    xmlRegexpErrCompile
loc_474ED6:
    add     rsp, 18h
    pop     ctxt
    pop     rbp
    retn
    mov     ebp, 0Dh; jumptable 0000000000474D95 case 114
    jmp     loc_474D9E; jumptable 0000000000474D95 case 110
    mov     ebp, 9; jumptable 0000000000474D95 case 116
    jmp     loc_474D9E; jumptable 0000000000474D95 case 110
    mov     eax, 0Dh; jumptable 0000000000474E46 case 114
    jmp     loc_474E4F; jumptable 0000000000474E46 case 110
    mov     eax, 9; jumptable 0000000000474E46 case 116
    jmp     loc_474E4F; jumptable 0000000000474E46 case 110
xmlFAParseCharRange endp

