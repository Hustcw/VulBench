multiSelect proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 0A8h
    test    p, p
    jz      loc_488431
    mov     rbx, p
    mov     r14, [rsi+50h]
    test    pPrior, pPrior
    jz      loc_488431
    mov     r13, pDest
    mov     rbp, pParse
    mov     eax, [p+4]
    test    eax, 2000h
    jz      short loc_487A98
    mov     cl, [p]
    add     cl, 7Bh ; '{'
    cmp     cl, 2
    jnb     loc_4884F9
loc_487A98:
    test    eax, 100h
    jz      loc_48847C
    mov     r15, [pParse+0]
    mov     rax, [pDest+20h]
    mov     [rsp+0D8h+var_78], rax
    movups  xmm0, xmmword ptr [pDest+0]
    movups  xmm1, xmmword ptr [pDest+10h]
    movaps  [rsp+0D8h+var_88], xmm1
    movaps  xmmword ptr [rsp+0D8h+p1], xmm0
    cmp     qword ptr [pPrior+48h], 0
    jnz     loc_488495
    cmp     qword ptr [pPrior+60h], 0
    jnz     loc_4884AE
    mov     rdi, pParse; pParse
    call    sqlite3GetVdbe
    test    rax, rax
    jz      loc_4884C7
    mov     r12, rax
    cmp     byte ptr [rsp+0D8h+p1], 0Ch
    jnz     short loc_487B1A
    mov     rax, [p+20h]
    test    rax, rax
    jz      loc_488512
    mov     edx, [rsp+0D8h+p1+4]; p1
    mov     ecx, [rax]; p2
    mov     rdi, v; p
    mov     esi, 70h ; 'p'; op
    call    sqlite3VdbeAddOp2
    mov     byte ptr [rsp+0D8h+p1], 0Eh
loc_487B1A:
    test    byte ptr [p+5], 4
    jz      short loc_487B40
    lea     rdx, [rsp+0D8h+p1]; pDest
    mov     rdi, pParse; pParse
    mov     rsi, p; p
    call    multiSelectValues
    test    eax, eax
    js      short loc_487B40
loc_487B34:
    mov     ecx, eax
    xor     r14d, r14d
    mov     ebp, eax
    jmp     multi_select_end
loc_487B40:
    mov     rax, [p+20h]
    test    rax, rax
    jz      loc_48844A
    mov     rcx, [pPrior+20h]
    test    rcx, rcx
    jz      loc_48844A
    mov     eax, [rax]
    cmp     eax, [rcx]
    jnz     loc_4884E0
    test    byte ptr [p+5], 20h
    jz      short loc_487BA4
    mov     rdi, p; p
    call    hasAnchor
    test    eax, eax
    jz      short loc_487BA4
    lea     rdx, [rsp+0D8h+p1]; pDest
    mov     rdi, pParse; pParse
    mov     rsi, p; p
    call    generateWithRecursiveQuery
    xor     r14d, r14d
    mov     [rsp+0D8h+var_C4], 0
loc_487B91:
    test    byte ptr [p+4], 20h
    jnz     loc_4882C4
loc_487B9B:
    mov     ebp, [rsp+0D8h+var_C4]
    jmp     multi_select_end
loc_487BA4:
    cmp     qword ptr [p+48h], 0
    jz      short loc_487BC0
    mov     rdi, pParse; pParse
    mov     rsi, p; p
    mov     rdx, pDest; pDest
    call    multiSelectOrderBy
    mov     ebp, eax
    jmp     loc_48841D
loc_487BC0:
    cmp     qword ptr [pPrior+50h], 0
    jnz     short loc_487BEF
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
loc_487BEF:
    mov     al, [p]
    add     al, 7Bh ; '{'; switch 4 cases
    cmp     al, 3
    ja      def_487BFE; jumptable 0000000000487BFE default case
    movzx   eax, al
