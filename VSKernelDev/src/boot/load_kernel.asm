[bits 16]
load_kernel:
	mov bx,KernelOffset
	
	mov dh,40
	
	mov dl, [BootDrive]
	call disk_load
	
	ret

KernelOffset equ 0x1000