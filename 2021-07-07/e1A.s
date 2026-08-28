.globl suffix

suffix:
    #PROLOGO
    pushl %ebx
    pushl %esi
    pushl %edi
    pushl %ebp
    subl $4,%esp

    movl 24(%esp),%ebx
    movl 28(%esp),%ebp
    
    movl %ebx,(%esp)
    call strlen
    movl %eax,%esi

    movl %ebp,(%esp)
    call strlen
    movl %eax,%edi

    movl %esi,%ecx
    subl %edi,%ecx

    cmpl %esi,%edi
    jg Z

    F:
        cmpl %esi,%ecx
        jge U

        movb (%ebp),%dl
        cmpb %dl,(%ebx,%ecx,1)
        jne Z

        incl %ebp
        incl %ecx
        jmp F
    U:
        movl $1,%eax
        jmp R
    Z:
        xorl %eax,%eax
    R:
    #EPILOGO
        addl $4,%esp
        popl %ebp
        popl %edi
        popl %esi
        popl %ebx

        ret
