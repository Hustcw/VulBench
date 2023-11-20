selectExpander proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 0B8h
    mov     r12, pWalker
    mov     rbx, [rdi]
    mov     rdi, [pParse]; db
    mov     ecx, [p+4]
    mov     eax, ecx
    or      eax, 40h
    mov     [p+4], eax
    cmp     byte ptr [db+63h], 0
    jz      short loc_481EC2
loc_481EAB:
    mov     eax, 2
loc_481EB0:
    add     rsp, 0B8h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_481EC2:
    mov     rbp, p
    mov     rax, [rsi+28h]
    mov     [rsp+0E8h+pList], pTabList
    test    rax, rax
    jz      loc_482886
    mov     eax, 1
    test    cl, 40h
    jnz     short loc_481EB0
    cmp     word ptr [pWalker+24h], 0
    jz      short loc_481EFC
    mov     eax, [pParse+84h]
    add     eax, 1
    mov     [pParse+84h], eax
    mov     [p+10h], eax
loc_481EFC:
    mov     rax, [p+20h]
    mov     [rsp+0E8h+var_98], rax
    mov     rsi, [p+68h]
    test    ecx, 200000h
    mov     [rsp+0E8h+var_D0], db
    jz      short loc_481F46
    cmp     qword ptr [pParse+180h], 0
    jz      short loc_481F46
    test    rsi, rsi
    jnz     short loc_481F3F
    mov     esi, 40h ; '@'; n
    call    sqlite3DbMallocZero
    mov     rsi, rax; pWith
    mov     [p+68h], rax
    test    rax, rax
    jz      loc_481EAB
loc_481F3F:
    mov     dword ptr [rsi+4], 1
loc_481F46:
    mov     rdi, pParse; pParse
    xor     edx, edx; bFree
    call    sqlite3WithPush
    mov     [rsp+0E8h+var_E0], pParse
    mov     rdi, rbx; pParse
    mov     rbx, [rsp+0E8h+pList]
    mov     rsi, rbx; pList
    call    sqlite3SrcListAssignCursors
    cmp     dword ptr [rbx], 0
    mov     r13, p
    mov     [rsp+0E8h+var_90], p
    jle     loc_4821A8
    mov     rax, [rsp+0E8h+pList]
    lea     rbx, [rax+45h]
    xor     ebp, ebp
    jmp     short loc_481FAD
loc_481F90:
    test    rax, rax
    jz      loc_48286D
loc_481F99:
    add     ebp, 1
    add     rbx, 70h ; 'p'
    mov     rax, [rsp+0E8h+pList]
    cmp     ebp, [rax]
    jge     loc_4821A8
loc_481FAD:
    test    byte ptr [rbx], 20h
    mov     rax, [rbx-1Dh]
    jnz     short loc_481F90
    test    rax, rax
    jnz     short loc_481F99
    lea     r14, [rbx-3Dh]
    cmp     qword ptr [rbx-2Dh], 0
    jz      short loc_481FF3
    mov     rdi, [rsp+0E8h+var_E0]; pParse
    mov     rsi, pWalker; pWalker
    mov     rdx, r14; pFrom
    call    resolveFromTermToCte
    test    eax, eax
    jz      short loc_48202A
    cmp     eax, 1
    jg      loc_481EAB
    cmp     qword ptr [rbx-1Dh], 0
    jnz     loc_482185
    jmp     loc_4828EA
loc_481FF3:
    mov     rsi, [rbx-15h]; p
    test    pSel, pSel
    jz      loc_4828D1
    mov     rdi, pWalker; pWalker
    call    sqlite3WalkSelect
    test    eax, eax
    jnz     loc_481EAB
    mov     rdi, [rsp+0E8h+var_E0]; pParse
    mov     rsi, r14; pFrom
    call    sqlite3ExpandSubquery
    test    eax, eax
    jz      loc_482185
    jmp     loc_481EAB
