.globl count_vars

count_vars:
    #PROLOGO
    pushl %ebx
    pushl %esi
    pushl %edi
    pushl %ebp
    subl $4,%esp

    movl 24(%esp),%ebx
    movl 28(%esp),%esi
    xorl %edi,%edi

    cmpl $0,%ebx
    je N
    cmpl $0,%esi
    jle N

    movl %esi,%eax
    imull $4,%eax
    movl %eax,(%esp)
    call malloc
    movl %eax,%ebp

    E:
        cmpl %esi,%edi
        jge F

        movl (%ebx,%edi,4),%eax
        movl %eax,(%esp)
        call getenv
        cmpl $0,%eax
        je A

        movl $1,(%ebp,%edi,4)
        jmp R

        A:
            movl $0,(%ebp,%edi,4)
        R:
            incl %edi
            jmp E
    F:
        movl %ebp,%eax
        jmp Z
    N:
        xorl %eax,%eax
        jmp Z
    Z:
    #EPILOGO
        addl $4,%esp
        popl %ebp
        popl %edi
        popl %esi
        popl %ebx

        ret
        