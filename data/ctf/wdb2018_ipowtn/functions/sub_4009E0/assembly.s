sub_4009E0 proc
    addiu   $sp, -0x20
    sw      $ra, 0x18+var_s4($sp)
    sw      $fp, 0x18+var_s0($sp)
    move    $fp, $sp
    sw      $a0, 0x18+arg_0($fp)
    li      $a0, 1 # status
    jal     exit
    move    $at, $at
sub_4009E0 endp

