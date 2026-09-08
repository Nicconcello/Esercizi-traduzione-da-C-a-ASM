.globl rc4_encrypt

rc4_encrypt:
    #PROLOGO
    pushl %ebx
    pushl %esi
    pushl %edi
    pushl %ebp
    subl $20,%esp

    xorl %ebx,%ebx
    xorl %esi,%esi
    xorl %edi,%edi
    movl 44(%esp),%ebp

    E:
        cmpb $0,(%ebp)
        je F

        incl %esi
        andl $255,%esi

        movl 40(%esp),%edx
        addl (%edx,%esi,1),%edi

        movl %edx,(%esp)
        movl %esi,4(%esp)
        movl %edi,8(%esp)

        leal 16(%esp),%ecx
        movl %ecx,12(%esp)

        call rc4_helper

        movl 16(%esp),%ecx
        xorb (%ebp),%cl
        movl 48(%esp),%edx
        movb %cl,(%edx,%ebx,1)
        incl %ebp
        incl %ebx

        jmp E
    F:
    #EPPILOGO
        addl $20,%esp
        popl %ebp
        popl %edi
        popl %esi
        popl %ebx

        ret
        