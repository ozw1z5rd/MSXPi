;|===========================================================================|
;|                                                                           |
;| MSXPi Interface                                                           |
;|                                                                           |
;| Version : 1.1                                                             |
;|                                                                           |
;| Copyright (c) 2015-2023 Ronivon Candido Costa (ronivon@outlook.com)       |
;|                                                                           |
;| All rights reserved                                                       |
;|                                                                           |
;| Redistribution and use in source and compiled forms, with or without      |
;| modification, are permitted under GPL license.                            |
;|                                                                           |
;|===========================================================================|
;|                                                                           |
;| This file is part of MSXPi Interface project.                             |
;|                                                                           |
;| MSX PI Interface is free software: you can redistribute it and/or modify  |
;| it under the terms of the GNU General Public License as published by      |
;| the Free Software Foundation, either version 3 of the License, or         |
;| (at your option) any later version.                                       |
;|                                                                           |
;| MSX PI Interface is distributed in the hope that it will be useful,       |
;| but WITHOUT ANY WARRANTY; without even the implied warranty of            |
;| MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             |
;| GNU General Public License for more details.                              |
;|                                                                           |
;| You should have received a copy of the GNU General Public License         |
;| along with MSX PI Interface.  If not, see <http://www.gnu.org/licenses/>. |
;|===========================================================================|
;
; File history :
; 0.1    : Initial version.
; 0.9    : Rewritten to support new block download logic
; 1.1    : Ported to protocol v1.1

        ORG     $0100

; Sending Command and Parameters to RPi
        ld      de,command
        call    SENDCOMMAND
        jr      c, PRINTPIERR
        ld      de,buf
        ld      bc,BLKSIZE
        call    CLEARBUF
        call    SENDPARMS
        JR      NC,MAINPROGRAM

PRINTPIERR:
        LD      HL,PICOMMERR
        JP      PRINT

MAINPROGRAM:

        LD      HL,LOADPROGRESS
        CALL    PRINT
        CALL    LOADROM
        JR      C,PRINTPIERR
        
LOADROMPROG1:

        PUSH    HL
        LD      HL,0
        LD      A,($FCC1)
        CALL    ENASLT
        POP     HL
        JP      (HL)

;-----------------------
; LOADROM              |
;-----------------------
LOADROM:
; Will load the ROM directly on the destiantion page in $4000
; Might be slower, but that is what we have so far...
;Get number of bytes to transfer
        LD      DE,$4000 - 3
LOADROM0:
        LD      A,'.'
        CALL    PUTCHAR
        LD      BC,BLKSIZE
        CALL    RECVDATA
        RET     C
        LD      A,(HL)          ; RETURN CODE
        INC     HL
        LD      C,(HL)          ; LSB OF DATA SIZE
        INC     HL
        LD      B,(HL)          ; MSB OF DATA SIZE
        INC     HL
        LD      D,H
        LD      E,L
        CP      RC_READY        ; More data available to transfer
        JR      Z,LOADROM0      ; Get next block
; File trasnfer finished
; Return C reseted, and A = filetype
LOADROMEND:
        LD      HL,($4002)    ;ROM exec address
        OR      A             ;Reset C flag
        RET

LOADPROGERR:
        LD      HL,LOADPROGERRMSG
        CALL    PRINT
        SCF
        RET

EXITSTDOUT:
        CALL    PRINTNLINE
        CALL    PRINTPISTDOUT
        jp      0

COMMAND:
        DB      "PLOADR"

PICOMMERR:
        DB      "Communication Error",13,10,"$"

LOADPROGERRMSG:
        DB      "Error loading file",13,10,"$"

LOADPROGRESS:
        DB      "Loading game...$"

INCLUDE "include.asm"
INCLUDE "putchar-clients.asm"
INCLUDE "msxpi_bios.asm"





