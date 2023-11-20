xmlValidateOneNamespace proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 58h
    mov     [rsp+88h+str1], value
    xor     r14d, r14d
    test    doc, doc
    jz      loc_43D2C3
    mov     rbp, ns
    mov     rbx, elem
    mov     r12, doc
    mov     r15, ctxt
    mov     rdi, [rsi+50h]
    test    rdi, rdi
    jz      loc_43CD4B
    test    elem, elem
    jz      loc_43D2C3
loc_43CCB1:
    test    ns, ns
    jz      loc_43D2C3
    mov     rsi, [elem+10h]
    test    rsi, rsi
    jz      loc_43D2C3
    cmp     qword ptr [ns+10h], 0
    jz      loc_43D2C3
    test    prefix, prefix
    mov     [rsp+88h+attr], ns
    jz      loc_43CDE2
    mov     [rsp+88h+var_78], ctxt
    lea     rdx, [rsp+88h+memory]; memory
    mov     rdi, rsi; ncname
    mov     rsi, prefix; prefix
    mov     ecx, 32h ; '2'; len
    call    xmlBuildQName
    test    rax, rax
    jz      short loc_43CD65
    mov     r15, rax
    mov     rdx, [ns+18h]; name
    mov     rdi, [doc+50h]; dtd
    test    rdx, rdx
    jz      short loc_43CD79
    mov     ecx, (offset aXmlns+2); prefix
    mov     rsi, fullname; elem
    call    xmlGetDtdQAttrDesc
    mov     r13, attrDecl
    test    rax, rax
    jnz     loc_43CDAD
    mov     rdi, [doc+58h]; dtd
    test    rdi, rdi
    jz      short loc_43CDAA
    mov     rax, [rsp+88h+attr]
    mov     rdx, [rax+18h]; name
    mov     ecx, (offset aXmlns+2); prefix
    mov     rsi, fullname; elem
    call    xmlGetDtdQAttrDesc
    jmp     short loc_43CDA5
loc_43CD4B:
    test    elem, elem
    jz      loc_43D2C3
    cmp     qword ptr [doc+58h], 0
    jnz     loc_43CCB1
    jmp     loc_43D2C3
loc_43CD65:
    mov     esi, offset aValidatingName; "Validating namespace"
    mov     rdi, [rsp+88h+var_78]; ctxt
    call    xmlVErrMemory
    jmp     loc_43D2C3
loc_43CD79:
    mov     edx, (offset aXmlns+2); name
    mov     rsi, fullname; elem
    call    xmlGetDtdAttrDesc
    mov     r13, attrDecl
    test    rax, rax
    jnz     short loc_43CDAD
    mov     rdi, [doc+58h]; dtd
    test    rdi, rdi
    jz      short loc_43CDAA
    mov     edx, (offset aXmlns+2); name
    mov     rsi, fullname; elem
    call    xmlGetDtdAttrDesc
loc_43CDA5:
    mov     attrDecl, rax
    jmp     short loc_43CDAD
loc_43CDAA:
    xor     r13d, r13d
loc_43CDAD:
    lea     rax, [rsp+88h+memory]
    cmp     fullname, rax
    jz      short loc_43CDC6
    cmp     fullname, [elem+10h]
    jz      short loc_43CDC6
    mov     rdi, fullname; ptr
    call    cs:xmlFree
loc_43CDC6:
    test    r13, r13
    mov     r15, [rsp+88h+var_78]
    jnz     loc_43CE5E
    mov     rdi, [doc+50h]; dtd
    mov     rsi, [elem+10h]; elem
    mov     ns, [rsp+88h+attr]
loc_43CDE2:
    mov     rdx, [rbp+18h]; name
    test    rdx, rdx
    jz      short loc_43CE24
    mov     ecx, (offset aXmlns+2); prefix
    call    xmlGetDtdQAttrDesc
    mov     r13, rax
    test    rax, rax
    jnz     short loc_43CE5E
    mov     rdi, [doc+58h]; dtd
    test    rdi, rdi
    jz      loc_43CF0F
    mov     rsi, [elem+10h]; elem
    mov     rax, [rsp+88h+attr]
    mov     rdx, [rax+18h]; name
    mov     ecx, (offset aXmlns+2); prefix
    call    xmlGetDtdQAttrDesc
    jmp     short loc_43CE52
