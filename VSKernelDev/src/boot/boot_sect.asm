; ------------------------------------------------------------------
; Header

[bits 16]
%ifidn __OUTPUT_FORMAT__, bin 
[org 0x7c00]
%endif

; ------------------------------------------------------------------
; Code

mov [BootDrive], dl

mov bp, 0x9000
mov sp, bp

call load_kernel
call switch_to_pm

jmp $

; ------------------------------------------------------------------
; Includes

%include "boot\disk.asm"
%include "boot\load_kernel.asm"
%include "boot\gdt.asm"
%include "boot\protected_mode.asm"

; ------------------------------------------------------------------
; Variables

BootDrive: db 0

; ------------------------------------------------------------------
; Footer

times 510-($-$$) db 0
dw 0xaa55