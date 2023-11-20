multiSelect proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 98h
    test    p, p
    jz      loc_4885B2
    mov     r13, p
    mov     r14, [rsi+50h]
    test    pPrior, pPrior
    jz      loc_4885B2
    mov     r12, pDest
    mov     rbx, pParse
    mov     eax, [p+4]
    test    eax, 2000h
    jz      short loc_487BFB
    mov     cl, [p+0]
    add     cl, 7Bh ; '{'
    cmp     cl, 2
    jnb     loc_488661
loc_487BFB:
    test    eax, 100h
    jz      loc_4885E4
    mov     r15, [pParse]
    mov     rax, [pDest+20h]
    mov     [rsp+0C8h+var_68], rax
    movups  xmm0, xmmword ptr [pDest]
    movups  xmm1, xmmword ptr [pDest+10h]
    movaps  [rsp+0C8h+var_78], xmm1
    movaps  xmmword ptr [rsp+0C8h+p1], xmm0
    cmp     qword ptr [pPrior+48h], 0
    jnz     loc_4885FD
    cmp     qword ptr [pPrior+60h], 0
    jnz     loc_488616
    mov     rdi, pParse; pParse
    call    sqlite3GetVdbe
    mov     [rsp+0C8h+var_B8], v
    test    rax, rax
    jz      loc_48862F
    cmp     byte ptr [rsp+0C8h+p1], 0Ch
    jnz     short loc_487C82
    mov     rax, [p+20h]
    test    rax, rax
    jz      loc_48867A
    mov     edx, [rsp+0C8h+p1+4]; p1
    mov     ecx, [rax]; p2
    mov     rdi, [rsp+0C8h+var_B8]; p
    mov     esi, 70h ; 'p'; op
    call    sqlite3VdbeAddOp2
    mov     byte ptr [rsp+0C8h+p1], 0Eh
loc_487C82:
    test    byte ptr [p+5], 4
    jz      short loc_487CA7
    lea     rdx, [rsp+0C8h+p1]; pDest
    mov     rdi, pParse; pParse
    mov     rsi, p; p
    call    multiSelectValues
    test    eax, eax
    js      short loc_487CA7
loc_487C9D:
    mov     ebp, eax
    xor     r14d, r14d
    jmp     multi_select_end
loc_487CA7:
    mov     rax, [p+20h]
    test    rax, rax
    jz      loc_4885CB
    mov     rcx, [pPrior+20h]
    test    rcx, rcx
    jz      loc_4885CB
    mov     eax, [rax]
    cmp     eax, [rcx]
    jnz     loc_488648
    test    byte ptr [p+5], 20h
    jz      loc_487D95
    mov     rdi, p; p
    call    hasAnchor
    test    eax, eax
    jz      loc_487D95
    lea     rdx, [rsp+0C8h+p1]; pDest
    mov     rdi, pParse; pParse
    mov     rsi, p; p
    call    generateWithRecursiveQuery
    xor     r14d, r14d
    xor     ebp, ebp
    cmp     dword ptr [pParse+30h], 0
    jnz     multi_select_end
loc_487D05:
    test    byte ptr [p+4], 20h
    jz      multi_select_end
    mov     [rsp+0C8h+var_B0], pDelete
    cmp     qword ptr [p+58h], 0
    jnz     loc_4886DE
    mov     rax, [p+20h]
    mov     r14d, [rax]
    mov     [rsp+0C8h+var_C0], r15
    mov     rdi, r15; db
    mov     esi, r14d; N
    mov     edx, 1; X
    call    sqlite3KeyInfoAlloc
    test    rax, rax
    jz      loc_4882D7
    mov     r15, rax
    mov     [rsp+0C8h+var_C4], ebp
    mov     rbp, pDest
    test    r14d, r14d
    jle     loc_488227
    xor     r12d, r12d
    jmp     short loc_487D6D
loc_487D60:
    add     r12, 1
    cmp     r14d, r12d
    jz      loc_488227
loc_487D6D:
    mov     rdi, rbx; pParse
    mov     rsi, p; p
    mov     edx, r12d; iCol
    call    multiSelectCollSeq
    mov     [pKeyInfo+r12*8+20h], rax
    test    rax, rax
    jnz     short loc_487D60
    mov     rax, [rsp+0C8h+var_C0]
    mov     rax, [rax+10h]
    mov     [pKeyInfo+r12*8+20h], rax
    jmp     short loc_487D60