loc_48202A:
    cmp     qword ptr [rbx-1Dh], 0
    jnz     loc_482903
    mov     rdi, [rsp+0E8h+var_E0]; pParse
    xor     esi, esi; flags
    mov     rdx, r14; p
    call    sqlite3LocateTableItem
    mov     [rbx-1Dh], rax
    test    rax, rax
    jz      loc_481EAB
    mov     r15, rax
    mov     eax, [rax+3Ch]
    cmp     eax, 0FFFFh
    jnb     loc_4827CD
    add     eax, 1
    mov     [pTab+3Ch], eax
    cmp     dword ptr [pTab+54h], 0
    jnz     short loc_482097
    mov     rdi, [rsp+0E8h+var_E0]; pParse
    mov     rsi, r14; pFrom
    call    cannotBeFunction
    test    eax, eax
    jnz     loc_481EAB
    cmp     dword ptr [pTab+54h], 0
    jnz     short loc_482097
    cmp     qword ptr [pTab+18h], 0
    jz      loc_482185
loc_482097:
    movzx   r13d, byte ptr [pWalker+24h]
    mov     rdi, [rsp+0E8h+var_E0]; pParse
    mov     rsi, pTab; pTable
    call    sqlite3ViewGetColumnNames
    test    eax, eax
    jnz     loc_481EAB
    cmp     qword ptr [rbx-15h], 0
    jnz     loc_48289F
    cmp     qword ptr [pTab+18h], 0
    jz      short loc_4820F6
    mov     rax, [rsp+0E8h+var_D0]
    cmp     dword ptr [rax+30h], 0
    js      short loc_4820F6
    mov     rax, [pTab+70h]
    mov     rcx, [rsp+0E8h+var_D0]
    mov     rcx, [rcx+20h]
    cmp     rax, [rcx+38h]
    jz      short loc_4820F6
    mov     rdx, [pTab]
    mov     esi, offset aAccessToViewSP; "access to view \"%s\" prohibited"
    mov     rdi, [rsp+0E8h+var_E0]; pParse
    xor     eax, eax
    call    sqlite3ErrorMsg
loc_4820F6:
    mov     dword ptr [rsp+0E8h+var_B8], r13d
    cmp     dword ptr [pTab+54h], 0
    jz      short loc_48213E
    test    byte ptr [rbx], 40h
    jz      short loc_48213E
    mov     rax, [pTab+60h]
    test    rax, rax
    jz      loc_4828B8
    movzx   eax, byte ptr [rax+1Dh]
    mov     rcx, [rsp+0E8h+var_D0]
    mov     ecx, [rcx+30h]
    shr     ecx, 7
    and     ecx, 1
    cmp     ecx, eax
    jnb     short loc_48213E
    mov     rdx, [pTab]
    mov     esi, offset aUnsafeUseOfVir; "unsafe use of virtual table \"%s\""
    mov     rdi, [rsp+0E8h+var_E0]; pParse
    xor     eax, eax
    call    sqlite3ErrorMsg
loc_48213E:
    mov     rsi, [pTab+18h]; pDup
    mov     rdi, [rsp+0E8h+var_D0]; db
    xor     edx, edx; flags
    call    sqlite3SelectDup
    mov     [rbx-15h], rax
    movzx   r13d, word ptr [pTab+46h]
    mov     word ptr [pTab+46h], 0FFFFh
    mov     word ptr [pWalker+24h], 1
    mov     rdi, pWalker; pWalker
    mov     rsi, rax; p
    call    sqlite3WalkSelect
    mov     eax, dword ptr [rsp+0E8h+var_B8]
    mov     [pWalker+24h], ax
    mov     [pTab+46h], r13w
    mov     nCol, [rsp+0E8h+var_90]
loc_482185:
    test    byte ptr [rbx], 2
    jz      loc_481F99
    mov     rdi, [rsp+0E8h+var_E0]; pParse
    mov     rsi, r14; pFrom
    call    sqlite3IndexedByLookup
    test    eax, eax
    jz      loc_481F99
    jmp     loc_481EAB
