sqlite3_value_text proc
    mov     esi, 1; enc
    jmp     sqlite3ValueText
sqlite3_value_text endp



sqlite3ValueText proc
    push    rbp
    push    rbx
    push    rax
    test    pVal, pVal
    jz      short loc_40C42B
    mov     ebp, esi
    mov     rbx, pVal
    mov     rax, [rdi+28h]
    test    rax, rax
    jz      short loc_40C3D7
    mov     rdi, [rax+18h]; p
    call    sqlite3_mutex_held
    test    eax, eax
    jz      loc_40C466
loc_40C3D7:
    test    bpl, 0F4h
    jnz     short loc_40C434
    mov     rdi, pVal; pMem
    call    sqlite3VdbeMemIsRowSet
    test    eax, eax
    jnz     short loc_40C44D
    movzx   eax, word ptr [pVal+8]
    mov     ecx, eax
    and     ecx, 202h
    cmp     ecx, 202h
    jnz     short loc_40C415
    cmp     [pVal+0Ah], bpl
    jnz     short loc_40C415
    mov     rdi, pVal; p
    call    sqlite3VdbeMemValidStrRep
    test    eax, eax
    jz      short loc_40C47F
    mov     rax, [pVal+10h]
    jmp     short loc_40C42D
loc_40C415:
    test    al, 1
    jnz     short loc_40C42B
    movzx   esi, bpl; enc
    mov     rdi, pVal; pVal
    add     rsp, 8
    pop     pVal
    pop     enc
    jmp     valueToText
loc_40C42B:
    xor     eax, eax
loc_40C42D:
    add     rsp, 8
    pop     rbx
    pop     rbp
    retn
loc_40C434:
    mov     edi, offset aEnc3EncSqliteU; "(enc&3)==(enc&~SQLITE_UTF16_ALIGNED)"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aConstVoidSqlit_0; "const void *sqlite3ValueText(sqlite3_va"...
    mov     edx, 1325Fh; line
    call    ___assert_fail
loc_40C44D:
    mov     edi, offset aSqlite3vdbemem_0; "!sqlite3VdbeMemIsRowSet(pVal)"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aConstVoidSqlit_0; "const void *sqlite3ValueText(sqlite3_va"...
    mov     edx, 13260h; line
    call    ___assert_fail
loc_40C466:
    mov     edi, offset aPvalDb0Sqlite3; "pVal->db==0 || sqlite3_mutex_held(pVal-"...
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aConstVoidSqlit_0; "const void *sqlite3ValueText(sqlite3_va"...
    mov     edx, 1325Eh; line
    call    ___assert_fail
loc_40C47F:
    mov     edi, offset aSqlite3vdbemem_1; "sqlite3VdbeMemValidStrRep(pVal)"
    mov     esi, offset file; "sqlite3.c"
    mov     ecx, offset aConstVoidSqlit_0; "const void *sqlite3ValueText(sqlite3_va"...
    mov     edx, 13262h; line
    call    ___assert_fail
sqlite3ValueText endp

