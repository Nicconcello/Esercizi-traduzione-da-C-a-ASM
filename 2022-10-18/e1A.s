.globl str_to_upper

str_to_upper:
    #PROLOGO
    pushl %ebx
    pushl %esi
    pushl %edi
    subl $4,%esp

    movl 20(%esp),%ebx
    cmpl $0,%ebx
    je N

    movl %ebx,(%esp)
    call strdup
    movl %eax,%esi
    movl %esi,%edi

    E:
        cmpb $0,(%edi)
        je F

        movb (%edi),%dl
        movsbl %dl,%eax
        movl %eax,(%esp)
        call toupper
        movb %al,%cl

        movb %cl,(%edi)
        incl %edi
        jmp E
    F:
        movl %esi,%eax
        jmp R
    N:
        movl $0,%eax
        jmp R
    R:
    #EPILOGO
        addl $4,%esp
        popl %edi
        popl %esi
        popl %ebx

        ret
