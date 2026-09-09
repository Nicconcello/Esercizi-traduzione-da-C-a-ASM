.globl base64lessless

base64lessless:
    #PROLOGO
    pushl %ebx
    pushl %esi
    pushl %edi
    pushl %ebp
    subl $4,%esp

    movl 24(%esp),%ebx
    movl 32(%esp),%esi

    cmpl $0,%ebx
    je Z
    cmpl $0,28(%esp)
    je Z

    movl 28(%esp),%edi
    movl %edi,(%esp)
    call malloc
    movl %eax,%edi

    xorb %cl,%cl
    xorb %ch,%ch

    movl $-1,%ebp

    F:
        incl %ebp
        cmpl 28(%esp),%ebp
        jge O;

        movb (%ebx),%dl

        movb %cl,%al
        negb %al
        addb $6,%al
        pushl %ecx       # 1. Salvo il contatore Base64 nello stack
        movb %al,%cl     # 2. Metto il valore di shift nell'UNICO registro valido (%cl)
        movb %ch,%dh
        shlb %cl,%dh     # 3. Faccio lo shift (Ora il compilatore è felice!)
        popl %ecx        # 4. Ripristino il contatore Base64 originale

        movb %cl,%al
        addb $2,%al
        pushl %ecx       # Salvo il contatore
        movb %al,%cl     # Muovo il valore in %cl
        movb %dl,%ah
        shrb %cl,%ah     # Faccio lo shift con %cl
        popl %ecx        # Ripristino
        orb %ah,%dh

        movb %cl,%al
        negb %al
        addb $6,%al
        negb %al
        addb $8,%al
        andb $7,%al
        movb %al,%cl

        movb %cl,%al
        negb %al
        addb $8,%al
        movb %dl,%ch
        pushl %ecx       # Salvo il contatore
        movb %al,%cl     # Muovo il valore in %cl
        movb %dl,%ch
        shlb %cl,%ch     # Primo shift
        shrb %cl,%ch     # Secondo shift
        popl %ecx        # Ripristino

        cmpb $6,%cl
        jae E

        addl $1,%ebx

        E:
            movzbl %dh,%eax
            movb (%esi,%eax,1),%ah
            movb %ah,(%edi,%ebp,1)

            jmp F
    O:
        movl %edi,%eax
        jmp R
    Z:
        movl $0,%eax
    R:
    #EPILOGO
        addl $4,%esp
        popl %ebp
        popl %edi
        popl %esi
        popl %ebx

        ret
