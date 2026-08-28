.globl div_vectors

div_vectors:
    #PROLOGO
    pushl %ebx
    pushl %esi
    pushl %edi
    pushl %ebp
    subl $4,%esp

    movl 24(%esp),%ebx
    movl 28(%esp),%esi
    movl 32(%esp),%edi

    cmpl $0,%ebx
    je N
    cmpl $0,%esi
    je N
    cmpl $0,%edi
    je N

    movl %edi,%ecx
    imull $4,%ecx
    movl %ecx,(%esp)
    call malloc
    movl %eax,%ebp

    xorl %ecx,%ecx

    E:
        cmpl %edi,%ecx
        jge F

        movl (%ebx,%ecx,4),%eax
        idivl (%esi,%ecx,4),%eax
        movl %eax,(%ebp,%ecx,4)
        incl %ecx
        jmp E
    F:
        movl %ebp,%eax
        jmp R
    N:
        xorl %eax,%eax
    R:
    #EPILOGO
        addl $4,%esp
        popl %ebp
        popl %edi
        popl %esi
        popl %ebx

        ret
