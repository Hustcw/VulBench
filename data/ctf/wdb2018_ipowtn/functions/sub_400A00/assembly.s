sub_400A00 proc
    addiu   $sp, -0x20
    sw      $ra, 0x18+var_s4($sp)
    sw      $fp, 0x18+var_s0($sp)
    move    $fp, $sp
    lw      $v0, stdout
    move    $a0, $v0 # stream
    move    $a1, $zero # buf
    li      $a2, 2 # modes
    move    $a3, $zero # n
    jal     setvbuf
    move    $at, $at
    lw      $v0, stdin
    move    $a0, $v0 # stream
    move    $a1, $zero # buf
    li      $a2, 2 # modes
    move    $a3, $zero # n
    jal     setvbuf
    move    $at, $at
    li      $a0, 0xE # sig
    lui     $v0, 0x40  # '@'
    addiu   $a1, $v0, (sub_4009E0 - 0x400000) # handler
    jal     signal
    move    $at, $at
    li      $a0, 0 # seconds
    jal     alarm
    move    $at, $at
    move    $sp, $fp
    lw      $ra, 0x18+var_s4($sp)
    lw      $fp, 0x18+var_s0($sp)
    addiu   $sp, 0x20
    jr      $ra
    move    $at, $at
sub_400A00 endp

