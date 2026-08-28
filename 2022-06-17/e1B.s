.globl crc32b

crc32b:
    #PROLOGO
    pushl %ebx
    pushl %esi
    pushl %edi
    pushl %ebp
    subl $12,%esp

    movl 32(%esp),%ebx
    movl 36(%esp),%esi
    xorl %edi,%edi
    notl %edi
    movl %edi,%ebp

    E:
        cmpl $0,%esi
        je F
        movl (%ebx),%edx
        incl %ebx
        movl %ebp,%eax
        xorl %edx,%eax

        andl $0xFF,%eax
        leal 8(%esp),%ecx
        movl %ecx,(%esp)
        movl %eax,4(%esp)
        call get_constant

        sarl $8,%ebp
        movl 8(%esp),%ecx
        xorl %ecx,%ebp

        decl %esi
        jmp E
    F:
        movl %ebp,%eax
        xorl %edi,%eax
    #EPILOGO
        addl $12,%esp
        popl %ebp
        popl %edi
        popl %esi
        popl %ebx

        ret
        