loc_4821A8:
    mov     r14, [rsp+0E8h+var_E0]
    cmp     dword ptr [r14+30h], 0
    jnz     loc_481EAB
    mov     rax, [rsp+0E8h+var_D0]
    cmp     byte ptr [rax+63h], 0
    jnz     loc_481EAB
    mov     rdi, r14; pParse
    mov     rbp, r13
    mov     rsi, r13; p
    call    sqliteProcessJoin
    test    eax, eax
    jnz     loc_481EAB
    mov     rdx, [rsp+0E8h+var_98]
    movsxd  rax, dword ptr [rdx]
    test    rax, rax
    jle     loc_482803
    mov     rcx, [rsp+0E8h+pList]
    add     rcx, 8
    mov     [rsp+0E8h+var_58], rcx
    lea     rcx, [rdx+8]
    xor     edx, edx
    mov     [rsp+0E8h+var_C4], 0
    jmp     short loc_482230
loc_48220F:
    cmp     bl, 0B3h
    jz      short loc_482267
loc_482214:
    mov     edi, [rsp+0E8h+var_C4]
    or      edi, [pE+4]
    mov     [rsp+0E8h+var_C4], edi
    add     k, 1
    add     rcx, 18h
    cmp     rdx, rax
    jge     loc_48280B
loc_482230:
    mov     rsi, [rcx]
    movzx   ebx, byte ptr [pE]
    cmp     bl, 8Ch
    jnz     short loc_48220F
    mov     rdi, [pE+18h]
    test    rdi, rdi
    jz      loc_48294E
    mov     rbp, [pE+10h]
    test    rbp, rbp
    jz      loc_482935
    cmp     byte ptr [rbp+0], 3Bh ; ';'
    jnz     loc_482935
    cmp     byte ptr [rdi], 0B3h
    mov     rbp, r13
    jnz     short loc_482214
loc_482267:
    mov     rax, [r14]
    mov     rax, [rax+30h]
    and     eax, 44h
    mov     [rsp+0E8h+var_60], rax
    xor     eax, eax
    mov     [rsp+0E8h+var_C0], rax
    xor     eax, eax
    mov     pE, [rsp+0E8h+var_98]
    jmp     short loc_4822BB
loc_482289:
    mov     esi, offset aNoSuchTableS; "no such table: %s"
    mov     rdi, r14; pParse
    mov     rdx, rbx
    xor     eax, eax
    call    sqlite3ErrorMsg
loc_48229B:
    mov     rcx, [rsp+0E8h+var_50]
    add     rcx, 1
    mov     rsi, [rsp+0E8h+var_98]; pList
    movsxd  rax, dword ptr [rsi]
    cmp     rcx, rax
    mov     rax, rcx
    jge     loc_4827EE
loc_4822BB:
    mov     [rsp+0E8h+var_50], k
    lea     rbx, [rax+rax*2]
    mov     rdx, [rsi+rbx*8+8]; pExpr
    mov     eax, [rsp+0E8h+var_C4]
    or      eax, [pE+4]
    mov     [rsp+0E8h+var_C4], eax
    mov     rax, [pE+18h]
    mov     cl, [pE]
    test    pRight, pRight
    jnz     short loc_4822EB
    cmp     cl, 8Ch
    jz      loc_48291C
loc_4822EB:
    cmp     cl, 0B3h
    jnz     loc_48270A
    xor     ebx, ebx
loc_4822F6:
    mov     rax, [rsp+0E8h+pList]
    cmp     dword ptr [rax], 0
    jle     loc_4827AB
    mov     [rsp+0E8h+N], 0
    xor     r14d, r14d
    mov     pE, [rsp+0E8h+var_58]
    mov     [rsp+0E8h+zTab], zTName
    jmp     short loc_482346
loc_482320:
    mov     ecx, [rsp+0E8h+N]
    add     ecx, 1
    mov     rdx, [rsp+0E8h+var_88]
    add     rdx, 70h ; 'p'
    mov     rax, [rsp+0E8h+pList]
    mov     [rsp+0E8h+N], ecx
    cmp     ecx, [rax]
    mov     rbx, [rsp+0E8h+zTab]
    jge     loc_482734
loc_482346:
    mov     rax, [pFrom+18h]
    mov     rsi, [pFrom+20h]
    mov     rcx, [pFrom+28h]
    mov     [rsp+0E8h+zRight], zTabName
    test    rax, rax
    jnz     short loc_482364
    mov     rax, [pTab]
    mov     [rsp+0E8h+zRight], rax