def_487BFE:
    jmp     ds:jpt_487BFE[rax*8]; switch jump
    cmp     byte ptr [rsp+0D8h+p1], 1; jumptable 0000000000487BFE cases -123,-121
    jnz     loc_487F60
    cmp     qword ptr [p+60h], 0
    jnz     loc_488576
    mov     eax, [rsp+0D8h+p1+4]
    jmp     loc_487FB1
    mov     dword ptr [rsp+0D8h+var_58.eDest], 0; jumptable 0000000000487BFE case -122
    cmp     qword ptr [pPrior+60h], 0
    jnz     loc_48858F
    mov     eax, [p+8]
    mov     [pPrior+8], eax
    mov     eax, [p+0Ch]
    mov     [pPrior+0Ch], eax
    mov     rax, [p+60h]
    mov     [pPrior+60h], rax
    lea     rdx, [rsp+0D8h+p1]; pDest
    mov     rdi, pParse; pParse
    mov     rsi, pPrior; p
    call    sqlite3Select
    mov     qword ptr [pPrior+60h], 0
    test    eax, eax
    jnz     loc_487B34
    mov     [rsp+0D8h+var_D0], db
    mov     [rsp+0D8h+var_D8], pParse
    mov     qword ptr [p+50h], 0
    mov     edx, [pPrior+8]; p1
    mov     [p+8], edx
    mov     eax, [pPrior+0Ch]
    mov     [p+0Ch], eax
    test    edx, edx
    jz      loc_4881F9
    mov     rdi, v; p
    mov     esi, 14h; op
    call    sqlite3VdbeAddOp1
    mov     r15d, eax
    mov     esi, offset aJumpAheadIfLim; "Jump ahead if LIMIT reached"
    mov     rdi, v; p
    xor     eax, eax
    call    sqlite3VdbeComment
    mov     r8d, [p+0Ch]; p3
    test    r8d, r8d
    jz      loc_4881FC
    mov     edx, [p+8]; p1
    lea     ecx, [r8+1]; p2
    mov     rdi, v; p
    mov     esi, 9Ch; op
    call    sqlite3VdbeAddOp3
    jmp     loc_4881FC
    mov     edx, [pParse+34h]; jumptable 0000000000487BFE case -120
    lea     eax, [tab1+2]
    mov     [pParse+34h], eax
    cmp     qword ptr [p+48h], 0
    jnz     loc_4885A8
    mov     rdi, v; p
    mov     esi, 70h ; 'p'; op
    mov     qword ptr [rsp+0D8h+iParm], tab1
    xor     ecx, ecx; p2
    call    sqlite3VdbeAddOp2
    cmp     dword ptr [p+14h], 0FFFFFFFFh
    jnz     loc_4885C1
    mov     [rsp+0D8h+var_D0], db
    mov     [rsp+0D8h+var_D8], pParse
    mov     [p+14h], eax
    mov     rdi, p; p
    call    findRightmost
    or      byte ptr [rax+4], 20h
    cmp     qword ptr [p+20h], 0
    jz      loc_4885DA
    lea     rbp, [rsp+0D8h+var_58]
    mov     rdi, rbp; pDest
    mov     esi, 1; eDest
    mov     r15, qword ptr [rsp+0D8h+iParm]
    mov     edx, r15d; iParm
    call    sqlite3SelectDestInit
    mov     rdi, [rsp+0D8h+var_D8]; pParse
    mov     rsi, pPrior; p
    mov     rdx, rbp; pDest
    call    sqlite3Select
    test    eax, eax
    jnz     loc_487FF3
    lea     ebp, [r15+1]
    mov     rdi, v; p
    mov     esi, 70h ; 'p'; op
    mov     edx, ebp; p1
    xor     ecx, ecx; p2
    call    sqlite3VdbeAddOp2
    cmp     dword ptr [p+18h], 0FFFFFFFFh
    jnz     loc_488670
    mov     [p+18h], eax
    mov     qword ptr [p+50h], 0
    mov     r15, [p+60h]
    mov     qword ptr [p+60h], 0
    mov     [rsp+0D8h+var_B4], ebp
    mov     [rsp+0D8h+var_58.iSDParm], ebp
    movzx   edi, byte ptr [p]; id
    call    sqlite3SelectOpName
    mov     edx, offset aSUsingTempBTre; "%s USING TEMP B-TREE"
    mov     rbp, [rsp+0D8h+var_D8]
    mov     rdi, pParse; pParse
    mov     esi, 1; bPush
    mov     rcx, rax
    xor     eax, eax
    call    sqlite3VdbeExplain
    lea     rdx, [rsp+0D8h+var_58]; pDest
    mov     rdi, pParse; pParse
    mov     rsi, p; p
    call    sqlite3Select
    mov     [rsp+0D8h+var_C4], eax
    mov     rax, [p+50h]
    mov     [rsp+0D8h+var_C0], rax
    mov     [p+50h], pPrior
    movzx   eax, word ptr [pPrior+2]
    cmp     [p+2], ax
    jle     short loc_487DFC
    mov     [p+2], ax
