xmlValidateOneNamespace proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 58h
    xor     r14d, r14d
    test    doc, doc
    jz      loc_43D3A0
    mov     r15, value
    mov     r12, elem
    mov     rbx, doc
    mov     r13, ctxt
    mov     rdi, [rsi+50h]
    test    rdi, rdi
    jz      loc_43CEC2
    test    elem, elem
    jz      loc_43D3A0
loc_43CE1C:
    test    ns, ns
    jz      loc_43D3A0
    mov     rsi, [elem+10h]
    test    rsi, rsi
    jz      loc_43D3A0
    cmp     qword ptr [ns+10h], 0
    jz      loc_43D3A0
    test    prefix, prefix
    mov     [rsp+88h+var_78], ns
    jz      loc_43CF60
    mov     [rsp+88h+var_80], ctxt
    lea     r13, [rsp+88h+memory]
    mov     rdi, rsi; ncname
    mov     rsi, prefix; prefix
    mov     rdx, r13; memory
    mov     ecx, 32h ; '2'; len
    call    xmlBuildQName
    test    rax, rax
    jz      short loc_43CEDB
    mov     rbp, rax
    mov     rax, [rsp+88h+var_78]
    mov     rdx, [rax+18h]; name
    mov     rdi, [doc+50h]; dtd
    test    rdx, rdx
    jz      short loc_43CEEF
    mov     ecx, (offset aXmlns+2); prefix
    mov     rsi, fullname; elem
    call    xmlGetDtdQAttrDesc
    test    attrDecl, attrDecl
    jnz     loc_43CF29
    mov     rdi, [doc+58h]; dtd
    test    rdi, rdi
    jz      short loc_43CF1E
    mov     attrDecl, [rsp+88h+var_78]
    mov     rdx, [rax+18h]; name
    mov     ecx, (offset aXmlns+2); prefix
    mov     rsi, fullname; elem
    call    xmlGetDtdQAttrDesc
    cmp     fullname, r13
    jnz     short loc_43CF2E
    jmp     loc_43CF44
loc_43CEC2:
    test    elem, elem
    jz      loc_43D3A0
    cmp     qword ptr [doc+58h], 0
    jnz     loc_43CE1C
    jmp     loc_43D3A0
loc_43CEDB:
    mov     esi, offset aValidatingName; "Validating namespace"
    mov     rdi, [rsp+88h+var_80]; ctxt
    call    xmlVErrMemory
    jmp     loc_43D3A0
loc_43CEEF:
    mov     edx, (offset aXmlns+2); name
    mov     rsi, fullname; elem
    call    xmlGetDtdAttrDesc
    test    attrDecl, attrDecl
    jnz     short loc_43CF29
    mov     rdi, [doc+58h]; dtd
    test    rdi, rdi
    jz      short loc_43CF27
    mov     edx, (offset aXmlns+2); name
    mov     rsi, fullname; elem
    call    xmlGetDtdAttrDesc
    cmp     fullname, r13
    jnz     short loc_43CF2E
    jmp     short loc_43CF44
loc_43CF1E:
    xor     eax, eax
    cmp     fullname, r13
    jnz     short loc_43CF2E
    jmp     short loc_43CF44
loc_43CF27:
    xor     eax, eax
loc_43CF29:
    cmp     fullname, r13
    jz      short loc_43CF44
loc_43CF2E:
    cmp     fullname, [elem+10h]
    jz      short loc_43CF44
    mov     rdi, fullname; ptr
    mov     fullname, attrDecl
    call    cs:xmlFree
    mov     rax, attrDecl
loc_43CF44:
    test    rax, rax
    mov     r13, [rsp+88h+var_80]
    jnz     loc_43CFD3
    mov     rdi, [doc+50h]; dtd
    mov     rsi, [elem+10h]; elem
    mov     r8, [rsp+88h+var_78]
