.globl _transform

_transform:
    #PROLOGO
    pushl %ebx
    pushl %esi
    pushl %edi
    pushl %ebp
    subl $8,%esp

    movl 28(%esp),%ebx
    movl 36(%esp),%esi
    xorl %edi,%edi
    xorl %ebp,%ebp

    E:
        cmpl 32(%esp),%edi
        jae F

        cmpl (%ebx,%edi,4),%ebp
        ja I

        movl (%ebx,%edi,4),%edx
        movl %edx,(%esi,%edi,4)
        jmp C

        I:
            movl %edi,%ecx
            incl %ecx
            movl %ebp,(%esp)
            movl %ecx,4(%esp)
            call _average
            movl %eax,(%esi,%edi,4)
        C:
            addl (%ebx,%edi,4),%ebp
            incl %edi
            jmp E
    F:
        movl %ebp,%eax
        #EPILOGO
        addl $8,%esp
        popl %ebp
        popl %edi
        popl %esi
        popl %ebx

        ret