loc_487D95:
    cmp     qword ptr [p+48h], 0
    jz      short loc_487DB1
    mov     rdi, pParse; pParse
    mov     rsi, p; p
    mov     rdx, pDest; pDest
    call    multiSelectOrderBy
    mov     ebp, eax
    jmp     loc_48859E
loc_487DB1:
    cmp     qword ptr [pPrior+50h], 0
    jnz     short loc_487DE0
    mov     edx, offset aCompoundQuery; "COMPOUND QUERY"
    mov     rdi, pParse; pParse
    mov     esi, 1; bPush
    xor     eax, eax
    call    sqlite3VdbeExplain
    mov     edx, offset aLeftMostSubque; "LEFT-MOST SUBQUERY"
    mov     rdi, pParse; pParse
    mov     esi, 1; bPush
    xor     eax, eax
    call    sqlite3VdbeExplain
loc_487DE0:
    mov     al, [p+0]
    add     al, 7Bh ; '{'; switch 4 cases
    cmp     al, 3
    ja      def_487DF1; jumptable 0000000000487DF1 default case
    movzx   eax, al
def_487DF1:
    jmp     ds:jpt_487DF1[rax*8]; switch jump
    cmp     byte ptr [rsp+0C8h+p1], 1; jumptable 0000000000487DF1 cases -123,-121
    mov     [rsp+0C8h+var_C0], db
    jnz     loc_488162
    cmp     qword ptr [p+60h], 0
    jnz     loc_4886F7
    mov     r15d, [rsp+0C8h+p1+4]
    cmp     qword ptr [pPrior+48h], 0
    jz      loc_4881BB
    jmp     loc_4886C5
    mov     dword ptr [rsp+0C8h+var_58.eDest], 0; jumptable 0000000000487DF1 case -122
    cmp     qword ptr [pPrior+60h], 0
    jnz     loc_488710
    mov     eax, [p+8]
    mov     [pPrior+8], eax
    mov     eax, [p+0Ch]
    mov     [pPrior+0Ch], eax
    mov     rax, [p+60h]
    mov     [pPrior+60h], rax
    lea     rdx, [rsp+0C8h+p1]; pDest
    mov     rdi, pParse; pParse
    mov     rsi, pPrior; p
    call    sqlite3Select
    mov     qword ptr [pPrior+60h], 0
    test    eax, eax
    jnz     loc_487C9D
    mov     [rsp+0C8h+var_C0], db
    mov     qword ptr [p+50h], 0
    mov     edx, [pPrior+8]; p1
    mov     [p+8], edx
    mov     eax, [pPrior+0Ch]
    mov     [p+0Ch], eax
    test    edx, edx
    jz      loc_4884BB
    mov     rbp, [rsp+0C8h+var_B8]
    mov     rdi, rbp; p
    mov     esi, 14h; op
    call    sqlite3VdbeAddOp1
    mov     r15d, eax
    mov     esi, offset aJumpAheadIfLim; "Jump ahead if LIMIT reached"
    mov     rdi, rbp; p
    xor     eax, eax
    call    sqlite3VdbeComment
    mov     r8d, [p+0Ch]; p3
    test    r8d, r8d
    jz      loc_4884BE
    mov     edx, [p+8]; p1
    lea     ecx, [r8+1]; p2
    mov     rdi, rbp; p
    mov     esi, 9Ch; op
    call    sqlite3VdbeAddOp3
    jmp     loc_4884BE
    mov     edx, [pParse+34h]; jumptable 0000000000487DF1 case -120
    lea     eax, [tab1+2]
    mov     [pParse+34h], eax
    cmp     qword ptr [p+48h], 0
    jnz     loc_488729
    mov     rdi, [rsp+0C8h+var_B8]; p
    mov     esi, 70h ; 'p'; op
    mov     qword ptr [rsp+0C8h+iParm], tab1
    xor     ecx, ecx; p2
    call    sqlite3VdbeAddOp2
    cmp     dword ptr [p+14h], 0FFFFFFFFh
    jnz     loc_488742
    mov     [p+14h], eax
    mov     rdi, p; p
    call    findRightmost
    or      byte ptr [rax+4], 20h
    cmp     qword ptr [p+20h], 0
    jz      loc_48875B
    lea     rbp, [rsp+0C8h+var_58]
    mov     rdi, rbp; pDest
    mov     esi, 1; eDest
    mov     rdx, qword ptr [rsp+0C8h+iParm]; iParm
    call    sqlite3SelectDestInit
    mov     rdi, pParse; pParse
    mov     rsi, pPrior; p
    mov     rdx, rbp; pDest
    call    sqlite3Select
    test    eax, eax
    jnz     loc_487C9D
    mov     rax, qword ptr [rsp+0C8h+iParm]
    lea     ebp, [rax+1]
    mov     rdi, [rsp+0C8h+var_B8]; p
    mov     esi, 70h ; 'p'; op
    mov     edx, ebp; p1
    xor     ecx, ecx; p2
    call    sqlite3VdbeAddOp2
    cmp     dword ptr [p+18h], 0FFFFFFFFh
    jnz     loc_4887F1
    mov     [p+18h], eax
    mov     qword ptr [p+50h], 0
    mov     addr, [p+60h]
    mov     qword ptr [rsp+0C8h+p2], rax
    mov     qword ptr [p+60h], 0
    mov     [rsp+0C8h+var_90], ebp
    mov     [rsp+0C8h+var_58.iSDParm], ebp
    movzx   edi, byte ptr [p+0]; id
    call    sqlite3SelectOpName
    mov     edx, offset aSUsingTempBTre; "%s USING TEMP B-TREE"
    mov     rdi, pParse; pParse
    mov     esi, 1; bPush
    mov     rcx, rax
    xor     eax, eax
    call    sqlite3VdbeExplain
    lea     rdx, [rsp+0C8h+var_58]; pDest
    mov     [rsp+0C8h+var_A0], pParse
    mov     rdi, rbx; pParse
    mov     rsi, p; p
    call    sqlite3Select
    mov     [rsp+0C8h+var_C4], eax
    mov     rax, [p+50h]
    mov     [rsp+0C8h+var_B0], rax
    mov     [p+50h], pPrior
    movzx   eax, word ptr [pPrior+2]
    cmp     [p+2], ax
    jle     short loc_488003
    mov     [p+2], ax