loc_43CE24:
    mov     edx, (offset aXmlns+2); name
    call    xmlGetDtdAttrDesc
    mov     r13, rax
    test    rax, rax
    jnz     short loc_43CE5E
    mov     rdi, [doc+58h]; dtd
    test    rdi, rdi
    jz      loc_43CF0F
    mov     rsi, [elem+10h]; elem
    mov     edx, (offset aXmlns+2); name
    call    xmlGetDtdAttrDesc
loc_43CE52:
    mov     attrDecl, rax
    test    rax, rax
    jz      loc_43CF0F
loc_43CE5E:
    mov     esi, [r13+50h]; type
    mov     rdi, doc; doc
    mov     rdx, [rsp+88h+str1]; value
    call    xmlValidateAttributeValueInternal
    mov     r14d, 1
    test    eax, eax
    jz      short loc_43CECD
    cmp     dword ptr [r13+54h], 4
    jnz     loc_43CF9F
loc_43CE84:
    mov     rsi, [r13+58h]; str2
    mov     rdi, [rsp+88h+str1]; str1
    call    xmlStrEqual
    test    eax, eax
    jnz     loc_43CF9F
    mov     rax, [rsp+88h+attr]
    mov     r8, [rax+18h]
    mov     r9, [elem+10h]
    mov     rax, [r13+58h]
    test    r8, r8
    jz      loc_43CF79
    mov     [rsp+88h+str3], rax
    mov     ecx, offset aValueForAttrib_1; "Value for attribute xmlns:%s of %s is d"...
    mov     rdi, r15
    mov     rsi, elem
    mov     edx, 1F4h
    jmp     loc_43CF97
loc_43CECD:
    mov     val, [rsp+88h+attr]
    mov     r8, [rax+18h]; str1
    mov     r9, [elem+10h]; str2
    test    r8, r8
    jz      short loc_43CF47
    mov     [rsp+88h+str3], 0; str3
    mov     ecx, offset aSyntaxOfValueF_0; "Syntax of value for attribute xmlns:%s "...
    mov     rdi, r15; ctxt
    mov     rsi, elem; node
    mov     edx, 204h; error
    call    xmlErrValidNode
    xor     r14d, r14d
    cmp     dword ptr [r13+54h], 4
    jz      loc_43CE84
    jmp     loc_43CF9F
loc_43CF0F:
    mov     rax, [rsp+88h+attr]
    mov     r8, [rax+18h]; str1
    mov     r9, [elem+10h]; str2
    test    r8, r8
    jz      loc_43D150
    mov     [rsp+88h+str3], 0; str3
    mov     ecx, offset aNoDeclarationF_0; "No declaration for attribute xmlns:%s o"...
    mov     rdi, r15; ctxt
    mov     rsi, elem; node
    mov     edx, 215h; error
    call    xmlErrValidNode
    jmp     loc_43D2C3
loc_43CF47:
    mov     [rsp+88h+str3], 0; str3
    xor     r14d, r14d
    mov     ecx, offset aSyntaxOfValueF_1; "Syntax of value for attribute xmlns of "...
    mov     rdi, r15; ctxt
    mov     rsi, elem; node
    mov     edx, 204h; error
    mov     r8, r9; str1
    xor     r9d, r9d; str2
    call    xmlErrValidNode
    cmp     dword ptr [r13+54h], 4
    jnz     short loc_43CF9F
    jmp     loc_43CE84
loc_43CF79:
    mov     [rsp+88h+str3], 0; str3
    mov     ecx, offset aValueForAttrib_2; "Value for attribute xmlns of %s is diff"...
    mov     rdi, r15; ctxt
    mov     rsi, elem; node
    mov     edx, 1F4h; error
    mov     r8, r9; str1
    mov     r9, rax; str2
loc_43CF97:
    call    xmlErrValidNode
    xor     r14d, r14d
