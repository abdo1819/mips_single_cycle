addi	$t0, $0, 14		    # $t0 = 0b1110            2008000e                   
addi	$t1, $0, 0x1		# $t1 = 0x1               20090001   
sllv    $t2, $t0, $t1       # $t2 = 0b11100           01285004       
srl     $t2, $t2, 2         # $t2 = 7                 000a5082   
sw      $t2, 84($0)         # addr 84, write 0x7      ac0a0054               
