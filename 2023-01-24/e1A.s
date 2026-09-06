.globl strings_are_upper

strings_are_upper:
    #PROLOGO
    pushl %ebx
    pushl %esi
    pushl %edi
    pushl %ebp
    subl $4,%esp

    movl 24(%esp),%ebx

    cmpl $0,%ebx
    je N

    cmpl $0,28(%esp)
    jle N

    movl 28(%esp),%ecx
    imul $4,%ecx
    movl %ecx,(%esp)
    call malloc
    movl %eax,%edi

    movl $-1,%ebp

    E:
        incl %ebp

        cmpl 28(%esp),%ebp
        jge F

        movl (%ebx,%ebp,4),%esi

        movl $1,(%edi,%ebp,4)

        C:
            cmpb $0,(%esi)
            je E

            movb (%esi),%ch
            movb %ch,(%esp)
            call isupper
            cmpl $0,%eax
            jne A

            movl $0,(%edi,%ebp,4)
            jmp E

            A:
                incl %esi
                jmp C
    F:
        movl %edi,%eax
    #EPILOGO
        addl $4,%esp
        popl %ebp
        popl %edi
        popl %esi
        popl %ebx

        ret
    N:
        xorl %edi,%edi
        jmp F
