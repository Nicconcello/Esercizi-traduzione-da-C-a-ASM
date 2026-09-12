.globl cond_compute

cond_compute:
    #PROLOGO
    pushl %ebx
    pushl %esi
    pushl %edi
    pushl %ebp
    subl $4,%esp

    movl 24(%esp),%ebx
    movl 28(%esp),%esi
    movl 36(%esp),%edi
    xorl %ebp,%ebp

    E:
        cmpl 32(%esp),%ebp
        jge F

        cmpl $0,(%esi,%ebp,4)
        jne L

        movw (%ebx,%ebp,2),%cx
        movw %cx,(%edi,%ebp,2)

        jmp A

        L:
            movw (%ebx,%ebp,2),%cx
            movw %cx,(%esp)
            call compute
            movw %ax,(%edi,%ebp,2)
        A:
            incl %ebp
            jmp E
    F:
    #EPILOGO
        addl $4,%esp
        popl %ebp
        popl %edi
        popl %esi
        popl %ebx 

        ret
