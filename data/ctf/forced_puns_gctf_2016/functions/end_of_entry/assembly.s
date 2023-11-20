end_of_entry proc
    B               loc_F5C
    MOV             X0, X1
    LDR             X1, [X0,#0x10]
    CBNZ            X1, loc_F58
    RET
end_of_entry endp

