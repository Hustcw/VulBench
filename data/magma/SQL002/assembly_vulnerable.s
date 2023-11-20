selectExpander proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 0B8h
    mov     r13, [pWalker]
    mov     rdx, [pParse+0]
    mov     ecx, [p+4]
    mov     eax, ecx
    or      eax, 40h
    mov     [p+4], eax
    cmp     byte ptr [db+63h], 0
    jz      short loc_481D70
loc_481D59:
    mov     eax, 2
loc_481D5E:
    add     rsp, 0B8h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_481D70:
    mov     r12, p
    mov     [rsp+0E8h+var_D8], db
    mov     rax, [rsi+28h]
    mov     [rsp+0E8h+pList], pTabList
    test    rax, rax
    jz      loc_482735
    mov     eax, 1
    test    cl, 40h
    jnz     short loc_481D5E
    mov     r15, pWalker
    cmp     word ptr [rdi+24h], 0
    jz      short loc_481DB4
    mov     eax, [pParse+84h]
    add     eax, 1
    mov     [pParse+84h], eax
    mov     [p+10h], eax
loc_481DB4:
    mov     rax, [p+20h]
    mov     [rsp+0E8h+var_C8], rax
    mov     rsi, [p+68h]
    test    ecx, 200000h
    jz      short loc_481E01
    cmp     qword ptr [pParse+180h], 0
    jz      short loc_481E01
    test    rsi, rsi
    jnz     short loc_481DFA
    mov     esi, 40h ; '@'; n
    mov     rdi, [rsp+0E8h+var_D8]; db
    call    sqlite3DbMallocZero
    mov     rsi, rax; pWith
    mov     [p+68h], rax
    test    rax, rax
    jz      loc_481D59
loc_481DFA:
    mov     dword ptr [rsi+4], 1
loc_481E01:
    mov     rdi, pParse; pParse
    xor     edx, edx; bFree
    call    sqlite3WithPush
    mov     rdi, pParse; pParse
    mov     rbx, [rsp+0E8h+pList]
    mov     rsi, rbx; pList
    call    sqlite3SrcListAssignCursors
    cmp     dword ptr [rbx], 0
    mov     [rsp+0E8h+var_90], pParse
    mov     [rsp+0E8h+var_88], p
    jle     loc_482057
    mov     rax, [rsp+0E8h+pList]
    lea     rbx, [rax+45h]
    xor     ebp, ebp
    jmp     short loc_481E5D
loc_481E40:
    test    rax, rax
    jz      loc_48271C
loc_481E49:
    add     ebp, 1
    add     rbx, 70h ; 'p'
    mov     rax, [rsp+0E8h+pList]
    cmp     ebp, [rax]
    jge     loc_482057
loc_481E5D:
    test    byte ptr [rbx], 20h
    mov     rax, [rbx-1Dh]
    jnz     short loc_481E40
    test    rax, rax
    jnz     short loc_481E49
    lea     r14, [rbx-3Dh]
    cmp     qword ptr [rbx-2Dh], 0
    jz      short loc_481EA1
    mov     rdi, pParse; pParse
    mov     rsi, pWalker; pWalker
    mov     rdx, r14; pFrom
    call    resolveFromTermToCte
    test    eax, eax
    jz      short loc_481ED6
    cmp     eax, 1
    jg      loc_481D59
    cmp     qword ptr [rbx-1Dh], 0
    jnz     loc_482031
    jmp     loc_4827CB
loc_481EA1:
    mov     rsi, [rbx-15h]; p
    test    pSel, pSel
    jz      loc_4827B2
    mov     rdi, pWalker; pWalker
    call    sqlite3WalkSelect
    test    eax, eax
    jnz     loc_481D59
    mov     rdi, pParse; pParse
    mov     rsi, r14; pFrom
    call    sqlite3ExpandSubquery
    test    eax, eax
    jz      loc_482031
    jmp     loc_481D59
