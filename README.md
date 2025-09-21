# Assembly Language Programs 

This repository contains my **Assembly Language (ASM)** assignments completed as part of my coursework at [Your College Name] 🏫.  
It serves as both a submission archive and a reference for learning basic concepts of low-level programming.

---

##  Repository Structure
- Each `.asm` file corresponds to an individual assignment/program.
- Filenames are kept descriptive (e.g., `addition.asm`) for clarity.
- Output screenshots (if any) are added alongside the source files.

---

##  Requirements
To run these programs, you need:
- **Assembler**: [NASM](https://www.nasm.us/) / MASM / TASM (based on your course requirements)  
- **Emulator/Debugger**: DOSBox / emu8086 / gdb (depending on environment)  

---

## ▶️ Running the Programs
Example (for NASM + Linux):
```bash

nasm -f elf32 program.asm -o program.o
ld -m elf_i386 program.o -o program
./program
