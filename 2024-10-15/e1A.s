.globl cond_compute 

cond_compute:
    #PROLOGO
    pushl %ebx
    pushl %esi
    pushl %edi
    pushl %ebp
    subl $12,%esp

    movl 32(%esp),%ebx
    movl 36(%esp),%esi
    movl 44(%esp),%edi
    movl $-1,%ebp

    E:
        incl %ebp

        cmpl 40(%esp),%ebp
        jge F

        movb (%ebx,%ebp,1),%dl
        movb %dl,(%edi,%ebp,1)

        cmpl $0,(%esi,%ebp,4)
        je E

        movb (%edi,%ebp,1),%dl
        movb %dl,(%esp)
        leal 8(%esp),%ecx
        movl %ecx,4(%esp)
        call compute 

        movb 8(%esp),%cl
        movb %cl,(%edi,%ebp,1)
        jmp E
    F:
    #EPILOGO
        movl %edi,%eax

        addl $12,%esp
        popl %ebp
        popl %edi
        popl %esi
        popl %ebx

        ret