loc_481ED6:
    cmp     qword ptr [rbx-1Dh], 0
    jnz     loc_4827E4
    mov     rdi, pParse; pParse
    xor     esi, esi; flags
    mov     rdx, r14; p
    call    sqlite3LocateTableItem
    mov     [rbx-1Dh], rax
    test    rax, rax
    jz      loc_481D59
    mov     p, rax
    mov     eax, [rax+3Ch]
    cmp     eax, 0FFFFh
    jnb     loc_4826E3
    add     eax, 1
    mov     [pTab+3Ch], eax
    cmp     dword ptr [pTab+54h], 0
    jnz     short loc_481F43
    mov     rdi, pParse; pParse
    mov     rsi, r14; pFrom
    call    cannotBeFunction
    test    eax, eax
    jnz     loc_481D59
    cmp     dword ptr [pTab+54h], 0
    jnz     short loc_481F43
    cmp     qword ptr [pTab+18h], 0
    jz      loc_482031
loc_481F43:
    movzx   eax, byte ptr [pWalker+24h]
    mov     dword ptr [rsp+0E8h+var_C0], eax
    mov     rdi, pParse; pParse
    mov     rsi, pTab; pTable
    call    sqlite3ViewGetColumnNames
    test    eax, eax
    jnz     loc_481D59
    cmp     qword ptr [rbx-15h], 0
    jnz     loc_482767
    cmp     qword ptr [pTab+18h], 0
    jz      short loc_481FA4
    mov     rax, [rsp+0E8h+var_D8]
    cmp     dword ptr [rax+30h], 0
    js      short loc_481FA4
    mov     rax, [pTab+70h]
    mov     rcx, [rsp+0E8h+var_D8]
    mov     rcx, [rcx+20h]
    cmp     rax, [rcx+38h]
    jz      short loc_481FA4
    mov     rdx, [pTab]
    mov     esi, offset aAccessToViewSP; "access to view \"%s\" prohibited"
    mov     rdi, pParse; pParse
    xor     eax, eax
    call    sqlite3ErrorMsg
loc_481FA4:
    cmp     dword ptr [pTab+54h], 0
    jz      short loc_481FE8
    test    byte ptr [rbx], 40h
    jz      short loc_481FE8
    mov     rax, [pTab+60h]
    test    rax, rax
    jz      loc_482780
    movzx   eax, byte ptr [rax+1Dh]
    mov     rcx, [rsp+0E8h+var_D8]
    mov     ecx, [rcx+30h]
    shr     ecx, 7
    and     ecx, 1
    cmp     ecx, eax
    jnb     short loc_481FE8
    mov     rdx, [pTab]
    mov     esi, offset aUnsafeUseOfVir; "unsafe use of virtual table \"%s\""
    mov     rdi, pParse; pParse
    xor     eax, eax
    call    sqlite3ErrorMsg
loc_481FE8:
    mov     rsi, [pTab+18h]; pDup
    mov     rdi, [rsp+0E8h+var_D8]; db
    xor     edx, edx; flags
    call    sqlite3SelectDup
    mov     [rbx-15h], rax
    movzx   r13d, word ptr [pTab+46h]
    mov     word ptr [pTab+46h], 0FFFFh
    mov     word ptr [pWalker+24h], 1
    mov     rdi, pWalker; pWalker
    mov     rsi, rax; p
    call    sqlite3WalkSelect
    mov     eax, dword ptr [rsp+0E8h+var_C0]
    mov     [pWalker+24h], ax
    mov     [pTab+46h], r13w
    mov     nCol, [rsp+0E8h+var_90]
loc_482031:
    test    byte ptr [rbx], 2
    mov     r12, [rsp+0E8h+var_88]
    jz      loc_481E49
    mov     rdi, r13; pParse
    mov     rsi, r14; pFrom
    call    sqlite3IndexedByLookup
    test    eax, eax
    jz      loc_481E49
    jmp     loc_481D59
