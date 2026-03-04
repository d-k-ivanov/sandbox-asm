; ------------------------------------------------------------------
; main.asm
;
; To assemble to .obj:
;     nasm -f win64 main3.asm -o main3.obj
; To compile to .exe:
;     link main3.obj /out:main3.exe /entry:main /subsystem:console /largeaddressaware:no kernel32.lib
; ------------------------------------------------------------------

bits 64
default rel

global main
extern GetStdHandle
extern WriteFile

section .text
main:
    mov     rcx, 0fffffff5h
    call    GetStdHandle

    mov     rcx, rax
    mov     rdx, NtlpBuffer
    mov     r8, [NtnNBytesToWrite]
    mov     r9, NtlpNBytesWritten
    sub     rsp, 40
    mov     dword [rsp + 32], 00h
    call    WriteFile
    add     rsp, 40
ExitProgram:
    xor     eax, eax
    ret

section .data
NtlpBuffer:        db    'Hello, Win64!', 00h
NtnNBytesToWrite:  dq    0eh

section .bss
NtlpNBytesWritten: resd  01h