loc_488003:
    mov     rsi, [p+60h]; p
    mov     rdi, db; db
    call    sqlite3ExprDelete
    mov     rax, qword ptr [rsp+0C8h+p2]
    mov     [p+60h], rax
    mov     ebp, [rsp+0C8h+var_C4]
    test    ebp, ebp
    mov     pPrior, [rsp+0C8h+var_B0]
    jnz     loc_48849C
    mov     [rsp+0C8h+var_C0], db
    cmp     qword ptr [p+20h], 0
    jz      loc_488823
    mov     rbx, [rsp+0C8h+var_A0]
    mov     rdi, rbx; pParse
    call    sqlite3VdbeMakeLabel
    mov     ebp, eax
    mov     qword ptr [rsp+0C8h+x], iBreak
    mov     rdi, rbx; pParse
    call    sqlite3VdbeMakeLabel
    mov     qword ptr [rsp+0C8h+p2], rax
    mov     rdi, rbx; pParse
    mov     rsi, p; p
    mov     edx, ebp; iBreak
    call    computeLimitRegisters
    mov     r14, [rsp+0C8h+var_B8]
    mov     rdi, r14; p
    mov     esi, 25h ; '%'; op
    mov     r15, qword ptr [rsp+0C8h+iParm]
    mov     edx, r15d; p1
    mov     ecx, ebp; p2
    call    sqlite3VdbeAddOp2
    mov     rdi, rbx; pParse
    call    sqlite3GetTempReg
    mov     ebp, eax
    mov     rdi, r14; p
    mov     esi, 82h; op
    mov     edx, r15d; p1
    mov     ecx, eax; p2
    call    sqlite3VdbeAddOp2
    mov     [rsp+0C8h+var_8C], eax
    mov     rdi, r14; p
    mov     esi, 1Dh; op
    mov     edx, [rsp+0C8h+var_90]; p1
    mov     rcx, qword ptr [rsp+0C8h+p2]; p2
    mov     r8d, ebp; p3
    xor     r9d, r9d; p4
    call    sqlite3VdbeAddOp4Int
    mov     rdi, rbx; pParse
    mov     esi, ebp; iReg
    call    sqlite3ReleaseTempReg
    lea     r9, [rsp+0C8h+p1]; pDest
    mov     rdi, rbx; pParse
    mov     rsi, p; p
    mov     edx, r15d; srcTab
    mov     ecx, 0; pSort
    mov     r8d, 0; pDistinct
    mov     rbx, qword ptr [rsp+0C8h+x]
    push    iBreak; iBreak
    mov     r1, qword ptr [rsp+0D0h+p2]
    push    iCont; iContinue
    call    selectInnerLoop
    add     rsp, 10h
    mov     rdi, r14; v
    mov     esi, ebp; x
    call    sqlite3VdbeResolveLabel
    mov     rdi, r14; p
    mov     esi, 5; op
    mov     edx, r15d; p1
    mov     ecx, [rsp+0C8h+var_8C]; p2
    call    sqlite3VdbeAddOp2
    mov     rdi, r14; v
    mov     esi, ebx; x
    call    sqlite3VdbeResolveLabel
    mov     rdi, r14; p
    mov     esi, 76h ; 'v'; op
    mov     edx, [rsp+0C8h+var_90]; p1
    xor     ecx, ecx; p2
    call    sqlite3VdbeAddOp2
    mov     rdi, r14; p
    mov     esi, 76h ; 'v'; op
    mov     edx, r15d; p1
    xor     ecx, ecx; p2
    call    sqlite3VdbeAddOp2
    mov     r15, [rsp+0C8h+var_C0]
    mov     ebp, [rsp+0C8h+var_C4]
    mov     r14, [rsp+0C8h+var_B0]
    cmp     qword ptr [p+58h], 0
    jnz     loc_4884A7
    jmp     loc_48856A