loc_482057:
    mov     rax, [rsp+0E8h+var_D8]
    cmp     byte ptr [rax+63h], 0
    jnz     loc_481D59
    mov     rdi, r13; pParse
    mov     rsi, r12; p
    call    sqliteProcessJoin
    test    eax, eax
    jnz     loc_481D59
    mov     rdx, [rsp+0E8h+var_C8]
    movsxd  rax, dword ptr [rdx]
    test    rax, rax
    jle     loc_48268F
    mov     rcx, [rsp+0E8h+pList]
    add     rcx, 8
    mov     [rsp+0E8h+var_58], rcx
    lea     rcx, [rdx+8]
    xor     edx, edx
    mov     [rsp+0E8h+var_CC], 0
    jmp     short loc_4820CC
loc_4820AB:
    cmp     bl, 0B3h
    jz      short loc_482100
loc_4820B0:
    mov     edi, [rsp+0E8h+var_CC]
    or      edi, [pE+4]
    mov     [rsp+0E8h+var_CC], edi
    add     k, 1
    add     rcx, 18h
    cmp     rdx, rax
    jge     loc_482697
loc_4820CC:
    mov     rsi, [rcx]
    movzx   ebx, byte ptr [pE]
    cmp     bl, 8Ch
    jnz     short loc_4820AB
    mov     rdi, [pE+18h]
    test    rdi, rdi
    jz      loc_4827FD
    mov     rbp, [pE+10h]
    test    rbp, rbp
    jz      loc_482799
    cmp     byte ptr [rbp+0], 3Bh ; ';'
    jnz     loc_482799
    cmp     byte ptr [rdi], 0B3h
    jnz     short loc_4820B0
loc_482100:
    mov     rax, [r13+0]
    mov     rax, [rax+30h]
    and     eax, 44h
    mov     [rsp+0E8h+var_60], rax
    xor     ebp, ebp
    xor     eax, eax
    mov     [rsp+0E8h+var_A8], rax
    mov     pE, [rsp+0E8h+var_C8]
    jmp     short loc_482158
loc_482123:
    mov     r12, [rsp+0E8h+var_88]
    test    zTName, zTName
    jz      loc_4825EA
loc_482131:
    mov     esi, offset aNoSuchTableS; "no such table: %s"
    mov     rdi, r13; pParse
    mov     rdx, rbx
    xor     eax, eax
    call    sqlite3ErrorMsg
loc_482143:
    mov     rsi, [rsp+0E8h+var_C8]; pList
loc_482148:
    add     rbp, 1
    movsxd  rax, dword ptr [rsi]
    cmp     rbp, rax
    jge     loc_482679
loc_482158:
    lea     rbx, ds:0[k*2]
    add     rbx, k
    mov     rdx, [rsi+rbx*8+8]; pExpr
    mov     eax, [rsp+0E8h+var_CC]
    or      eax, [pE+4]
    mov     [rsp+0E8h+var_CC], eax
    mov     rax, [pE+18h]
    mov     cl, [pE]
    test    pRight, pRight
    jnz     short loc_482187
    cmp     cl, 8Ch
    jz      loc_48274E
loc_482187:
    cmp     cl, 0B3h
    jnz     loc_48259D
    xor     ebx, ebx
loc_482192:
    mov     rax, [rsp+0E8h+pList]
    cmp     dword ptr [rax], 0
    jle     short loc_482123
    mov     [rsp+0E8h+var_50], k
    mov     [rsp+0E8h+N], 0
    xor     ebp, ebp
    mov     pE, [rsp+0E8h+var_58]
    mov     [rsp+0E8h+zTab], zTName
    jmp     short loc_4821E6
loc_4821C0:
    mov     ecx, [rsp+0E8h+N]
    add     ecx, 1
    mov     rdx, [rsp+0E8h+var_80]
    add     rdx, 70h ; 'p'
    mov     rax, [rsp+0E8h+pList]
    mov     [rsp+0E8h+N], ecx
    cmp     ecx, [rax]
    mov     rbx, [rsp+0E8h+zTab]
    jge     loc_4825C7
loc_4821E6:
    mov     rax, [pFrom+18h]
    mov     rsi, [pFrom+20h]
    mov     rcx, [pFrom+28h]
    mov     [rsp+0E8h+zRight], zTabName
    test    rax, rax
    jnz     short loc_482204
    mov     rax, [pTab]
    mov     [rsp+0E8h+zRight], rax
