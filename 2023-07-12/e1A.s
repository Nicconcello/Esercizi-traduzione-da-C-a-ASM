.globl adler32

adler32:
    #PROLOGO
    pushl %ebx
    pushl %esi
    pushl %edi
    pushl %ebp
    subl $8,%esp

    movl 28(%esp),%ebx

    cmpl $0,%ebx
    je Z
    cmpl $0,32(%esp)
    je Z

    movl $1,%esi
    xorl %edi,%edi

    leal 4(%esp),%ebp
    movl %ebp,(%esp)
    call get_adler_constant
    movl 4(%esp),%ebp

    movl $-1,%ecx

    F:
        incl %ecx
        cmpl 32(%esp),%ecx
        jae S

        movzbl (%ebx,%ecx,1),%edx
        addl %edx,%esi
        movl %esi,%eax
        xorl %edx,%edx
        idivl %ebp
        movl %edx,%esi

        addl %esi,%edi
        movl %edi,%eax
        xorl %edx,%edx
        idivl %ebp
        movl %edx,%edi

        jmp F
    S:
        movl %edi,%eax
        shll $16,%eax
        orl %esi,%eax
        jmp R
    Z:
        xorl %eax,%eax
    R:
    #EPILOGO
        addl $8,%esp
        popl %ebp
        popl %edi
        popl %esi
        popl %ebx

        ret
        