loc_43CF60:
    mov     rdx, [r8+18h]; name
    test    rdx, rdx
    jz      short loc_43CFA7
    mov     ecx, (offset aXmlns+2); prefix
    call    xmlGetDtdQAttrDesc
    test    attrDecl, attrDecl
    jnz     short loc_43CFD3
    mov     rdi, [doc+58h]; dtd
    test    rdi, rdi
    jz      loc_43D02C
    mov     rsi, [elem+10h]; elem
    mov     attrDecl, [rsp+88h+var_78]
    mov     rdx, [rax+18h]; name
    mov     ecx, (offset aXmlns+2); prefix
    call    xmlGetDtdQAttrDesc
    test    attrDecl, attrDecl
    jnz     short loc_43CFD3
    jmp     loc_43D02C
loc_43CFA7:
    mov     edx, (offset aXmlns+2); name
    call    xmlGetDtdAttrDesc
    test    attrDecl, attrDecl
    jnz     short loc_43CFD3
    mov     rdi, [doc+58h]; dtd
    test    rdi, rdi
    jz      short loc_43D02C
    mov     rsi, [elem+10h]; elem
    mov     edx, (offset aXmlns+2); name
    call    xmlGetDtdAttrDesc
    test    attrDecl, attrDecl
    jz      short loc_43D02C
loc_43CFD3:
    mov     esi, [rax+50h]; type
    mov     rdi, doc; doc
    mov     rdx, value; value
    mov     rbp, rax
    call    xmlValidateAttributeValueInternal
    mov     r14d, 1
    test    eax, eax
    mov     [rsp+88h+var_80], rbp
    jnz     loc_43D090
    mov     val, [rsp+88h+var_78]
    mov     r8, [rax+18h]; str1
    mov     r9, [elem+10h]; str2
    test    r8, r8
    jz      short loc_43D065
    mov     [rsp+88h+str3], 0; str3
    mov     ecx, offset aSyntaxOfValueF_0; "Syntax of value for attribute xmlns:%s "...
    mov     rdi, r13; ctxt
    mov     rsi, elem; node
    mov     edx, 204h; error
    call    xmlErrValidNode
    xor     r14d, r14d
    jmp     short loc_43D08B
loc_43D02C:
    mov     attrDecl, [rsp+88h+var_78]
    mov     r8, [rax+18h]; str1
    mov     r9, [elem+10h]; str2
    test    r8, r8
    jz      loc_43D18A
    mov     [rsp+88h+str3], 0; str3
    mov     ecx, offset aNoDeclarationF_0; "No declaration for attribute xmlns:%s o"...
    mov     rdi, r13; ctxt
    mov     rsi, elem; node
    mov     edx, 215h; error
    call    xmlErrValidNode
    jmp     loc_43D3A0
loc_43D065:
    mov     [rsp+88h+str3], 0; str3
    xor     r14d, r14d
    mov     ecx, offset aSyntaxOfValueF_1; "Syntax of value for attribute xmlns of "...
    mov     rdi, r13; ctxt
    mov     rsi, elem; node
    mov     edx, 204h; error
    mov     r8, r9; str1
    xor     r9d, r9d; str2
    call    xmlErrValidNode
loc_43D08B:
    mov     rbp, [rsp+88h+var_80]
loc_43D090:
    cmp     dword ptr [rbp+54h], 4
    mov     rcx, rbp
    jnz     short loc_43D0DB
    mov     rsi, [rcx+58h]; str2
    mov     rdi, value; str1
    call    xmlStrEqual
    mov     rcx, [rsp+88h+var_80]
    test    eax, eax
    mov     rbp, [rsp+88h+var_78]
    jnz     short loc_43D10D
    mov     r8, [rbp+18h]
    mov     r9, [elem+10h]
    mov     rax, [rcx+58h]
    test    r8, r8
    jz      short loc_43D0E2
    mov     [rsp+88h+str3], rax
    mov     ecx, offset aValueForAttrib_1; "Value for attribute xmlns:%s of %s is d"...
    mov     rdi, r13
    mov     rsi, elem
    mov     edx, 1F4h
    jmp     short loc_43D100