loc_487DFC:
    mov     rsi, [p+60h]; p
    mov     pParse, [rsp+0D8h+var_D0]
    mov     rdi, rbp; db
    call    sqlite3ExprDelete
    mov     [p+60h], r15
    mov     r15, rbp
    cmp     [rsp+0D8h+var_C4], 0
    mov     pPrior, [rsp+0D8h+var_C0]
    jnz     loc_487F4C
    mov     [rsp+0D8h+var_A8], pDest
    cmp     qword ptr [p+20h], 0
    mov     r14, [rsp+0D8h+var_D8]
    jz      loc_4886A2
    mov     rdi, rc; pParse
    call    sqlite3VdbeMakeLabel
    mov     ebp, eax
    mov     qword ptr [rsp+0D8h+x], iBreak
    mov     rdi, rc; pParse
    call    sqlite3VdbeMakeLabel
    mov     qword ptr [rsp+0D8h+p2], rax
    mov     rdi, rc; pParse
    mov     rsi, p; p
    mov     edx, ebp; iBreak
    call    computeLimitRegisters
    mov     rdi, v; p
    mov     esi, 25h ; '%'; op
    mov     r15, qword ptr [rsp+0D8h+iParm]
    mov     edx, r15d; p1
    mov     ecx, ebp; p2
    call    sqlite3VdbeAddOp2
    mov     rdi, rc; pParse
    call    sqlite3GetTempReg
    mov     r13d, eax
    mov     rdi, v; p
    mov     esi, 82h; op
    mov     edx, r15d; p1
    mov     rbp, r15
    mov     ecx, eax; p2
    call    sqlite3VdbeAddOp2
    mov     [rsp+0D8h+var_9C], eax
    mov     rdi, v; p
    mov     esi, 1Dh; op
    mov     edx, [rsp+0D8h+var_B4]; p1
    mov     r15, qword ptr [rsp+0D8h+p2]
    mov     ecx, r15d; p2
    mov     r8d, r13d; p3
    xor     r9d, r9d; p4
    call    sqlite3VdbeAddOp4Int
    mov     rdi, rc; pParse
    mov     esi, r13d; iReg
    call    sqlite3ReleaseTempReg
    lea     r9, [rsp+0D8h+p1]; pDest
    mov     rdi, rc; pParse
    mov     rsi, p; p
    mov     edx, ebp; srcTab
    mov     ecx, 0; pSort
    mov     r8d, 0; pDistinct
    mov     r1, qword ptr [rsp+0D8h+x]
    push    iBreak; iBreak
    push    iCont; iContinue
    call    selectInnerLoop
    add     rsp, 10h
    mov     rdi, v; v
    mov     esi, r15d; x
    call    sqlite3VdbeResolveLabel
    mov     rdi, v; p
    mov     esi, 5; op
    mov     edx, ebp; p1
    mov     ecx, [rsp+0D8h+var_9C]; p2
    call    sqlite3VdbeAddOp2
    mov     rdi, v; v
    mov     esi, r13d; x
    call    sqlite3VdbeResolveLabel
    mov     rdi, v; p
    mov     esi, 76h ; 'v'; op
    mov     edx, [rsp+0D8h+var_B4]; p1
    xor     ecx, ecx; p2
    call    sqlite3VdbeAddOp2
    mov     rdi, v; p
    mov     esi, 76h ; 'v'; op
    mov     edx, ebp; p1
    xor     ecx, ecx; p2
    call    sqlite3VdbeAddOp2
    mov     iBreak, [rsp+0D8h+var_A8]
    mov     iCont, [rsp+0D8h+var_D0]
    mov     rc, [rsp+0D8h+var_C0]
loc_487F4C:
    mov     rbp, [rsp+0D8h+var_D8]
    cmp     qword ptr [p+58h], 0
    jnz     loc_487B91
    jmp     loc_4882B2