loc_482204:
    mov     rax, [rsp+0E8h+var_D8]
    cmp     byte ptr [rax+63h], 0
    jnz     loc_4825C7
    test    pSub, pSub
    mov     [rsp+0E8h+var_C0], pTab
    mov     [rsp+0E8h+var_80], pFrom
    jz      short loc_482228
    test    byte ptr [pSub+5], 8
    jnz     short loc_482270
loc_482228:
    test    zTName, zTName
    jz      short loc_482247
    mov     rdi, zTName; zLeft
    mov     pTab, [rsp+0E8h+zRight]; zRight
    call    sqlite3StrICmp
    mov     rsi, [rsp+0E8h+var_C0]
    test    eax, eax
    jnz     loc_4821C0
loc_482247:
    mov     rsi, [rsi+70h]; pSchema
    mov     r14, [rsp+0E8h+var_D8]
    mov     rdi, r14; db
    call    sqlite3SchemaToIndex
    test    eax, eax
    js      short loc_48227E
    mov     rcx, [r14+20h]
    cdqe
    shl     rax, 5
    mov     rax, [rcx+rax]
    jmp     short loc_482283
loc_482270:
    xor     eax, eax
    cmp     word ptr [pTab+46h], 0
    jg      short loc_482295
    jmp     loc_4821C0
loc_48227E:
    mov     eax, 4E10E9h
loc_482283:
    xor     ecx, ecx
    mov     rsi, [rsp+0E8h+var_C0]
    cmp     word ptr [rsi+46h], 0
    jle     loc_4821C0
loc_482295:
    mov     [rsp+0E8h+zToken], zSchemaName
    test    zTName, zTName
    setnz   al
    mov     rdx, pSub
    setz    cl
    mov     [rsp+0E8h+var_68], rdx
    test    rdx, rdx
    setnz   dl
    and     dl, al
    mov     [rsp+0E8h+var_D9], dl
    cmp     [rsp+0E8h+N], 0
    setnz   al
    and     al, cl
    mov     [rsp+0E8h+var_DA], al
    mov     r12d, 8
    xor     r14d, r14d
    xor     ebx, ebx
    jmp     short loc_482346
loc_4822D5:
    mov     rax, [rax+20h]
    mov     rsi, [rax+r12+8]; z
    mov     rdi, r13; db
    call    sqlite3DbStrDup
loc_4822E6:
    mov     rcx, [rsp+0E8h+var_48]
    mov     [rcx], rax
    mov     rax, [rsp+0E8h+var_A8]
    mov     rcx, rax
    movzx   eax, byte ptr [rax+rbp*8+19h]
    and     al, 0FCh
    or      al, 2
    mov     [rcx+rbp*8+19h], al
    nop     word ptr [rax+rax+00000000h]
loc_482310:
    mov     rdi, r13; db
    mov     rsi, [rsp+0E8h+var_98]; p
    call    sqlite3DbFree
    mov     ebp, 1
    mov     r13, [rsp+0E8h+var_90]
loc_482327:
    mov     rsi, [rsp+0E8h+var_C0]
loc_48232C:
    add     j, 1
    movsx   rax, word ptr [rsi+46h]
    add     r14, 20h ; ' '
    add     r12, 18h
    cmp     rbx, rax
    jge     loc_4821C0
loc_482346:
    mov     rax, [rsi+8]
    mov     pWalker, [rax+r14]
    test    zName, zName
    jz      loc_482703
    cmp     [rsp+0E8h+var_D9], 0
    jz      short loc_482384
    mov     rax, [rsp+0E8h+var_68]
    mov     rdi, [rax+20h]
    add     rdi, r12; pItem
    xor     esi, esi; zCol
    mov     rdx, [rsp+0E8h+zTab]; zTab
    xor     ecx, ecx; zDb
    call    sqlite3MatchEName
    mov     rsi, [rsp+0E8h+var_C0]
    test    eax, eax
    jz      short loc_48232C