loc_43CF9F:
    mov     eax, [r13+50h]
    cmp     eax, 2
    jnz     short loc_43CFCA
    mov     rdi, r15; ctxt
    mov     rsi, doc; doc
    mov     rdx, [rsp+88h+str1]; value
    mov     rcx, [rsp+88h+attr]; attr
    call    xmlAddID
    xor     ecx, ecx
    test    rax, rax
    cmovz   r14d, ecx
    mov     eax, [r13+50h]
loc_43CFCA:
    lea     ecx, [rax-3]
    cmp     ecx, 1
    ja      loc_43D087
    mov     rdi, r15; ctxt
    mov     rsi, doc; doc
    mov     rdx, [rsp+88h+str1]; value
    mov     rcx, [rsp+88h+attr]; attr
    call    xmlAddRef
    xor     ecx, ecx
    test    rax, rax
    cmovz   r14d, ecx
    mov     eax, [r13+50h]
    cmp     eax, 0Ah
    jz      loc_43D090
loc_43D001:
    cmp     dword ptr [r13+50h], 9
    jnz     loc_43D225
loc_43D00C:
    mov     [rsp+88h+var_78], elem
    mov     rax, r13
    mov     rbp, [r13+60h]
    test    tree, tree
    mov     rbx, [rsp+88h+str1]
    jz      short loc_43D04D
    nop     word ptr [rax+rax+00000000h]
    nop     dword ptr [rax+00h]
loc_43D030:
    mov     rdi, [tree+8]; str1
    mov     rsi, rbx; str2
    call    xmlStrEqual
    test    eax, eax
    jnz     loc_43D105
    mov     tree, [tree+0]
    test    tree, tree
    jnz     short loc_43D030
loc_43D04D:
    mov     rax, [rsp+88h+attr]
    mov     rax, [rax+18h]
    mov     tree, [rsp+88h+var_78]
    mov     r9, [rbp+10h]; str2
    test    rax, rax
    jz      loc_43D117
    mov     [rsp+88h+str3], r9
    mov     ecx, offset aValueSForAttri_2; "Value \"%s\" for attribute xmlns:%s of "...
    mov     rdi, r15
    mov     rsi, rbp
    mov     edx, 1F6h
    mov     r8, rbx
    mov     r9, rax
    jmp     loc_43D132
loc_43D087:
    cmp     eax, 0Ah
    jnz     loc_43D001
loc_43D090:
    mov     rax, r13
    mov     r13, r15
    mov     [rsp+88h+var_78], rax
    mov     rbp, [rax+60h]
    mov     rdi, [doc+50h]; dtd
    mov     r15, [rsp+88h+str1]
    mov     rsi, r15; name
    call    xmlGetDtdNotationDesc
    test    nota, nota
    jnz     loc_43D1B4
    mov     rdi, [doc+58h]; dtd
    mov     rsi, r15; name
    call    xmlGetDtdNotationDesc
    test    nota, nota
    jnz     loc_43D1B4
    mov     nota, [rsp+88h+attr]
    mov     rax, [rax+18h]
    mov     r9, [elem+10h]; str2
    test    rax, rax
    jz      loc_43D17B
    mov     [rsp+88h+str3], r9
    mov     ecx, offset aValueSForAttri_3; "Value \"%s\" for attribute xmlns:%s of "...
    mov     rdi, r13
    mov     rsi, elem
    mov     edx, 219h
    mov     r8, r15
    mov     r9, rax
    jmp     loc_43D196
loc_43D105:
    mov     rbx, [rsp+88h+var_78]
    cmp     dword ptr [r13+54h], 4
    jz      loc_43D230
    jmp     short loc_43D148
loc_43D117:
    mov     [rsp+88h+str3], 0; str3
    mov     ecx, offset aValueSForAttri_4; "Value \"%s\" for attribute xmlns of %s "...
    mov     rdi, r15; ctxt
    mov     rsi, rbp; node
    mov     edx, 1F6h; error
    mov     r8, rbx; str1
loc_43D132:
    call    xmlErrValidNode
    xor     r14d, r14d
    mov     rbx, rbp
    cmp     dword ptr [r13+54h], 4
    jz      loc_43D230
loc_43D148:
    mov     rbp, ret
    jmp     loc_43D296
