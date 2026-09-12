.globl deleetify

deleetify:
    #PROLOGO
    pushl %ebx
    pushl %esi
    pushl %edi
    pushl %ebp
    subl $12,%esp

    movl 32(%esp),%ebp
    movl 40(%esp),%esi
    xorl %edi,%edi

    E:
        cmpl 36(%esp),%edi
        jae F

        cmpb $57,(%ebp,%edi,1)
        jbe L

        movb (%ebp,%edi,1),%cl
        movb %cl,(%esi,%edi,1)
        jmp C

        L:
            movzbl (%ebp,%edi,1),%ecx
            movl %ecx,(%esp)

            leal 8(%esp),%ebx
            movl %ebx,4(%esp)

            call deleetify_helper

            movb 8(%esp),%bl
            movb %bl,(%esi,%edi,1)
        C:
            incl %edi
            jmp E
    F:      
    #EPILOGO
        addl $12,%esp
        popl %ebp
        popl %edi
        popl %esi
        popl %ebx

        ret
