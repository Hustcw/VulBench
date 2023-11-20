sub_400B38 proc
    addiu   $sp, -0x28
    sw      $ra, 0x20+var_s4($sp)
    sw      $fp, 0x20+var_s0($sp)
    move    $fp, $sp
    sw      $a0, 0x20+arg_0($fp)
    sw      $a1, 0x20+arg_4($fp)
    lw      $v0, 0x20+arg_0($fp)
    move    $v1, $v0
    lw      $v0, 0x20+arg_4($fp)
    move    $a0, $v1 # s
    move    $a1, $zero # c
    move    $a2, $v0 # n
    jal     memset
    move    $at, $at
    sw      $zero, 0x20+var_8($fp)
    sw      $zero, 0x20+var_8($fp)
    j       loc_400BE0
    move    $at, $at
    sb      $zero, 0x20+var_4($fp)
    addiu   $v0, $fp, 0x20+var_4
    move    $a0, $zero # fd
    move    $a1, $v0 # buf
    li      $a2, 1 # nbytes
    jal     read
    move    $at, $at
    bgez    $v0, loc_400BB0
    move    $at, $at
    move    $a0, $zero # status
    jal     exit
    move    $at, $at
    lb      $v1, 0x20+var_4($fp)
    li      $v0, 0xA
    beq     $v1, $v0, loc_400C00
    move    $at, $at
    lw      $v0, 0x20+var_8($fp)
    lw      $v1, 0x20+arg_0($fp)
    addu    $v0, $v1, $v0
    lb      $v1, 0x20+var_4($fp)
    sb      $v1, 0($v0)
    lw      $v0, 0x20+var_8($fp)
    addiu   $v0, 1
    sw      $v0, 0x20+var_8($fp)
loc_400BE0:
    lw      $v1, 0x20+var_8($fp)
    lw      $v0, 0x20+arg_4($fp)
    addiu   $v0, -1
    sltu    $v0, $v1, $v0
    bnez    $v0, loc_400B80
    move    $at, $at
    j       loc_400C04
    move    $at, $at
    move    $at, $at
loc_400C04:
    lw      $v0, 0x20+arg_4($fp)
    addiu   $v0, -1
    lw      $v1, 0x20+arg_0($fp)
    addu    $v0, $v1, $v0
    sb      $zero, 0($v0)
    move    $sp, $fp
    lw      $ra, 0x20+var_s4($sp)
    lw      $fp, 0x20+var_s0($sp)
    addiu   $sp, 0x28
    jr      $ra
    move    $at, $at
sub_400B38 endp