loc_43D0DB:
    mov     rbp, [rsp+88h+var_78]
    jmp     short loc_43D10D
loc_43D0E2:
    mov     [rsp+88h+str3], 0; str3
    mov     ecx, offset aValueForAttrib_2; "Value for attribute xmlns of %s is diff"...
    mov     rdi, r13; ctxt
    mov     rsi, elem; node
    mov     edx, 1F4h; error
    mov     r8, r9; str1
    mov     r9, rax; str2
loc_43D100:
    call    xmlErrValidNode
    xor     r14d, r14d
    mov     rcx, [rsp+88h+var_80]
loc_43D10D:
    mov     eax, [rcx+50h]
    cmp     eax, 0Ah
    jz      short loc_43D12D
    cmp     eax, 9
    jz      loc_43D268
loc_43D11E:
    cmp     dword ptr [rcx+54h], 4
    jz      loc_43D310
    jmp     loc_43D378
loc_43D12D:
    mov     rbp, [rcx+60h]
    mov     rdi, [doc+50h]; dtd
    mov     rsi, value; name
    call    xmlGetDtdNotationDesc
    test    nota, nota
    jnz     loc_43D1F4
    mov     rdi, [doc+58h]; dtd
    mov     rsi, value; name
    call    xmlGetDtdNotationDesc
    test    nota, nota
    jnz     loc_43D1F4
    mov     nota, [rsp+88h+var_78]
    mov     rax, [rax+18h]
    mov     r9, [elem+10h]; str2
    test    rax, rax
    jz      short loc_43D1B5
    mov     [rsp+88h+str3], r9
    mov     ecx, offset aValueSForAttri_2; "Value \"%s\" for attribute xmlns:%s of "...
    mov     rdi, r13
    mov     rsi, elem
    mov     edx, 219h
    mov     r8, value
    mov     r9, rax
    jmp     short loc_43D1D0
loc_43D18A:
    mov     [rsp+88h+str3], 0; str3
    xor     r14d, r14d
    mov     ecx, offset aNoDeclarationF_1; "No declaration for attribute xmlns of e"...
    mov     rdi, r13; ctxt
    mov     rsi, elem; node
    mov     edx, 215h; error
    mov     r8, r9; str1
    xor     r9d, r9d; str2
    call    xmlErrValidNode
    jmp     loc_43D3A0
loc_43D1B5:
    mov     [rsp+88h+str3], 0; str3
    mov     ecx, offset aValueSForAttri_3; "Value \"%s\" for attribute xmlns of %s "...
    mov     rdi, r13; ctxt
    mov     rsi, elem; node
    mov     edx, 219h; error
    mov     r8, value; str1
loc_43D1D0:
    call    xmlErrValidNode
    xor     r14d, r14d
    jmp     short loc_43D1F4
loc_43D1E0:
    mov     rdi, [tree+8]; str1
    mov     rsi, value; str2
    call    xmlStrEqual
    test    eax, eax
    jnz     short loc_43D228
    mov     tree, [tree+0]
loc_43D1F4:
    test    tree, tree
    jnz     short loc_43D1E0
    mov     tree, [rsp+88h+var_78]
    mov     rax, [rbp+18h]
    mov     r9, [elem+10h]; str2
    test    rax, rax
    jz      short loc_43D234
    mov     [rsp+88h+str3], r9
    mov     ecx, offset aValueSForAttri_4; "Value \"%s\" for attribute xmlns:%s of "...
    mov     rdi, r13
    mov     rsi, elem
    mov     edx, 20Fh
    mov     r8, value
    mov     r9, rax
    jmp     short loc_43D24F
loc_43D228:
    mov     rcx, [rsp+88h+var_80]
    mov     tree, [rsp+88h+var_78]
    jmp     short loc_43D25C
loc_43D234:
    mov     [rsp+88h+str3], 0; str3
    mov     ecx, offset aValueSForAttri_5; "Value \"%s\" for attribute xmlns of %s "...
    mov     rdi, r13; ctxt
    mov     rsi, elem; node
    mov     edx, 20Fh; error
    mov     r8, value; str1
