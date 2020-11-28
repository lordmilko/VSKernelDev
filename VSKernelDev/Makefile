C_SOURCES = $(wildcard src/kernel/*.c)

HEADERS = $(wildcard src/kernel/*.h)
OBJC = ${C_SOURCES:.c=.o}

AS = C:\Program Files (x86)\nasm\nasm.exe
CC = C:\Program Files (x86)\i686-elf-tools\bin\i686-elf-gcc.exe
LD = C:\Program Files (x86)\i686-elf-tools\bin\i686-elf-ld.exe

CFLAGS = -std=c99 -ffreestanding -g -Wall -Wextra -Isrc/

all: os-image symbols

clean:
	-del os-image *.bin *.elf
	-del /s src\kernel\*.o

##### Normal #######################################################

os-image: boot_sect.bin kernel.bin
	type $^ > os-image

boot_sect.bin:
	${AS} src\boot\boot_sect.asm -f bin -o $@ -isrc/

kernel.bin: src/kernel/kernel_entry.o ${OBJC}
	${LD} -o $@ -Ttext 0x1000 $^ --oformat binary

##### Symbols #######################################################

symbols: kernel.elf boot_sect.elf

boot_sect.elf:
	${AS} src\boot\boot_sect.asm -f elf -g -o $@ -F dwarf -isrc/

kernel.elf: src/kernel/kernel_entry.o ${OBJC}
	${LD} -o $@ -Ttext 0x1000 -g $^

##### Generic #######################################################

%.bin : %.asm
	${AS} $< -f bin -o $@

%.elf : %.asm
	${AS} $< -f elf -g -o $@

%.o : %.asm
	${AS} $< -f elf -o $@

%.o : %.c ${HEADERS}
	${CC} $(CFLAGS) -c $< -o $@