loc_482384:
    mov     rax, [rsp+0E8h+var_88]
    test    byte ptr [rax+6], 2
    jnz     short loc_48239B
    mov     rax, [rsi+8]
    test    byte ptr [rax+r14+1Ch], 2
    jnz     short loc_48232C
loc_48239B:
    cmp     [rsp+0E8h+var_DA], 0
    jz      short loc_4823F4
    mov     rax, [rsp+0E8h+var_80]
    test    byte ptr [rax+3Ch], 4
    jz      short loc_4823D6
    mov     ebp, 1
    mov     rdi, [rsp+0E8h+pList]; pSrc
    mov     esi, [rsp+0E8h+N]; N
    mov     rdx, zName; zCol
    xor     ecx, ecx; piTab
    xor     r8d, r8d; piCol
    mov     r9d, 1; bIgnoreHidden
    call    tableAndColumnIndex
    test    eax, eax
    jnz     loc_482327
loc_4823D6:
    mov     rax, [rsp+0E8h+var_80]
    mov     rdi, [rax+50h]; pList
    mov     rsi, zName; zName
    call    sqlite3IdListIndex
    mov     ebp, 1
    test    eax, eax
    jns     loc_482327
loc_4823F4:
    mov     rdi, [rsp+0E8h+var_D8]; db
    mov     esi, 3Bh ; ';'; op
    mov     rdx, zName; zToken
    call    sqlite3Expr
    mov     rbp, rax
    cmp     [rsp+0E8h+var_60], 4
    jz      short loc_482422
    mov     rax, [rsp+0E8h+pList]
    cmp     dword ptr [rax], 2
    jl      loc_4824BC
loc_482422:
    mov     [rsp+0E8h+var_98], pRight
    mov     rbp, [rsp+0E8h+var_D8]
    mov     rdi, rbp; db
    mov     esi, 3Bh ; ';'; op
    mov     rdx, [rsp+0E8h+zRight]; zToken
    call    sqlite3Expr
    mov     rdi, r13; pParse
    mov     esi, 8Ch; op
    mov     rdx, pLeft; pLeft
    mov     rcx, [rsp+0E8h+var_98]; pRight
    call    sqlite3PExpr
    mov     r13, rax
    mov     rdx, [rsp+0E8h+zToken]; zToken
    test    rdx, rdx
    jz      short loc_4824AE
    mov     rdi, rbp; db
    mov     esi, 3Bh ; ';'; op
    call    sqlite3Expr
    mov     rdi, [rsp+0E8h+var_90]; pParse
    mov     esi, 8Ch; op
    mov     rdx, pLeft; pLeft
    mov     rcx, pExpr; pRight
    call    sqlite3PExpr
    mov     rbp, rax
    cmp     [rsp+0E8h+var_60], 4
    jnz     short loc_4824BC
loc_482490:
    mov     esi, offset aSS_0; "%s.%s"
    mov     rdi, [rsp+0E8h+var_D8]; db
    mov     rdx, [rsp+0E8h+zRight]
    mov     rcx, zName
    xor     eax, eax
    call    sqlite3MPrintf
    mov     zName, rax
    jmp     short loc_4824BE
loc_4824AE:
    mov     rbp, pExpr
    cmp     [rsp+0E8h+var_60], 4
    jz      short loc_482490
loc_4824BC:
    xor     eax, eax
