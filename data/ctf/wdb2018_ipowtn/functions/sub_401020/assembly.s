sub_401020 proc
    addiu   $sp, -0x28
    sw      $ra, 0x20+var_s4($sp)
    sw      $fp, 0x20+var_s0($sp)
    move    $fp, $sp
    sw      $a0, 0x20+arg_0($fp)
    jal     rand
    move    $at, $at
    move    $v1, $v0
    lw      $v0, 0x20+arg_0($fp)
    div     $v1, $v0
    teq     $v0, $zero  #7
    mfhi    $v0
    sw      $v0, 0x20+var_8($fp)
    lw      $v0, 0x20+var_8($fp)
    move    $sp, $fp
    lw      $ra, 0x20+var_s4($sp)
    lw      $fp, 0x20+var_s0($sp)
    addiu   $sp, 0x28
    jr      $ra
    move    $at, $at
sub_401020 endp