loc_488162:
    mov     edx, [pParse+34h]; p1
    lea     eax, [unionTab+1]
    mov     [pParse+34h], eax
    cmp     qword ptr [p+48h], 0
    jnz     loc_488774
    mov     rdi, [rsp+0C8h+var_B8]; p
    mov     esi, 70h ; 'p'; op
    mov     r15, unionTab
    xor     ecx, ecx; p2
    call    sqlite3VdbeAddOp2
    cmp     dword ptr [p+14h], 0FFFFFFFFh
    jnz     loc_48878D
    mov     [p+14h], eax
    mov     rdi, p; p
    call    findRightmost
    or      byte ptr [rax+4], 20h
    cmp     qword ptr [p+20h], 0
    jz      loc_4887A6
    cmp     qword ptr [pPrior+48h], 0
    jnz     loc_4886C5
loc_4881BB:
    lea     rbp, [rsp+0C8h+var_58]
    mov     rdi, rbp; pDest
    mov     esi, 1; eDest
    mov     edx, r15d; iParm
    call    sqlite3SelectDestInit
    mov     rdi, pParse; pParse
    mov     rsi, pPrior; p
    mov     rdx, rbp; pDest
    call    sqlite3Select
    test    eax, eax
    jz      short loc_4881F1
    mov     ebp, eax
    xor     r14d, r14d
    mov     unionTab, [rsp+0C8h+var_C0]
    jmp     multi_select_end
loc_4881F1:
    movzx   edi, byte ptr [p+0]; id
    cmp     edi, 85h
    jz      loc_4882F2
    mov     al, 2
    cmp     dil, 87h
    jz      loc_4882F4
    mov     edi, offset aPOpTkUnion; "p->op==TK_UNION"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 21009h; line
    call    ___assert_fail
loc_488227:
    mov     r12, pDest
    mov     rbx, [rsp+0C8h+var_B8]
    jmp     short loc_488254
loc_488240:
    cmp     dword ptr [pLoop+18h], 0
    jns     loc_488693
loc_48824B:
    mov     pLoop, [pLoop+50h]
    test    pLoop, pLoop
    jz      short loc_4882C4