loc_487F60:
    mov     edx, [pParse+34h]; p1
    lea     eax, [unionTab+1]
    mov     [pParse+34h], eax
    cmp     qword ptr [p+48h], 0
    jnz     loc_4885F3
    mov     rdi, v; p
    mov     esi, 70h ; 'p'; op
    mov     qword ptr [rsp+0D8h+iParm], unionTab
    xor     ecx, ecx; p2
    call    sqlite3VdbeAddOp2
    cmp     dword ptr [p+14h], 0FFFFFFFFh
    jnz     loc_48860C
    mov     [p+14h], eax
    mov     rdi, p; p
    call    findRightmost
    or      byte ptr [rax+4], 20h
    cmp     qword ptr [p+20h], 0
    mov     rax, qword ptr [rsp+0D8h+iParm]
    jz      loc_488625
loc_487FB1:
    mov     [rsp+0D8h+var_D0], db
    mov     [rsp+0D8h+var_D8], pParse
    cmp     qword ptr [pPrior+48h], 0
    jnz     loc_48855D
    lea     rbp, [rsp+0D8h+var_58]
    mov     rdi, rbp; pDest
    mov     esi, 1; eDest
    mov     r15, unionTab
    mov     edx, r15d; iParm
    call    sqlite3SelectDestInit
    mov     rdi, [rsp+0D8h+var_D8]; pParse
    mov     rsi, pPrior; p
    mov     rdx, rbp; pDest
    call    sqlite3Select
    test    eax, eax
    jz      short loc_488002
loc_487FF3:
    mov     ebp, eax
    xor     r14d, r14d
    mov     r15, [rsp+0D8h+var_D0]
    jmp     multi_select_end
loc_488002:
    mov     qword ptr [rsp+0D8h+iParm], r15
    movzx   edi, byte ptr [p]; id
    cmp     edi, 85h
    jz      short loc_488033
    mov     al, 2
    cmp     dil, 87h
    jz      short loc_488035
    mov     edi, offset aPOpTkUnion; "p->op==TK_UNION"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 21009h; line
    call    ___assert_fail
loc_488033:
    mov     al, 1
loc_488035:
    mov     qword ptr [p+50h], 0
    mov     r15, [p+60h]
    mov     qword ptr [p+60h], 0
    mov     [rsp+0D8h+var_58.eDest], al
    call    sqlite3SelectOpName
    mov     edx, offset aSUsingTempBTre; "%s USING TEMP B-TREE"
    mov     rbp, [rsp+0D8h+var_D8]
    mov     rdi, pParse; pParse
    mov     esi, 1; bPush
    mov     rcx, rax
    xor     eax, eax
    call    sqlite3VdbeExplain
    lea     rdx, [rsp+0D8h+var_58]; pDest
    mov     rdi, pParse; pParse
    mov     rsi, p; p
    call    sqlite3Select
    cmp     qword ptr [p+48h], 0
    jnz     loc_48863E
    mov     ebp, eax
    mov     rax, [p+50h]
    mov     [rsp+0D8h+var_C0], rax
    mov     [p+50h], pPrior
    mov     qword ptr [p+48h], 0
    cmp     byte ptr [p], 85h
    jnz     short loc_4880BC
    movsx   edi, word ptr [p+2]; a
    movsx   esi, word ptr [pPrior+2]; b
    call    sqlite3LogEstAdd
    mov     [p+2], ax
loc_4880BC:
    mov     [rsp+0D8h+var_C4], ebp
    mov     rsi, [p+60h]; p
    mov     rdi, [rsp+0D8h+var_D0]; db
    call    sqlite3ExprDelete
    mov     [p+60h], r15
    mov     qword ptr [p+8], 0
    mov     al, byte ptr [rsp+0D8h+p1]
    mov     rcx, qword ptr [rsp+0D8h+iParm]
    cmp     ecx, [rsp+0D8h+p1+4]
    jz      short loc_4880F1
    cmp     al, 1
    jz      loc_488657
loc_4880F1:
    cmp     qword ptr [p+20h], 0
    mov     rbp, [rsp+0D8h+var_D8]
    mov     r15, [rsp+0D8h+var_D0]
    mov     pPrior, [rsp+0D8h+var_C0]
    jnz     short loc_488111
    cmp     byte ptr [r15+63h], 0
    jz      loc_488689
