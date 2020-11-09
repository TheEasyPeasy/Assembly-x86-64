extern puts
extern printf
extern exit
extern getchar
extern scanf

section .text
global _start

_start:
    lea edi, [printLobby]
    call puts
    lea edi, [newLine]
    call puts
    lea edi, [toInteger]
    lea esi, [number]
    call scanf ; scanf("%i", &number);
    mov esi, [number] ; &number
    lea edi, [convertingMessage]
    call printf
    lea edi, [newLine]
    call puts
    lea edi, [chooseConverter]
    call puts
    lea edi, [toInteger]
    lea esi, [character]
    call scanf
    cmp sil, 'K'
    je to_kelvin
    cmp sil, 'C'
    je to_celsius
    cmp sil, 'M'
    je to_minutes
    cmp sil, 'S'
    je to_seconds
	lea edi, [unknownChoose]
	call puts
	jmp end


to_minutes:
    mov edx, 0
    mov eax, [number]
    mov ecx, 0x3C
    div ecx
    lea edi, [convertedMinutes]
    mov esi, eax
    mov edx, edx
    call printf
    lea edi, [newLine]
    call printf
    jmp end

to_seconds:
    mov edx, 0
    mov eax, [number]
    mov ecx, 0x3C
    mul ecx
    lea edi, [convertedSeconds]
    mov esi, eax
    call printf
    lea edi, [newLine]
    call printf
    jmp end

to_kelvin:
    mov eax, [number]
    add eax, 0x111
    lea edi, [convertedKelvins]
    mov esi, eax
    call printf
    jmp end

to_celsius:
    mov eax, [number]
    sub eax, 0x111
    lea edi, [convertedKelvins]
    mov esi, eax
    call printf
    jmp end

end:
    mov rdi, 0xa
    call exit


section .data
    chooseConverter db "Choose your converter (K(Kelvins)/C(Celsius)/S(Seconds)/M(Minutes)): ", 0
    convertedCelsius db "Your converted value in Celsius degree is %i", 0
    convertedKelvins db "Your converted value in kelvins is %i", 0
    convertedSeconds db "Your converted value in seconds is %i", 0
    convertedMinutes db "Your converted time is %i minutes and %i seconds", 0
    convertingMessage db "Number %i is converting...", 0
	unknownChoose db "I'm sorry you didn't choose valid converter :(", 0
    printLobby db "Please write your number to convert", 0
    toInteger db "%i", 0
    ToCharacter db "%c", 0
    newLine db 10
    number dw 0
    character dw 0