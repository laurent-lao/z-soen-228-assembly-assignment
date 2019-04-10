; SOEN 228 Assembly assignment
; April 12th 2019
; Laurent Lao
; ID: 40020483

section .data

; put your data in this section using
; db , dw, dd directions

number db  15
answer db  1    ;  1 means number is prime, 0 means number is not prime
section .bss

; put UNINITIALIZED data here using
 
section .text
        global _start

_start:
                mov esi, number                 ; get the offset of number into esi  
keith:          mov eax, 0                      ; clear the entire eax register
                mov al, [esi]                   ; get the number from memory into al
                mov dl, al                      ; put it inside dl as well
                mov bl, 2                       ; bl holds each divisor starting from 2

loopy:          div bl                          ; ax / bl  with quot in al and rem in ah
                and ax, 1111111100000000b       ;  isolate the rem in ah with a  AND mask
                                                ; to determine whether the remainder is 0    
checkremain:    cmp eax, 0                      ; checks whether remainder is 0
                je isnotprime                   ; jump to branch isnot if remainder is 0

notzero:        mov eax, 0                      ; clear the entire eax register again
                mov al, dl                      ; put number back into al
                inc bl                          ; increment bl
                cmp al, bl                      ; check if the divisor is now equal to number
                je programend                   ; end the program if true

lagain:         jmp loopy                       ; else, go back to loopy

isnotprime:     mov  BYTE [answer], 0           ; change the value at address answer to 0 indicating not prime
                                                ; continue into ending the program
programend:     mov eax, 1                      ; System calls for exit (sys_exit)
                mov ebx, 0                      ; Exit return code 0 (no errors)
                int 80h
       