loc_488111:
    cmp     al, 1
    jz      loc_4882A7
    cmp     byte ptr [r15+63h], 0
    jnz     loc_4882A7
    mov     rdi, pDelete; pParse
    mov     r14, rcx
    call    sqlite3VdbeMakeLabel
    mov     r15d, eax
    mov     rdi, [rsp+0D8h+var_D8]; pParse
    call    sqlite3VdbeMakeLabel
    mov     ebp, eax
    mov     rdi, [rsp+0D8h+var_D8]; pParse
    mov     rsi, p; p
    mov     edx, r15d; iBreak
    call    computeLimitRegisters
    mov     rdi, v; p
    mov     esi, 25h ; '%'; op
    mov     edx, r14d; p1
    mov     ecx, r15d; p2
    call    sqlite3VdbeAddOp2
    mov     rdi, v; p
    call    sqlite3VdbeCurrentAddr
    mov     [rsp+0D8h+var_A8], pDest
    mov     [rsp+0D8h+var_B4], eax
    lea     r9, [rsp+0D8h+p1]; pDest
    mov     rdi, [rsp+0D8h+var_D8]; pParse
    mov     rsi, p; p
    mov     r13, r14
    mov     edx, r13d; srcTab
    mov     ecx, 0; pSort
    mov     r8d, 0; pDistinct
    push    iBreak; iBreak
    push    iCont; iContinue
    call    selectInnerLoop
    add     rsp, 10h
    mov     rdi, v; v
    mov     esi, ebp; x
    mov     r14, [rsp+0D8h+var_C0]
    call    sqlite3VdbeResolveLabel
    mov     rdi, v; p
    mov     esi, 5; op
    mov     edx, r13d; p1
    mov     ecx, [rsp+0D8h+var_B4]; p2
    mov     r13, [rsp+0D8h+var_A8]
    call    sqlite3VdbeAddOp2
    mov     rdi, v; v
    mov     esi, r15d; x
    mov     iBreak, [rsp+0D8h+var_D0]
    mov     iCont, [rsp+0D8h+var_D8]
    call    sqlite3VdbeResolveLabel
    mov     rdi, v; p
    mov     esi, 76h ; 'v'; op
    mov     rdx, qword ptr [rsp+0D8h+iParm]; p1
    xor     ecx, ecx; p2
    call    sqlite3VdbeAddOp2
    cmp     qword ptr [p+58h], 0
    jnz     loc_487B91
    jmp     loc_4882B2
loc_4881F9:
    xor     r15d, r15d
loc_4881FC:
    mov     edx, offset aUnionAll; "UNION ALL"
    mov     rbp, [rsp+0D8h+var_D8]
    mov     rdi, dest; pParse
    mov     esi, 1; bPush
    xor     eax, eax
    call    sqlite3VdbeExplain
    lea     rdx, [rsp+0D8h+p1]; pDest
    mov     rdi, rbp; pParse
    mov     rsi, p; p
    call    sqlite3Select
    mov     ebp, eax
    mov     rax, [p+50h]
    mov     [rsp+0D8h+var_C0], rax
    mov     [p+50h], pPrior
    movsx   edi, word ptr [p+2]; a
    movsx   esi, word ptr [pPrior+2]; b
    call    sqlite3LogEstAdd
    mov     [p+2], ax
    mov     rax, [p+60h]
    test    rax, rax
    jz      short loc_488285
    mov     rdi, [rax+10h]; p
    lea     rsi, [rsp+0D8h+var_58]; pValue
    call    sqlite3ExprIsInteger
    test    eax, eax
    jz      short loc_488285
    mov     eax, dword ptr [rsp+0D8h+var_58.eDest]
    test    eax, eax
    jle     short loc_488285
    movsxd  rdi, eax; x
    movzx   r14d, word ptr [p+2]
    call    sqlite3LogEst
    cmp     r14w, ax
    jle     short loc_488285
    mov     [p+2], ax
loc_488285:
    mov     [rsp+0D8h+var_C4], ebp
    test    r15d, r15d
    jz      short loc_488299
    mov     rdi, v; p
    mov     esi, r15d; addr
    call    sqlite3VdbeJumpHere