loc_488254:
    mov     ebp, [pLoop+14h]
    test    ebp, ebp
    js      short loc_488240
    mov     rdi, rbx; p
    mov     esi, ebp; addr
    mov     edx, r14d; val
    call    sqlite3VdbeChangeP2
    mov     rdi, pKeyInfo; p
    call    sqlite3KeyInfoRef
    mov     rdi, rbx; p
    mov     esi, ebp; addr
    mov     rdx, rax; zP4
    mov     ecx, 0FFFFFFF7h; n
    call    sqlite3VdbeChangeP4
    mov     dword ptr [pLoop+14h], 0FFFFFFFFh
    mov     ebp, [pLoop+18h]
    test    ebp, ebp
    js      short loc_48824B
    mov     rdi, rbx; p
    mov     esi, ebp; addr
    mov     edx, r14d; val
    call    sqlite3VdbeChangeP2
    mov     rdi, pKeyInfo; p
    call    sqlite3KeyInfoRef
    mov     rdi, rbx; p
    mov     esi, ebp; addr
    mov     rdx, rax; zP4
    mov     ecx, 0FFFFFFF7h; n
    call    sqlite3VdbeChangeP4
    mov     dword ptr [pLoop+18h], 0FFFFFFFFh
    jmp     short loc_48824B
loc_4882C4:
    mov     rdi, pKeyInfo; p
    call    sqlite3KeyInfoUnref
    mov     pKeyInfo, [rsp+0C8h+var_C0]
    mov     ebp, [rsp+0C8h+var_C4]
    jmp     short loc_4882E8
loc_4882D7:
    mov     edi, 210A4h; lineno
    call    sqlite3NomemError
    mov     ebp, eax
    mov     r15, [rsp+0C8h+var_C0]
loc_4882E8:
    mov     nCol, [rsp+0C8h+var_B0]
    jmp     multi_select_end
loc_4882F2:
    mov     al, 1
loc_4882F4:
    mov     qword ptr [p+50h], 0
    mov     rbp, [p+60h]
    mov     qword ptr [p+60h], 0
    mov     [rsp+0C8h+var_58.eDest], al
    call    sqlite3SelectOpName
    mov     edx, offset aSUsingTempBTre; "%s USING TEMP B-TREE"
    mov     rdi, pParse; pParse
    mov     esi, 1; bPush
    mov     rcx, rax
    xor     eax, eax
    call    sqlite3VdbeExplain
    lea     rdx, [rsp+0C8h+var_58]; pDest
    mov     rdi, pParse; pParse
    mov     rsi, p; p
    call    sqlite3Select
    mov     [rsp+0C8h+var_C4], eax
    cmp     qword ptr [p+48h], 0
    jnz     loc_4887BF
    mov     rax, [p+50h]
    mov     [rsp+0C8h+var_B0], rax
    mov     [p+50h], pPrior
    mov     qword ptr [p+48h], 0
    cmp     byte ptr [p+0], 85h
    jnz     short loc_488377
    movsx   edi, word ptr [p+2]; a
    movsx   esi, word ptr [pPrior+2]; b
    call    sqlite3LogEstAdd
    mov     [p+2], ax
loc_488377:
    mov     [rsp+0C8h+var_A0], pParse
    mov     rsi, [p+60h]; p
    mov     rdi, [rsp+0C8h+var_C0]; db
    call    sqlite3ExprDelete
    mov     [p+60h], rbp
    mov     qword ptr [p+8], 0
    mov     al, byte ptr [rsp+0C8h+p1]
    cmp     r15d, [rsp+0C8h+p1+4]
    jz      short loc_4883A9
    cmp     al, 1
    jz      loc_4887D8
loc_4883A9:
    cmp     qword ptr [p+20h], 0
    mov     ebp, [rsp+0C8h+var_C4]
    mov     pPrior, [rsp+0C8h+var_B0]
    jnz     short loc_4883C8
    mov     rcx, [rsp+0C8h+var_C0]
    cmp     byte ptr [rcx+63h], 0
    jz      loc_48880A
