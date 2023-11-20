sub_B7D proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, s; "======================"
    call    puts
    lea     rdi, a1AddAStory; "1.Add a story"
    call    puts
    lea     rdi, a2EditStory; "2.Edit story"
    call    puts
    lea     rdi, a3ShowStory; "3.Show story"
    call    puts
    lea     rdi, a4DeleteAStory; "4.delete a story"
    call    puts
    lea     rdi, a5Exit; "5.Exit ."
    call    puts
    lea     rdi, s; "======================"
    call    puts
    lea     rdi, format; "Input your choice:"
    mov     eax, 0
    call    printf
    nop
    pop     rbp
    retn
sub_B7D endp