loc_482364:
    mov     rax, [rsp+0E8h+var_D0]
    cmp     byte ptr [rax+63h], 0
    jnz     loc_482734
    test    pSub, pSub
    mov     [rsp+0E8h+var_B8], pTab
    mov     [rsp+0E8h+var_88], pFrom
    jz      short loc_482388
    test    byte ptr [pSub+5], 8
    jnz     short loc_4823CC
loc_482388:
    test    zTName, zTName
    jz      short loc_4823A7
    mov     rdi, zTName; zLeft
    mov     pTab, [rsp+0E8h+zRight]; zRight
    call    sqlite3StrICmp
    mov     rsi, [rsp+0E8h+var_B8]
    test    eax, eax
    jnz     loc_482320
loc_4823A7:
    mov     rsi, [rsi+70h]; pSchema
    mov     r15, [rsp+0E8h+var_D0]
    mov     rdi, r15; db
    call    sqlite3SchemaToIndex
    test    eax, eax
    js      short loc_4823DA
    mov     rcx, [r15+20h]
    cdqe
    shl     rax, 5
    mov     rax, [rcx+rax]
    jmp     short loc_4823DF
loc_4823CC:
    xor     eax, eax
    cmp     word ptr [pTab+46h], 0
    jg      short loc_4823F1
    jmp     loc_482320
loc_4823DA:
    mov     eax, 4E12B7h
loc_4823DF:
    xor     ecx, ecx
    mov     rsi, [rsp+0E8h+var_B8]
    cmp     word ptr [rsi+46h], 0
    jle     loc_482320
loc_4823F1:
    mov     [rsp+0E8h+zToken], zSchemaName
    test    zTName, zTName
    setnz   al
    mov     rdx, pSub
    setz    cl
    mov     [rsp+0E8h+var_68], rdx
    test    rdx, rdx
    setnz   dl
    and     dl, al
    mov     [rsp+0E8h+var_D1], dl
    cmp     [rsp+0E8h+N], 0
    setnz   al
    and     al, cl
    mov     [rsp+0E8h+var_D2], al
    mov     r13d, 8
    xor     r15d, r15d
    xor     ebx, ebx
    jmp     loc_4824B2
loc_482434:
    mov     esi, (offset aSSSS+4); zFormat
    mov     rdi, r14; db
    mov     rdx, [rsp+0E8h+zToken]
    mov     rcx, [rsp+0E8h+zRight]
    mov     r8, zColname
    xor     eax, eax
    call    sqlite3MPrintf
loc_482450:
    mov     rcx, [rsp+0E8h+var_48]
    mov     [rcx], rax
    mov     rax, [rsp+0E8h+var_C0]
    mov     rcx, rax
    movzx   eax, byte ptr [rax+rbp*8+19h]
    and     al, 0FCh
    or      al, 2
    mov     [rcx+rbp*8+19h], al
    mov     rbp, [rsp+0E8h+var_90]
    nop     word ptr [rax+rax+00000000h]
    nop
loc_482480:
    mov     rdi, r14; db
    mov     rsi, [rsp+0E8h+var_80]; p
    call    sqlite3DbFree
    mov     r14d, 1
loc_482493:
    mov     rsi, [rsp+0E8h+var_B8]
loc_482498:
    add     j, 1
    movsx   rax, word ptr [rsi+46h]
    add     r15, 20h ; ' '
    add     r13, 18h
    cmp     rbx, rax
    jge     loc_482320
loc_4824B2:
    mov     rax, [rsi+8]
    mov     pWalker, [rax+r15]
    test    zName, zName
    jz      loc_482854
    cmp     [rsp+0E8h+var_D1], 0
    jz      short loc_4824F0
    mov     rax, [rsp+0E8h+var_68]
    mov     rdi, [rax+20h]
    add     rdi, r13; pItem
    xor     esi, esi; zCol
    mov     rdx, [rsp+0E8h+zTab]; zTab
    xor     ecx, ecx; zDb
    call    sqlite3MatchEName
    mov     rsi, [rsp+0E8h+var_B8]
    test    eax, eax
    jz      short loc_482498