loc_43D150:
    mov     [rsp+88h+str3], 0; str3
    xor     r14d, r14d
    mov     ecx, offset aNoDeclarationF_1; "No declaration for attribute xmlns of e"...
    mov     rdi, r15; ctxt
    mov     rsi, elem; node
    mov     edx, 215h; error
    mov     r8, r9; str1
    xor     r9d, r9d; str2
    call    xmlErrValidNode
    jmp     loc_43D2C3
loc_43D17B:
    mov     [rsp+88h+str3], 0; str3
    mov     ecx, offset aValueSForAttri_5; "Value \"%s\" for attribute xmlns of %s "...
    mov     rdi, r13; ctxt
    mov     rsi, elem; node
    mov     edx, 219h; error
    mov     r8, r15; str1
loc_43D196:
    call    xmlErrValidNode
    xor     r14d, r14d
    jmp     short loc_43D1B4
loc_43D1A0:
    mov     rdi, [tree+8]; str1
    mov     rsi, r15; str2
    call    xmlStrEqual
    test    eax, eax
    jnz     short loc_43D1EA
    mov     tree, [tree+0]
loc_43D1B4:
    test    tree, tree
    jnz     short loc_43D1A0
    mov     rax, [rsp+88h+attr]
    mov     rax, [rax+18h]
    mov     r9, [elem+10h]; str2
    test    rax, rax
    jz      short loc_43D1EF
    mov     [rsp+88h+str3], r9
    mov     ecx, offset aValueSForAttri_6; "Value \"%s\" for attribute xmlns:%s of "...
    mov     r8, r15
    mov     r15, r13
    mov     rdi, r13
    mov     rsi, elem
    mov     edx, 20Fh
    mov     r9, rax
    jmp     short loc_43D20D
loc_43D1EA:
    mov     r15, r13
    jmp     short loc_43D215
loc_43D1EF:
    mov     [rsp+88h+str3], 0; str3
    mov     ecx, offset aValueSForAttri_7; "Value \"%s\" for attribute xmlns of %s "...
    mov     r8, r15; str1
    mov     r15, r13
    mov     rdi, r13; ctxt
    mov     rsi, elem; node
    mov     edx, 20Fh; error
loc_43D20D:
    call    xmlErrValidNode
    xor     r14d, r14d
loc_43D215:
    mov     r13, [rsp+88h+var_78]
    cmp     dword ptr [r13+50h], 9
    jz      loc_43D00C
loc_43D225:
    cmp     dword ptr [r13+54h], 4
    jnz     loc_43D148
loc_43D230:
    mov     rdi, [r13+58h]; str1
    mov     rsi, [rsp+88h+str1]; str2
    call    xmlStrEqual
    test    eax, eax
    mov     rbp, ret
    jnz     short loc_43D296
    mov     rax, [rsp+88h+attr]
    mov     r8, [rax+18h]
    mov     r9, [rbx+10h]
    mov     rax, [r13+58h]
    test    r8, r8
    jz      short loc_43D271
    mov     [rsp+88h+str3], rax
    mov     ecx, offset aValueForAttrib_3; "Value for attribute xmlns:%s of %s must"...
    mov     rdi, r15
    mov     rsi, rbx
    mov     edx, 1FCh
    jmp     short loc_43D28F
loc_43D271:
    mov     [rsp+88h+str3], 0; str3
    mov     ecx, offset aValueForAttrib_4; "Value for attribute xmlns of %s must be"...
    mov     rdi, r15; ctxt
    mov     rsi, rbx; node
    mov     edx, 1FCh; error
    mov     r8, r9; str1
    mov     r9, rax; str2
loc_43D28F:
    call    xmlErrValidNode
    xor     ebp, ebp
loc_43D296:
    mov     rax, [rsp+88h+attr]
    mov     rdx, [rax+18h]
    mov     ecx, [r13+50h]; type
    test    rdx, rdx
    jnz     short loc_43D2AD
    mov     edx, (offset aXmlns+2); name
loc_43D2AD:
    mov     rdi, r15; ctxt
    mov     rsi, doc; doc
    mov     r8, [rsp+88h+str1]; value
    call    xmlValidateAttributeValue2
    mov     r14d, eax
    and     r14d, ebp
loc_43D2C3:
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

