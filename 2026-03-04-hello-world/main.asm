; ------------------------------------------------------------------
; main.asm
;
; To assemble to .obj:
;     nasm -fwin64 main.asm -o main.obj
; To compile to .exe:
;     link main.obj /subsystem:console /entry:main /out:main.exe kernel32.lib legacy_stdio_definitions.lib  msvcrt.lib
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