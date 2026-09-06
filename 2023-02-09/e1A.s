.globl check_quiz

check_quiz:
    #PROLOGO
    pushl %ebx
    pushl %esi
    pushl %edi
    pushl %ebp
    subl $4,%esp

    movl 24(%esp),%ebx
    movl 28(%esp),%esi

    cmpl $0,%ebx
    je N

    cmpl $0,%esi
    je N

    cmpl $0,32(%esp)
    je N

    movl 32(%esp),%eax
    imull $4,%eax
    movl %eax,(%esp)
    call malloc

    movl $-1,%edi

    E:
        incl %edi
        cmpl 32(%esp),%edi
        jge F

        movl $0,(%eax,%edi,4)

        xorl %ebp,%ebp

        C:
            cmpl $4,%ebp
            jge E

            movl (%ebx,%edi,4),%ecx

            movb (%esi,%ebp,1),%dl
            cmpb %dl,(%ecx,%ebp,1)
            jne A

            incl (%eax,%edi,4)

            A:
                incl %ebp
                jmp C
    F:
    #EPILOGO
        addl $4,%esp
        popl %ebp
        popl %edi
        popl %esi
        popl %ebx

        ret

    N:
        xorl %eax,%eax
        jmp F