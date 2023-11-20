xmlFAParseCharRange proc
    push    rbp
    push    rbx
    sub     rsp, 18h
    mov     rbx, ctxt
    mov     rsi, [rdi+8]; cur
    mov     al, [rsi]
    cmp     al, 5Bh ; '['
    jg      short loc_474BBB
    test    al, al
    jz      short loc_474BD4
    cmp     al, 5Bh ; '['
    jz      short loc_474BC3
loc_474BAB:
    lea     rdx, [rsp+28h+len]; len
    xor     edi, edi; ctxt
    call    xmlStringCurrentChar
    mov     ebp, eax
    jmp     short loc_474C16
loc_474BBB:
    cmp     al, 5Ch ; '\'
    jz      short loc_474BE5
    cmp     al, 5Dh ; ']'
    jnz     short loc_474BAB
loc_474BC3:
    mov     dword ptr [ctxt+10h], 5AAh
    mov     esi, offset aExpectingAChar; "Expecting a char range"
    jmp     loc_474D48
loc_474BD4:
    mov     dword ptr [ctxt+10h], 5AAh
    mov     esi, offset aExpecting_1; "Expecting ']'"
    jmp     loc_474D48
loc_474BE5:
    lea     rax, [rsi+1]
    mov     [ctxt+8], rax
    movzx   eax, byte ptr [rsi+1]
    lea     ecx, [cur-28h]; switch 86 cases
    cmp     cl, 55h
    ja      def_474C05; jumptable 0000000000474C05 default case, cases 44,47-62,64-90,95-109,111-113,115,117-122
    mov     ebp, 0Ah
    movzx   ecx, cl
def_474C05:
    jmp     ds:jpt_474C05[rcx*8]; switch jump
    mov     ebp, eax; jumptable 0000000000474C05 cases 40-43,45,46,63,91-94,123-125
loc_474C0E:
    mov     [rsp+28h+len], 1; jumptable 0000000000474C05 case 110
loc_474C16:
    mov     rax, [ctxt+8]
    cmp     ebp, 2Dh ; '-'
    jnz     short loc_474C36
    cmp     byte ptr [rax+1], 5Dh ; ']'
    jz      short loc_474C36
    mov     cl, [rax-1]
    cmp     cl, 5Bh ; '['
    jz      short loc_474C36
    cmp     cl, 5Eh ; '^'
    jnz     loc_474CDE
loc_474C36:
    movsxd  rcx, [rsp+28h+len]
    lea     rsi, [rax+rcx]
    mov     [ctxt+8], rsi
    cmp     byte ptr [rax+rcx], 2Dh ; '-'
    jnz     short loc_474C4F
    cmp     byte ptr [rsi+1], 5Dh ; ']'
    jnz     short loc_474C76
loc_474C4F:
    mov     rsi, [ctxt+30h]; atom
    mov     edx, [ctxt+14h]; neg
    mov     [rsp+28h+blockName], 0; blockName
    mov     rdi, ctxt; ctxt
    mov     ecx, 2; type
    mov     r8d, ebp; start
    mov     r9d, ebp; end
loc_474C6C:
    call    xmlRegAtomAddRange
    jmp     loc_474D50
loc_474C76:
    add     rsi, 1; cur
    mov     [ctxt+8], rsi
    mov     al, [rsi]
    cmp     al, 5Bh ; '['
    jg      short loc_474C8E
    test    al, al
    jz      short loc_474CD0
    cmp     al, 5Bh ; '['
    jz      short loc_474CD0
    jmp     short loc_474CEC
loc_474C8E:
    cmp     al, 5Dh ; ']'
    jz      short loc_474CD0
    cmp     al, 5Ch ; '\'
    jnz     short loc_474CEC
    lea     rcx, [rsi+1]
    mov     [ctxt+8], rcx
    movzx   edx, byte ptr [rsi+1]
    lea     esi, [cur-28h]; switch 86 cases
    cmp     sil, 55h
    ja      def_474C05; jumptable 0000000000474C05 default case, cases 44,47-62,64-90,95-109,111-113,115,117-122
    mov     eax, 0Ah
    movzx   esi, sil
    jmp     ds:jpt_474CB8[rsi*8]; switch jump
    mov     eax, edx; jumptable 0000000000474CB8 cases 40-43,45,46,63,91-94,123-125
loc_474CC1:
    mov     [rsp+28h+len], 1; jumptable 0000000000474CB8 case 110
    mov     edx, 1
    jmp     short loc_474D01
loc_474CD0:
    mov     dword ptr [ctxt+10h], 5AAh
    mov     esi, offset aExpectingTheEn; "Expecting the end of a char range"
    jmp     short loc_474D48
loc_474CDE:
    movsxd  rcx, [rsp+28h+len]
    add     rax, rcx
    mov     [ctxt+8], rax
    jmp     short loc_474D50
loc_474CEC:
    lea     rdx, [rsp+28h+len]; len
    xor     edi, edi; ctxt
    call    xmlStringCurrentChar
    movsxd  rdx, [rsp+28h+len]
    mov     rcx, [ctxt+8]
loc_474D01:
    add     rcx, rdx
    mov     [ctxt+8], rcx
    cmp     eax, ebp
    jge     short loc_474D1A
    mov     dword ptr [ctxt+10h], 5AAh
    mov     esi, offset unk_4DF10D
    jmp     short loc_474D48
loc_474D1A:
    mov     rsi, [ctxt+30h]
    mov     edx, [ctxt+14h]
    mov     [rsp+28h+blockName], 0
    mov     rdi, ctxt
    mov     ecx, 2
    mov     r8d, ebp
    mov     r9d, eax
    jmp     loc_474C6C
    mov     dword ptr [ctxt+10h], 5AAh; jumptable 0000000000474C05 default case, cases 44,47-62,64-90,95-109,111-113,115,117-122
    mov     esi, offset aInvalidEscapeV; "Invalid escape value"
loc_474D48:
    mov     rdi, ctxt; ctxt
    call    xmlRegexpErrCompile
loc_474D50:
    add     rsp, 18h
    pop     ctxt
    pop     rbp
    retn
    mov     ebp, 0Dh; jumptable 0000000000474C05 case 114
    jmp     loc_474C0E; jumptable 0000000000474C05 case 110
    mov     ebp, 9; jumptable 0000000000474C05 case 116
    jmp     loc_474C0E; jumptable 0000000000474C05 case 110
    mov     eax, 0Dh; jumptable 0000000000474CB8 case 114
    jmp     loc_474CC1; jumptable 0000000000474CB8 case 110
    mov     eax, 9; jumptable 0000000000474CB8 case 116
    jmp     loc_474CC1; jumptable 0000000000474CB8 case 110
xmlFAParseCharRange endp

