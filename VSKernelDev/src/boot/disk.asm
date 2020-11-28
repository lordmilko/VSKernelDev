disk_load:
	push dx

	mov ah,0x02   ; BIOS read sector function
	mov al,dh     ; number of sectors to read from starting point
	mov ch,0x00   ; cylinder 0
	mov dh,0x00   ; select head 0
	mov cl,0x02   ; select second sector on the track (the sector after the boot sector)

	int 0x13      ; Execute

	jc disk_flag_error

	pop dx
	cmp dh,al
	jne disk_compare_error
	ret

disk_flag_error:
	; Normally you would print an error here
	jmp $

disk_compare_error:
	; Normally you would print an error here
	jmp $