loc_43D24F:
    call    xmlErrValidNode
    xor     r14d, r14d
    mov     rcx, [rsp+88h+var_80]
loc_43D25C:
    mov     eax, [rcx+50h]
    cmp     eax, 9
    jnz     loc_43D11E
loc_43D268:
    mov     [rsp+88h+var_70], ret
    mov     rbp, [rcx+60h]
    test    tree, tree
    jz      short loc_43D299
    nop     word ptr [rax+rax+00000000h]
loc_43D280:
    mov     rdi, [tree+8]; str1
    mov     rsi, value; str2
    call    xmlStrEqual
    test    eax, eax
    jnz     short loc_43D2C8
    mov     tree, [tree+0]
    test    tree, tree
    jnz     short loc_43D280
loc_43D299:
    mov     tree, [rsp+88h+var_78]
    mov     rax, [rbp+18h]
    mov     r9, [elem+10h]; str2
    test    rax, rax
    jz      short loc_43D2E2
    mov     [rsp+88h+str3], r9
    mov     ecx, offset aValueSForAttri_6; "Value \"%s\" for attribute xmlns:%s of "...
    mov     rdi, r13
    mov     rsi, elem
    mov     edx, 1F6h
    mov     r8, value
    mov     r9, rax
    jmp     short loc_43D2FD
loc_43D2C8:
    mov     rcx, [rsp+88h+var_80]
    mov     rbp, [rsp+88h+var_78]
    mov     ret, [rsp+88h+var_70]
    cmp     dword ptr [rcx+54h], 4
    jz      short loc_43D310
    jmp     loc_43D378
loc_43D2E2:
    mov     [rsp+88h+str3], 0; str3
    mov     ecx, offset aValueSForAttri_7; "Value \"%s\" for attribute xmlns of %s "...
    mov     rdi, r13; ctxt
    mov     rsi, elem; node
    mov     edx, 1F6h; error
    mov     r8, value; str1
loc_43D2FD:
    call    xmlErrValidNode
    xor     r14d, r14d
    mov     rcx, [rsp+88h+var_80]
    cmp     dword ptr [rcx+54h], 4
    jnz     short loc_43D378
loc_43D310:
    mov     rdi, [rcx+58h]; str1
    mov     rsi, value; str2
    call    xmlStrEqual
    mov     rcx, [rsp+88h+var_80]
    test    eax, eax
    jnz     short loc_43D378
    mov     r8, [rbp+18h]
    mov     r9, [elem+10h]
    mov     rax, [rcx+58h]
    test    r8, r8
    jz      short loc_43D34D
    mov     [rsp+88h+str3], rax
    mov     ecx, offset aValueForAttrib_3; "Value for attribute xmlns:%s of %s must"...
    mov     rdi, r13
    mov     rsi, elem
    mov     edx, 1FCh
    jmp     short loc_43D36B
loc_43D34D:
    mov     [rsp+88h+str3], 0; str3
    mov     ecx, offset aValueForAttrib_4; "Value for attribute xmlns of %s must be"...
    mov     rdi, r13; ctxt
    mov     rsi, elem; node
    mov     edx, 1FCh; error
    mov     r8, r9; str1
    mov     r9, rax; str2
loc_43D36B:
    call    xmlErrValidNode
    xor     r14d, r14d
    mov     rcx, [rsp+88h+var_80]
loc_43D378:
    mov     rdx, [rbp+18h]
    mov     ecx, [rcx+50h]; type
    mov     rbp, ret
    test    rdx, rdx
    jnz     short loc_43D38C
    mov     edx, (offset aXmlns+2); name
loc_43D38C:
    mov     rdi, r13; ctxt
    mov     rsi, doc; doc
    mov     r8, value; value
    call    xmlValidateAttributeValue2
    mov     r14d, eax
    and     r14d, ebp
loc_43D3A0:
    mov     eax, r14d
    add     rsp, 58h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
xmlValidateOneNamespace endp

