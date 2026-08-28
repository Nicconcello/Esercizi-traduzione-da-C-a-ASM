.globl crc32

crc32:
    #PROLOGO
    pushl %ebx
    pushl %esi
    pushl %edi
    pushl %ebp

    movl 20(%esp),%ebp
    movl $-1,%esi
    movl $0xFFFFFFFF,%ebx

    E:
        incl %esi
        cmpl 24(%esp),%esi
        jge F

        movsbl (%ebp,%esi,1),%ecx
        xorl %ecx,%ebx

        xorl %edi,%edi
        C:
            cmpl $8,%edi
            jge E

            movl %ebx,%edx
            andl $1,%edx
            imull $-1,%edx
            andl $0xEDB88320,%edx
            sarl $1,%ebx
            xorl %edx,%ebx
            incl %edi
            jmp C
    F:
        movl %ebx,%eax
        notl %eax
    #EPILOGO
        popl %ebp
        popl %edi
        popl %esi
        popl %ebx

        ret
