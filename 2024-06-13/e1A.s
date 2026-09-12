.globl deleetify

deleetify:
    #PROLOGO
    pushl %ebx
    pushl %esi
    pushl %edi
    pushl %ebp
    subl $4,%esp

    movl 24(%esp),%ebx
    movl 28(%esp),%esi
    
    movl %esi,%ecx
    imull $4,%ecx
    movl %ecx,(%esp)
    call malloc
    movl %eax,%edi

    xorl %ebp,%ebp

    E:
        cmpl %esi,%ebp
        jae F

        cmpb $57,(%ebx,%ebp,1)
        jbe L

        movb (%ebx,%ebp,1),%dl
        movb %dl,(%edi,%ebp,1)
        jmp A;

        L:
            movb (%ebx,%ebp,1),%dl
            movb %dl,(%esp)
            call deleetify_helper
            movb %al,(%edi,%ebp,1)
        A:
            incl %ebp
            jmp E
    F:
        movl %edi,%eax
    #EPILOGO
        addl $4,%esp
        popl %ebp
        popl %edi
        popl %esi
        popl %ebx

        ret
