; ------------------------------------------------------------------
; main.asm
;
; To assemble to .obj:
;     nasm -f win64 main1.asm -o main1.obj
; To compile to .exe:
;     link main1.obj /out:main1.exe /entry:main /subsystem:console kernel32.lib legacy_stdio_definitions.lib  msvcrt.lib
; ------------------------------------------------------------------

bits 64
default rel

segment .data
    msg db "Hello world!", 0xd, 0xa, 0

segment .text
global main

extern printf
extern ExitProcess
extern _CRT_INIT

main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32

    call _CRT_INIT  ;CRT initialization

    lea     rcx, [msg]
    call    printf

    xor     rax, rax
    call    ExitProcess