loc_4824BE:
    mov     [rsp+0E8h+var_98], rax
    mov     r13, [rsp+0E8h+var_90]
    mov     rdi, r13; pParse
    mov     rsi, [rsp+0E8h+var_A8]; pList
    mov     rdx, pExpr; pExpr
    call    sqlite3ExprListAppend
    mov     pExpr, rax
    lea     rax, [rsp+0E8h+pName]
    mov     rdi, rax; p
    mov     rsi, zColname; z
    call    sqlite3TokenInit
    mov     rdi, r13; pParse
    mov     rsi, pNew; pList
    lea     rdx, [rsp+0E8h+pName]; pName
    xor     ecx, ecx; dequote
    call    sqlite3ExprListSetName
    test    pNew, pNew
    mov     r13, [rsp+0E8h+var_D8]
    mov     rax, pNew
    mov     [rsp+0E8h+var_A8], rbp
    jz      loc_482310
    mov     rax, [rsp+0E8h+var_88]
    test    byte ptr [rax+5], 8
    jz      loc_482310
    mov     rax, [rsp+0E8h+var_90]
    cmp     byte ptr [rax+114h], 1
    ja      loc_482310
    movsxd  rax, dword ptr [rbp+0]
    add     rax, 0FFFFFFFFFFFFFFFFh
    mov     rcx, rbp
    lea     rbp, [rax+rax*2]
    mov     rsi, [rcx+rbp*8+10h]; p
    mov     rdi, r13; db
    call    sqlite3DbFree
    mov     rax, [rsp+0E8h+var_A8]
    lea     rax, [rax+rbp*8]
    add     rax, 10h
    mov     [rsp+0E8h+var_48], rax
    mov     rax, [rsp+0E8h+var_68]
    test    rax, rax
    jnz     loc_4822D5
    mov     esi, (offset aSSSS+4); zFormat
    mov     rdi, r13; db
    mov     rdx, [rsp+0E8h+zToken]
    mov     rcx, [rsp+0E8h+zRight]
    mov     r8, zColname
    xor     eax, eax
    call    sqlite3MPrintf
    jmp     loc_4822E6
loc_48259D:
    cmp     cl, 8Ch
    jnz     short loc_4825FE
    cmp     byte ptr [pRight], 0B3h
    jnz     short loc_4825FE
    mov     pRight, [pE+10h]
    test    rax, rax
    jz      loc_482816
    test    byte ptr [rax+5], 4
    jnz     loc_48282F
    mov     rbx, [rax+8]
    jmp     loc_482192
loc_4825C7:
    test    ebp, ebp
    mov     r12, [rsp+0E8h+var_88]
    mov     rsi, [rsp+0E8h+var_C8]
    mov     tableSeen, [rsp+0E8h+var_50]
    jnz     loc_482148
    test    rbx, rbx
    jnz     loc_482131
loc_4825EA:
    mov     esi, offset aNoTablesSpecif; "no tables specified"
    mov     rdi, r13; pParse
    xor     eax, eax
    call    sqlite3ErrorMsg
    jmp     loc_482143
loc_4825FE:
    mov     pWalker, k
    mov     rbp, [rsp+0E8h+var_C8]
    lea     r14, ds:8[rbx*8]
    add     r14, rbp
    mov     rdi, r13; pParse
    mov     rsi, [rsp+0E8h+var_A8]; pList
    call    sqlite3ExprListAppend
    mov     rdi, rax
    mov     rsi, rbp
    test    rax, rax
    jz      short loc_482665
    mov     rax, [rsp+0E8h+var_C8]
    mov     rax, [rax+rbx*8+10h]
    movsxd  rcx, dword ptr [pNew]
    lea     rcx, [rcx+rcx*2]
    mov     [pNew+rcx*8-8], rax
    mov     rax, [rsp+0E8h+var_C8]
    mov     al, [rax+rbx*8+19h]
    and     al, 3
    mov     dl, [pNew+rcx*8+1]
    and     dl, 0FCh
    or      dl, al
    mov     rsi, [rsp+0E8h+var_C8]
    mov     [pNew+rcx*8+1], dl
    mov     qword ptr [rsi+rbx*8+10h], 0
loc_482665:
    mov     [rsp+0E8h+var_A8], pNew
    mov     qword ptr [r14], 0
    mov     rbp, k
    jmp     loc_482148
loc_482679:
    mov     rdi, [rsp+0E8h+var_D8]; db
    call    sqlite3ExprListDelete
    mov     rcx, [rsp+0E8h+var_A8]
    mov     [r12+20h], rcx
    jmp     short loc_48269C
loc_48268F:
    mov     [rsp+0E8h+var_CC], 0
loc_482697:
    mov     rcx, [r12+20h]