loc_488299:
    mov     rbp, [rsp+0D8h+var_D8]
    mov     addr, [rsp+0D8h+var_D0]
    mov     r14, [rsp+0D8h+var_C0]
loc_4882A7:
    cmp     qword ptr [p+58h], 0
    jnz     loc_487B91
loc_4882B2:
    mov     rdi, rbp; pParse
    call    sqlite3VdbeExplainPop
    test    byte ptr [p+4], 20h
    jz      loc_487B9B
loc_4882C4:
    mov     [rsp+0D8h+var_C0], pDelete
    mov     [rsp+0D8h+var_A8], r13
    cmp     qword ptr [p+58h], 0
    jnz     loc_488544
    mov     rax, [p+20h]
    mov     r14d, [rax]
    mov     [rsp+0D8h+var_D0], r15
    mov     rdi, r15; db
    mov     esi, r14d; N
    mov     edx, 1; X
    call    sqlite3KeyInfoAlloc
    test    rax, rax
    jz      loc_4883E7
    mov     r13, rax
    test    r14d, r14d
    jle     short loc_488363
    xor     r15d, r15d
    jmp     short loc_488319
loc_488310:
    add     r15, 1
    cmp     r14d, r15d
    jz      short loc_488363
loc_488319:
    mov     rdi, rbp; pParse
    mov     rsi, p; p
    mov     edx, r15d; iCol
    call    multiSelectCollSeq
    mov     [pKeyInfo+r15*8+20h], rax
    test    rax, rax
    jnz     short loc_488310
    mov     rax, [rsp+0D8h+var_D0]
    mov     rax, [rax+10h]
    mov     [pKeyInfo+r15*8+20h], rax
    jmp     short loc_488310
loc_488350:
    cmp     dword ptr [pLoop+18h], 0
    jns     loc_488463
loc_48835A:
    mov     pLoop, [pLoop+50h]
    test    pLoop, pLoop
    jz      short loc_4883CF
loc_488363:
    mov     ebp, [pLoop+14h]
    test    ebp, ebp
    js      short loc_488350
    mov     rdi, v; p
    mov     esi, ebp; addr
    mov     edx, r14d; val
    call    sqlite3VdbeChangeP2
    mov     rdi, pKeyInfo; p
    call    sqlite3KeyInfoRef
    mov     rdi, v; p
    mov     esi, ebp; addr
    mov     rdx, rax; zP4
    mov     ecx, 0FFFFFFF7h; n
    call    sqlite3VdbeChangeP4
    mov     dword ptr [pLoop+14h], 0FFFFFFFFh
    mov     ebp, [pLoop+18h]
    test    ebp, ebp
    js      short loc_48835A
    mov     rdi, v; p
    mov     esi, ebp; addr
    mov     edx, r14d; val
    call    sqlite3VdbeChangeP2
    mov     rdi, pKeyInfo; p
    call    sqlite3KeyInfoRef
    mov     rdi, v; p
    mov     esi, ebp; addr
    mov     rdx, rax; zP4
    mov     ecx, 0FFFFFFF7h; n
    call    sqlite3VdbeChangeP4
    mov     dword ptr [pLoop+18h], 0FFFFFFFFh
    jmp     short loc_48835A
loc_4883CF:
    mov     rdi, pKeyInfo; p
    call    sqlite3KeyInfoUnref
    mov     pKeyInfo, [rsp+0D8h+var_A8]
    mov     r15, [rsp+0D8h+var_D0]
    mov     ebp, [rsp+0D8h+var_C4]
    jmp     short loc_4883FD
loc_4883E7:
    mov     edi, 210A4h; lineno
    call    sqlite3NomemError
    mov     ebp, eax
    mov     r13, [rsp+0D8h+var_A8]
    mov     r15, [rsp+0D8h+var_D0]
loc_4883FD:
    mov     nCol, [rsp+0D8h+var_C0]
    mov     eax, [rsp+0D8h+p1+0Ch]
    mov     [r13+0Ch], eax
    mov     eax, dword ptr [rsp+0D8h+var_88]
    mov     [r13+10h], eax
    mov     rdi, r15; db
    mov     rsi, pDelete; p
    call    sqlite3SelectDelete