loc_4824F0:
    test    byte ptr [rbp+6], 2
    jnz     short loc_482502
    mov     rax, [rsi+8]
    test    byte ptr [rax+r15+1Ch], 2
    jnz     short loc_482498
loc_482502:
    cmp     [rsp+0E8h+var_D2], 0
    jz      short loc_48255D
    mov     rax, [rsp+0E8h+var_88]
    test    byte ptr [rax+3Ch], 4
    jz      short loc_48253E
    mov     r14d, 1
    mov     rdi, [rsp+0E8h+pList]; pSrc
    mov     esi, [rsp+0E8h+N]; N
    mov     rdx, zName; zCol
    xor     ecx, ecx; piTab
    xor     r8d, r8d; piCol
    mov     r9d, 1; bIgnoreHidden
    call    tableAndColumnIndex
    test    eax, eax
    jnz     loc_482493
loc_48253E:
    mov     rax, [rsp+0E8h+var_88]
    mov     rdi, [rax+50h]; pList
    mov     rsi, zName; zName
    call    sqlite3IdListIndex
    mov     r14d, 1
    test    eax, eax
    jns     loc_482493
loc_48255D:
    mov     rbp, [rsp+0E8h+var_D0]
    mov     rdi, rbp; db
    mov     esi, 3Bh ; ';'; op
    mov     rdx, zName; zToken
    call    sqlite3Expr
    mov     rcx, rax
    cmp     [rsp+0E8h+var_60], 4
    jz      short loc_48258E
    mov     rax, [rsp+0E8h+pList]
    cmp     dword ptr [rax], 2
    jl      loc_48262D
loc_48258E:
    mov     rdi, rbp; db
    mov     esi, 3Bh ; ';'; op
    mov     rdx, [rsp+0E8h+zRight]; zToken
    mov     r14, pRight
    call    sqlite3Expr
    mov     rbp, [rsp+0E8h+var_E0]
    mov     rdi, rbp; pParse
    mov     esi, 8Ch; op
    mov     rdx, pLeft; pLeft
    mov     rcx, pRight; pRight
    call    sqlite3PExpr
    mov     rcx, rax
    mov     rdx, [rsp+0E8h+zToken]; zToken
    test    rdx, rdx
    jz      short loc_4825F0
    mov     rdi, [rsp+0E8h+var_D0]; db
    mov     esi, 3Bh ; ';'; op
    mov     pRight, pExpr
    call    sqlite3Expr
    mov     rdi, rbp; pParse
    mov     esi, 8Ch; op
    mov     rdx, pLeft; pLeft
    mov     rcx, pExpr; pRight
    call    sqlite3PExpr
    mov     rcx, rax
loc_4825F0:
    cmp     [rsp+0E8h+var_60], 4
    mov     rbp, [rsp+0E8h+var_C0]
    jnz     short loc_482624
    mov     esi, offset aSS_0; "%s.%s"
    mov     rdi, [rsp+0E8h+var_D0]; db
    mov     rdx, [rsp+0E8h+zRight]
    mov     r14, pExpr
    mov     rcx, zName
    xor     eax, eax
    call    sqlite3MPrintf
    mov     rcx, pExpr
    mov     zName, rax
    jmp     short loc_482626
loc_482624:
    xor     eax, eax
loc_482626:
    mov     [rsp+0E8h+var_80], rax
    jmp     short loc_482639
loc_48262D:
    xor     eax, eax
    mov     [rsp+0E8h+var_80], rax
    mov     rbp, [rsp+0E8h+var_C0]