loc_4883C8:
    cmp     al, 1
    jz      loc_488497
    mov     rax, [rsp+0C8h+var_C0]
    cmp     byte ptr [rax+63h], 0
    jnz     loc_488497
    mov     rbx, [rsp+0C8h+var_A0]
    mov     rdi, rbx; pParse
    call    sqlite3VdbeMakeLabel
    mov     ebp, eax
    mov     rdi, rbx; pParse
    call    sqlite3VdbeMakeLabel
    mov     qword ptr [rsp+0C8h+iParm], rax
    mov     rdi, rbx; pParse
    mov     rsi, p; p
    mov     edx, ebp; iBreak
    call    computeLimitRegisters
    mov     r14, [rsp+0C8h+var_B8]
    mov     rdi, r14; p
    mov     esi, 25h ; '%'; op
    mov     edx, r15d; p1
    mov     ecx, ebp; p2
    call    sqlite3VdbeAddOp2
    mov     rdi, r14; p
    call    sqlite3VdbeCurrentAddr
    mov     [rsp+0C8h+p2], eax
    lea     r9, [rsp+0C8h+p1]; pDest
    mov     rdi, rbx; pParse
    mov     rsi, p; p
    mov     edx, r15d; srcTab
    mov     ecx, 0; pSort
    mov     r8d, 0; pDistinct
    push    iBreak; iBreak
    mov     rbx, qword ptr [rsp+0D0h+iParm]
    push    iCont; iContinue
    call    selectInnerLoop
    add     rsp, 10h
    mov     rdi, r14; v
    mov     esi, ebx; x
    call    sqlite3VdbeResolveLabel
    mov     rdi, r14; p
    mov     esi, 5; op
    mov     edx, r15d; p1
    mov     ecx, [rsp+0C8h+p2]; p2
    call    sqlite3VdbeAddOp2
    mov     rdi, r14; v
    mov     esi, ebp; x
    mov     ebp, [rsp+0C8h+var_C4]
    call    sqlite3VdbeResolveLabel
    mov     rdi, r14; p
    mov     r14, [rsp+0C8h+var_B0]
    mov     esi, 76h ; 'v'; op
    mov     edx, r15d; p1
    xor     ecx, ecx; p2
    call    sqlite3VdbeAddOp2
loc_488497:
    mov     unionTab, [rsp+0C8h+var_C0]
loc_48849C:
    cmp     qword ptr [p+58h], 0
    jz      loc_48856A
loc_4884A7:
    mov     rbx, [rsp+0C8h+var_A0]
    cmp     dword ptr [rbx+30h], 0
    jnz     multi_select_end
    jmp     loc_487D05
loc_4884BB:
    xor     r15d, r15d
loc_4884BE:
    mov     edx, offset aUnionAll; "UNION ALL"
    mov     rdi, pParse; pParse
    mov     esi, 1; bPush
    xor     eax, eax
    call    sqlite3VdbeExplain
    lea     rdx, [rsp+0C8h+p1]; pDest
    mov     [rsp+0C8h+var_A0], pParse
    mov     rdi, rbx; pParse
    mov     rsi, p; p
    call    sqlite3Select
    mov     ebp, eax
    mov     rbx, [p+50h]
    mov     [p+50h], pPrior
    movsx   edi, word ptr [p+2]; a
    movsx   esi, word ptr [pPrior+2]; b
    call    sqlite3LogEstAdd
    mov     [p+2], ax
    mov     rax, [p+60h]
    test    rax, rax
    jz      short loc_488545
    mov     rdi, [rax+10h]; p
    lea     rsi, [rsp+0C8h+var_58]; pValue
    call    sqlite3ExprIsInteger
    test    eax, eax
    jz      short loc_488545
    mov     eax, dword ptr [rsp+0C8h+var_58.eDest]
    test    eax, eax
    jle     short loc_488545
    movsxd  rdi, eax; x
    mov     r14d, ebp
    movzx   ebp, word ptr [p+2]
    call    sqlite3LogEst
    cmp     bp, ax
    mov     ebp, r14d
    jle     short loc_488545
    mov     [p+2], ax
loc_488545:
    test    r15d, r15d
    jz      short loc_488557
    mov     rdi, [rsp+0C8h+var_B8]; p
    mov     esi, r15d; addr
    call    sqlite3VdbeJumpHere
loc_488557:
    mov     r15, [rsp+0C8h+var_C0]
    mov     r14, rbx
    cmp     qword ptr [p+58h], 0
    jnz     loc_4884A7
loc_48856A:
    mov     rbx, [rsp+0C8h+var_A0]
    mov     rdi, rbx; pParse
    call    sqlite3VdbeExplainPop
    cmp     dword ptr [rbx+30h], 0
    jz      loc_487D05
    mov     eax, [rsp+0C8h+p1+0Ch]
    mov     [pDest+0Ch], eax
    mov     eax, dword ptr [rsp+0C8h+var_78]
    mov     [pDest+10h], eax
    mov     rdi, r15; db
    mov     rsi, pDelete; p
    call    sqlite3SelectDelete