loc_48269C:
    xor     eax, eax
    test    rcx, rcx
    jz      loc_481D5E
    mov     ecx, [rcx]
    mov     rdx, [rsp+0E8h+var_D8]
    cmp     ecx, [rdx+90h]
    jle     short loc_4826CA
    mov     esi, offset aTooManyColumns_1; "too many columns in result set"
    mov     rdi, r13; pParse
    xor     eax, eax
    call    sqlite3ErrorMsg
    jmp     loc_481D59
loc_4826CA:
    test    [rsp+0E8h+var_CC], 200004h
    jz      loc_481D5E
    or      byte ptr [r12+6], 4
    jmp     loc_481D5E
loc_4826E3:
    mov     rdx, [pTab]
    mov     esi, offset aTooManyReferen; "too many references to \"%s\": max 6553"...
    mov     rdi, pParse; pParse
    xor     eax, eax
    call    sqlite3ErrorMsg
    mov     qword ptr [rbx-1Dh], 0
    jmp     loc_481D59
loc_482703:
    mov     edi, offset aZname; "zName"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntSelectexpan; "int selectExpander(Walker *, Select *)"
    mov     edx, 21AE3h; line
    call    ___assert_fail
loc_48271C:
    mov     edi, offset aPfromFgIsrecur; "pFrom->fg.isRecursive==0 || pFrom->pTab"...
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntSelectexpan; "int selectExpander(Walker *, Select *)"
    mov     edx, 21A3Ah; line
    call    ___assert_fail
loc_482735:
    mov     edi, offset aPPsrc0; "p->pSrc!=0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntSelectexpan; "int selectExpander(Walker *, Select *)"
    mov     edx, 21A1Ah; line
    call    ___assert_fail
loc_48274E:
    mov     edi, offset aPeOpTkDotPrigh; "pE->op!=TK_DOT || pRight!=0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntSelectexpan; "int selectExpander(Walker *, Select *)"
    mov     edx, 21AB4h; line
    call    ___assert_fail
loc_482767:
    mov     edi, offset aPfromPselect0; "pFrom->pSelect==0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntSelectexpan; "int selectExpander(Walker *, Select *)"
    mov     edx, 21A60h; line
    call    ___assert_fail
loc_482780:
    mov     edi, (offset aPcolAffinitySq+22h); assertion
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntSelectexpan; "int selectExpander(Walker *, Select *)"
    mov     edx, 21A6Ch; line
    call    ___assert_fail
loc_482799:
    mov     edi, offset aPeOpTkDotPePle; "pE->op!=TK_DOT || (pE->pLeft!=0 && pE->"...
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntSelectexpan; "int selectExpander(Walker *, Select *)"
    mov     edx, 21AA0h; line
    call    ___assert_fail
loc_4827B2:
    mov     edi, offset aPsel0; "pSel!=0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntSelectexpan; "int selectExpander(Walker *, Select *)"
    mov     edx, 21A41h; line
    call    ___assert_fail
loc_4827CB:
    mov     edi, offset aPtab0; "pTab!=0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntSelectexpan; "int selectExpander(Walker *, Select *)"
    mov     edx, 21A4Ah; line
    call    ___assert_fail
loc_4827E4:
    mov     edi, offset aPfromPtab0; "pFrom->pTab==0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntSelectexpan; "int selectExpander(Walker *, Select *)"
    mov     edx, 21A4Eh; line
    call    ___assert_fail
loc_4827FD:
    mov     edi, offset aPeOpTkDotPePri; "pE->op!=TK_DOT || pE->pRight!=0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntSelectexpan; "int selectExpander(Walker *, Select *)"
    mov     edx, 21A9Fh; line
    call    ___assert_fail
loc_482816:
    mov     edi, offset aPePleft0; "pE->pLeft!=0"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntSelectexpan; "int selectExpander(Walker *, Select *)"
    mov     edx, 21AC7h; line
    call    ___assert_fail
loc_48282F:
    mov     edi, offset aExprhaspropert_18; "!ExprHasProperty(pE->pLeft, EP_IntValue"...
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aIntSelectexpan; "int selectExpander(Walker *, Select *)"
    mov     edx, 21AC8h; line
    call    ___assert_fail
selectExpander endp