loc_482639:
    mov     r14, [rsp+0E8h+var_E0]
    mov     rdi, r14; pParse
    mov     rsi, rbp; pList
    mov     rdx, pExpr; pExpr
    call    sqlite3ExprListAppend
    mov     rbp, rax
    lea     rax, [rsp+0E8h+pName]
    mov     rdi, rax; p
    mov     rsi, zColname; z
    call    sqlite3TokenInit
    mov     rdi, r14; pParse
    mov     rsi, pNew; pList
    lea     rdx, [rsp+0E8h+pName]; pName
    xor     ecx, ecx; dequote
    call    sqlite3ExprListSetName
    mov     rax, pNew
    mov     [rsp+0E8h+var_C0], rbp
    test    rbp, rbp
    mov     rbp, [rsp+0E8h+var_90]
    mov     r14, [rsp+0E8h+var_D0]
    jz      loc_482480
    test    byte ptr [rbp+5], 8
    jz      loc_482480
    mov     rax, [rsp+0E8h+var_E0]
    cmp     byte ptr [rax+114h], 1
    ja      loc_482480
    mov     rax, [rsp+0E8h+var_C0]
    mov     rcx, rax
    movsxd  rax, dword ptr [rax]
    add     rax, 0FFFFFFFFFFFFFFFFh
    lea     rbp, [rax+rax*2]
    mov     rsi, [rcx+rbp*8+10h]; p
    mov     rdi, r14; db
    call    sqlite3DbFree
    mov     rax, [rsp+0E8h+var_C0]
    lea     rax, [rax+rbp*8]
    add     rax, 10h
    mov     [rsp+0E8h+var_48], rax
    mov     rax, [rsp+0E8h+var_68]
    test    rax, rax
    jz      loc_482434
    mov     rax, [rax+20h]
    mov     rsi, [rax+r13+8]; z
    mov     rdi, r14; db
    call    sqlite3DbStrDup
    jmp     loc_482450
loc_48270A:
    cmp     cl, 8Ch
    jnz     short loc_482744
    cmp     byte ptr [pRight], 0B3h
    jnz     short loc_482744
    mov     pRight, [pE+10h]
    test    rax, rax
    jz      loc_482967
    test    byte ptr [rax+5], 4
    jnz     loc_482980
    mov     rbx, [rax+8]
    jmp     loc_4822F6
loc_482734:
    test    r14d, r14d
    mov     tableSeen, [rsp+0E8h+var_E0]
    jnz     loc_48229B
    jmp     short loc_4827B0
loc_482744:
    mov     pWalker, rbp
    mov     rbp, [rsp+0E8h+var_98]
    lea     r15, ds:8[rbx*8]
    add     r15, rbp
    mov     rdi, r14; pParse
    mov     rsi, [rsp+0E8h+var_C0]; pList
    call    sqlite3ExprListAppend
    test    pNew, pNew
    jz      short loc_482797
    mov     rdx, [rbp+rbx*8+10h]
    movsxd  rcx, dword ptr [pNew]
    lea     rsi, [rcx+rcx*2]
    mov     [pNew+rsi*8-8], rdx
    mov     cl, [rbp+rbx*8+19h]
    and     cl, 3
    mov     dl, [pNew+rsi*8+1]
    and     dl, 0FCh
    or      dl, cl
    mov     [pNew+rsi*8+1], dl
    mov     qword ptr [rbp+rbx*8+10h], 0
loc_482797:
    mov     [rsp+0E8h+var_C0], pNew
    mov     qword ptr [r15], 0
    mov     rbp, r12
    jmp     loc_48229B
loc_4827AB:
    mov     r14, [rsp+0E8h+var_E0]
loc_4827B0:
    test    rbx, rbx
    jnz     loc_482289
    mov     esi, offset aNoTablesSpecif; "no tables specified"
    mov     rdi, r14; pParse
    xor     eax, eax
    call    sqlite3ErrorMsg
    jmp     loc_48229B
loc_4827CD:
    mov     rdx, [pTab]
    mov     esi, offset aTooManyReferen; "too many references to \"%s\": max 6553"...
    mov     rdi, [rsp+0E8h+var_E0]; pParse
    xor     eax, eax
    call    sqlite3ErrorMsg
    mov     qword ptr [rbx-1Dh], 0
    jmp     loc_481EAB
loc_4827EE:
    mov     rdi, [rsp+0E8h+var_D0]; db
    call    sqlite3ExprListDelete
    mov     rcx, [rsp+0E8h+var_C0]
    mov     [rbp+20h], rcx
    jmp     short loc_48280F