loc_48859E:
    mov     eax, ebp
    add     rsp, 98h
    pop     rbx
    pop     pDest
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_4885B2:
    mov     edi, offset aPPPprior; "p && p->pPrior"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 20F78h; line
    call    ___assert_fail
loc_4885CB:
    mov     edi, offset aPPelistPpriorP; "p->pEList && pPrior->pEList"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 20F97h; line
    call    ___assert_fail
loc_4885E4:
    mov     edi, offset aPSelflagsSfCom; "p->selFlags & SF_Compound"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 20F7Ah; line
    call    ___assert_fail
loc_4885FD:
    mov     edi, offset aPpriorPorderby; "pPrior->pOrderBy==0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 20F7Eh; line
    call    ___assert_fail
loc_488616:
    mov     edi, offset aPpriorPlimit0; "pPrior->pLimit==0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 20F7Fh; line
    call    ___assert_fail
loc_48862F:
    mov     edi, offset aV0_0; "v!=0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 20F82h; line
    call    ___assert_fail
loc_488648:
    mov     edi, offset aPPelistNexprPp; "p->pEList->nExpr==pPrior->pEList->nExpr"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 20F98h; line
    call    ___assert_fail
loc_488661:
    mov     edi, offset aPSelflagsSfRec; "(p->selFlags & SF_Recursive)==0 || p->o"...
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 20F79h; line
    call    ___assert_fail
loc_48867A:
    mov     edi, offset aPPelist; "p->pEList"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 20F87h; line
    call    ___assert_fail
loc_488693:
    mov     edi, offset aPloopAddropene; "pLoop->addrOpenEphm[1]<0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 210B4h; line
    call    ___assert_fail
    mov     edi, offset aPOpTkIntersect; jumptable 0000000000487DF1 default case
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 21036h; line
    call    ___assert_fail
loc_4886C5:
    mov     edi, offset aPpriorPorderby_0; "!pPrior->pOrderBy"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 20FFCh; line
    call    ___assert_fail
loc_4886DE:
    mov     edi, (offset aPtabPvtablePPP+14h); assertion
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 210A0h; line
    call    ___assert_fail
loc_4886F7:
    mov     edi, offset aPPlimit0; "p->pLimit==0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 20FEAh; line
    call    ___assert_fail
loc_488710:
    mov     edi, offset aPpriorPlimit; "!pPrior->pLimit"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 20FB3h; line
    call    ___assert_fail
loc_488729:
    mov     edi, offset aPPorderby0; "p->pOrderBy==0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 21044h; line
    call    ___assert_fail
loc_488742:
    mov     edi, offset aPAddropenephm0; "p->addrOpenEphm[0] == -1"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 21047h; line
    call    ___assert_fail
loc_48875B:
    mov     edi, offset aPPelist; "p->pEList"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 2104Ah; line
    call    ___assert_fail
loc_488774:
    mov     edi, offset aPPorderby0; "p->pOrderBy==0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 20FF1h; line
    call    ___assert_fail
loc_48878D:
    mov     edi, offset aPAddropenephm0; "p->addrOpenEphm[0] == -1"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 20FF3h; line
    call    ___assert_fail
loc_4887A6:
    mov     edi, offset aPPelist; "p->pEList"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 20FF6h; line
    call    ___assert_fail
loc_4887BF:
    mov     edi, offset aPPorderby0; "p->pOrderBy==0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 21015h; line
    call    ___assert_fail
loc_4887D8:
    mov     edi, offset aUniontabDestIs; "unionTab==dest.iSDParm || dest.eDest!=p"...
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 21024h; line
    call    ___assert_fail
loc_4887F1:
    mov     edi, offset aPAddropenephm1; "p->addrOpenEphm[1] == -1"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 21058h; line
    call    ___assert_fail
loc_48880A:
    mov     edi, offset aPPelistDbMallo; "p->pEList || db->mallocFailed"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 21025h; line
    call    ___assert_fail
loc_488823:
    mov     edi, offset aPPelist; "p->pEList"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 2106Fh; line
    call    ___assert_fail
multiSelect endp

