[bits 16]   ;16bit binary format
[org 0x7c00] ;BIOS  Bootloder Address

start:

    xor ax, ax

    mov ds, ax
    mov es, ax
    mov bx, 0x8000
    mov si, kinesys_BIOS ;source index를 kinesys os 문자열 인덱스 포인트로 설정

    call kinesys_os ;kinesys_os function 호출

    kinesys_BIOS db 'Kinesys_OS_BIOS', 13,0 ;define 문자열

;define function 위치

kinesys_os:

    mov ah, 0x0E

.repeat_next_char:

    lodsb
    cmp al, 0
    je .done_os

    int 0x10

    jmp .repeat_next_char

.done_os:

    ret

times (510 - ( $ -$$ )) db 0x00 


dw 0xAA55