loc_482803:
    mov     [rsp+0E8h+var_C4], 0
loc_48280B:
    mov     rcx, [rbp+20h]
loc_48280F:
    xor     eax, eax
    test    rcx, rcx
    jz      loc_481EB0
    mov     ecx, [rcx]
    mov     rdx, [rsp+0E8h+var_D0]
    cmp     ecx, [rdx+90h]
    jle     short loc_48283D
    mov     esi, offset aTooManyColumns_1; "too many columns in result set"
    mov     rdi, r14; pParse
    xor     eax, eax
    call    sqlite3ErrorMsg
    jmp     loc_481EAB
loc_48283D:
    test    [rsp+0E8h+var_C4], 200004h
    jz      loc_481EB0
    or      byte ptr [rbp+6], 4
    jmp     loc_481EB0
loc_482854:
    mov     edi, offset aZname; "zName"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntSelectexpan; "int selectExpander(Walker *, Select *)"
    mov     edx, 21AE3h; line
    call    ___assert_fail
loc_48286D:
    mov     edi, offset aPfromFgIsrecur; "pFrom->fg.isRecursive==0 || pFrom->pTab"...
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntSelectexpan; "int selectExpander(Walker *, Select *)"
    mov     edx, 21A3Ah; line
    call    ___assert_fail
loc_482886:
    mov     edi, offset aPPsrc0; "p->pSrc!=0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntSelectexpan; "int selectExpander(Walker *, Select *)"
    mov     edx, 21A1Ah; line
    call    ___assert_fail
loc_48289F:
    mov     edi, offset aPfromPselect0; "pFrom->pSelect==0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntSelectexpan; "int selectExpander(Walker *, Select *)"
    mov     edx, 21A60h; line
    call    ___assert_fail
loc_4828B8:
    mov     edi, (offset aPcolAffinitySq+22h); assertion
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntSelectexpan; "int selectExpander(Walker *, Select *)"
    mov     edx, 21A6Ch; line
    call    ___assert_fail
loc_4828D1:
    mov     edi, offset aPsel0; "pSel!=0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntSelectexpan; "int selectExpander(Walker *, Select *)"
    mov     edx, 21A41h; line
    call    ___assert_fail
loc_4828EA:
    mov     edi, offset aPtab0; "pTab!=0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntSelectexpan; "int selectExpander(Walker *, Select *)"
    mov     edx, 21A4Ah; line
    call    ___assert_fail
loc_482903:
    mov     edi, offset aPfromPtab0; "pFrom->pTab==0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntSelectexpan; "int selectExpander(Walker *, Select *)"
    mov     edx, 21A4Eh; line
    call    ___assert_fail
loc_48291C:
    mov     edi, offset aPeOpTkDotPrigh; "pE->op!=TK_DOT || pRight!=0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntSelectexpan; "int selectExpander(Walker *, Select *)"
    mov     edx, 21AB4h; line
    call    ___assert_fail
loc_482935:
    mov     edi, offset aPeOpTkDotPePle; "pE->op!=TK_DOT || (pE->pLeft!=0 && pE->"...
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntSelectexpan; "int selectExpander(Walker *, Select *)"
    mov     edx, 21AA0h; line
    call    ___assert_fail
loc_48294E:
    mov     edi, offset aPeOpTkDotPePri; "pE->op!=TK_DOT || pE->pRight!=0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntSelectexpan; "int selectExpander(Walker *, Select *)"
    mov     edx, 21A9Fh; line
    call    ___assert_fail
loc_482967:
    mov     edi, offset aPePleft0; "pE->pLeft!=0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntSelectexpan; "int selectExpander(Walker *, Select *)"
    mov     edx, 21AC7h; line
    call    ___assert_fail
loc_482980:
    mov     edi, offset aExprhaspropert_18; "!ExprHasProperty(pE->pLeft, EP_IntValue"...
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntSelectexpan; "int selectExpander(Walker *, Select *)"
    mov     edx, 21AC8h; line
    call    ___assert_fail
selectExpander endp