loc_48841D:
    mov     eax, ebp
    add     rsp, 0A8h
    pop     rbx
    pop     v
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_488431:
    mov     edi, offset aPPPprior; "p && p->pPrior"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 20F78h; line
    call    ___assert_fail
loc_48844A:
    mov     edi, offset aPPelistPpriorP; "p->pEList && pPrior->pEList"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 20F97h; line
    call    ___assert_fail
loc_488463:
    mov     edi, offset aPloopAddropene; "pLoop->addrOpenEphm[1]<0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 210B4h; line
    call    ___assert_fail
loc_48847C:
    mov     edi, offset aPSelflagsSfCom; "p->selFlags & SF_Compound"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 20F7Ah; line
    call    ___assert_fail
loc_488495:
    mov     edi, offset aPpriorPorderby; "pPrior->pOrderBy==0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 20F7Eh; line
    call    ___assert_fail
loc_4884AE:
    mov     edi, offset aPpriorPlimit0; "pPrior->pLimit==0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 20F7Fh; line
    call    ___assert_fail
loc_4884C7:
    mov     edi, offset aV0_0; "v!=0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 20F82h; line
    call    ___assert_fail
loc_4884E0:
    mov     edi, offset aPPelistNexprPp; "p->pEList->nExpr==pPrior->pEList->nExpr"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 20F98h; line
    call    ___assert_fail
loc_4884F9:
    mov     edi, offset aPSelflagsSfRec; "(p->selFlags & SF_Recursive)==0 || p->o"...
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 20F79h; line
    call    ___assert_fail
loc_488512:
    mov     edi, offset aPPelist; "p->pEList"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 20F87h; line
    call    ___assert_fail
    mov     edi, offset aPOpTkIntersect; jumptable 0000000000487BFE default case
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 21036h; line
    call    ___assert_fail
loc_488544:
    mov     edi, (offset aPtabPvtablePPP+14h); assertion
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 210A0h; line
    call    ___assert_fail
loc_48855D:
    mov     edi, offset aPpriorPorderby_0; "!pPrior->pOrderBy"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 20FFCh; line
    call    ___assert_fail
loc_488576:
    mov     edi, offset aPPlimit0; "p->pLimit==0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 20FEAh; line
    call    ___assert_fail
loc_48858F:
    mov     edi, offset aPpriorPlimit; "!pPrior->pLimit"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 20FB3h; line
    call    ___assert_fail
loc_4885A8:
    mov     edi, offset aPPorderby0; "p->pOrderBy==0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 21044h; line
    call    ___assert_fail
loc_4885C1:
    mov     edi, offset aPAddropenephm0; "p->addrOpenEphm[0] == -1"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 21047h; line
    call    ___assert_fail
loc_4885DA:
    mov     edi, offset aPPelist; "p->pEList"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 2104Ah; line
    call    ___assert_fail
loc_4885F3:
    mov     edi, offset aPPorderby0; "p->pOrderBy==0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 20FF1h; line
    call    ___assert_fail
loc_48860C:
    mov     edi, offset aPAddropenephm0; "p->addrOpenEphm[0] == -1"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 20FF3h; line
    call    ___assert_fail
loc_488625:
    mov     edi, offset aPPelist; "p->pEList"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 20FF6h; line
    call    ___assert_fail
loc_48863E:
    mov     edi, offset aPPorderby0; "p->pOrderBy==0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 21015h; line
    call    ___assert_fail
loc_488657:
    mov     edi, offset aUniontabDestIs; "unionTab==dest.iSDParm || dest.eDest!=p"...
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 21024h; line
    call    ___assert_fail
loc_488670:
    mov     edi, offset aPAddropenephm1; "p->addrOpenEphm[1] == -1"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 21058h; line
    call    ___assert_fail
loc_488689:
    mov     edi, offset aPPelistDbMallo; "p->pEList || db->mallocFailed"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 21025h; line
    call    ___assert_fail
loc_4886A2:
    mov     edi, offset aPPelist; "p->pEList"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntMultiselect; "int multiSelect(Parse *, Select *, Sele"...
    mov     edx, 2106Fh; line
    call    ___assert_fail
multiSelect endp

