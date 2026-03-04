; ------------------------------------------------------------------
; main.asm
;
; To assemble to .obj:
;     nasm -f win32 main2.asm -o main2.obj
; To compile to .exe:
;     link main2.obj /out:main2.exe /entry:main /subsystem:console /machine:x86 "C:\Program Files (x86)\Windows Kits\10\\lib\10.0.26100.0\\um\x86\kernel32.lib"
; ------------------------------------------------------------------

global  main

extern  _ExitProcess@4
extern  _GetStdHandle@4
extern  _WriteConsoleA@20

section .data
msg:    db      "Hello, Win32!", 10
handle: db      0
written:
        db      0

section .text
main:
        ; handle = GetStdHandle(-11)
        push    dword -11
        call    _GetStdHandle@4
        mov     [handle], eax

        ; WriteConsole(handle, &msg[0], 13, &written, 0)
        push    dword 0
        push    written
        push    dword 13
        push    msg
        push    dword [handle]
        call    _WriteConsoleA@20

        ; ExitProcess(0)
        push    dword 0
        call    _ExitProcess@4