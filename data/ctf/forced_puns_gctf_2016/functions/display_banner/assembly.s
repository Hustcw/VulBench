display_banner proc
    STP             X29, X30, [SP,#var_20]!
    MOV             W0, #1; fd
    MOV             X29, SP
    STR             X19, [SP,#0x20+var_10]
    ADRP            X19, #banner_len@PAGE
    ADD             X1, X19, #banner_len@PAGEOFF
    ADD             X1, X1, #8; buf
    LDR             W2, [X19,#banner_len@PAGEOFF]; n
    BL              .write
    LDR             W1, [X19,#banner_len@PAGEOFF]
    CMP             X0, X1
    B.NE            loc_1008
    LDR             X19, [SP,#0x20+var_10]
    LDP             X29, X30, [SP+0x20+var_20],#0x20
    RET
    ADRP            X1, #aWritingBanner@PAGE; "writing banner"
    MOV             W0, #1; status
    ADD             X1, X1, #aWritingBanner@PAGEOFF; "writing banner"
    BL              .err
display_banner endp

