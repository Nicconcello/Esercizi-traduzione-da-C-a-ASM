.globl adler32_simplified

adler32_simplified:
    #PROLOGO
    pushl %ebx
    pushl %esi
    pushl %edi
    pushl %ebp

    movl 20(%esp),%ebx
    movl 24(%esp),%esi
    movl $1,%edi
    xorl %ebp,%ebp
    movl $-1,%ecx

    E:
        incl %ecx;
        cmpl %esi,%ecx
        jge F

        movzbl (%ebx,%ecx,1),%edx
        addl %edx,%edi
        andl $0xFFFF,%edi

        addl %edi,%ebp
        andl $0xFFFF,%ebp

        jmp E
    F:
        sall $16,%ebp
        orl %edi,%ebp
        movl %ebp,%eax
    #EPILOGO
        popl %ebp
        popl %edi
        popl %esi
        popl %ebx

        ret
