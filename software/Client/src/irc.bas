5 BLOAD "msxpiext.bin",R
10 CLS:CH$="#openmsx":NK$="* msxpi *"
20 PRINT "MSXPi IRC Client"
29 REM Define FN Keys and Constants
30 BUF=&HB000:GOSUB 10000:GOSUB 30000
40 FOR I=1 TO 10: KEY(I) STOP:NEXT I
50 INPUT "Nick name:";NI$
60 IF NI$="" THEN NI$="none"
70 INPUT "Channel name:";CH$
1000 PRINT"Connecting to irc server.."
1100 COM$="IRC CONN "+NI$:GOSUB 50000
1120 IF RC<>E0 AND RC<>EB THEN END
1210 COM$="IRC JOIN "+CH$:GOSUB 50000
1220 IF RC<>E0 AND RC<>EB THEN END
1300 ON KEY GOSUB 11000,12000,15000
1310 PRINT
1400 KEY (1) ON:KEY (2) ON:KEY (3) ON
1410 TIME=0
1450 IF TIME < 150 THEN GOTO 1450
1455 KEY (1) OFF:KEY (2) OFF:KEY (3) OFF
1460 COM$="IRC READ":GOSUB 50000
1500 GOTO 1400
6999 REM Send command in COM$ to RPi
7000 COM$="IRC NAMES":GOSUB 50000:CALL MSXPISEND("B000")
7050 RETURN
7999 REM Read buffer as string and store in RC$
10000 KEY 1,"F1-Talk"
10010 KEY 2,"F2-Join"
10020 KEY 3,"F3-Bye"
10030 KEY 4,""
10040 KEY 5,""
10050 KEY 6,""
10060 KEY 7,""
10070 KEY 8,""
10080 KEY 9,""
10090 KEY 10,""
10100 RETURN
11000 M$="":PRINT "talk:|";CHR$(8);:P=4:TIME=0:GOSUB 20000
11010 IF M$="" THEN PRINT:RETURN
11020 PRINT NK$+" --> ";M$
11100 COM$="IRC MSG "+M$:GOSUB50000
11120 RETURN
12000 M$="":PRINT "Channel:|";CHR$(8);:P=7:GOSUB 20000
12010 IF M$="" THEN PRINT:RETURN
12020 COM$="IRC JOIN "+M$:GOSUB 50000
12030 IF RC<>E0 AND RC<>EB THEN END
12040 COM$="IRC GETRSP":GOSUB 50000
12050 IF BS>254 THEN PR=1:GOSUB 52030 ELSE PRINT RC$:PRINT""
12060 RETURN
13000 RETURN
14000 RETURN
15000 COM$="IRC QUIT":GOSUB50000
15010 PRINT "Bye":END
20000 C$=INKEY$:IF C$<>"" THEN GOTO 20070
20020 IF TIME<50 THEN PRINT"/";CHR$(8);:GOTO20070
20030 IF TIME<100 THEN PRINT"-";CHR$(8);:GOTO20070
20040 IF TIME<150 THEN PRINT"\";CHR$(8);:GOTO20070
20050 IF TIME<200 THEN PRINT;"|";CHR$(8);:GOTO20070 ELSE TIME=0
20070 IF C$=CHR$(13) THEN GOSUB 20100:RETURN
20080 IF (C$=CHR$(8) AND LEN(M$)>0) THEN M$=LEFT$(M$,LEN(M$)-1):PRINT " ";CHR$(8);CHR$(8);
20090 IF C$>=CHR$(32) THEN M$=M$+C$:PRINT C$;:GOTO20000 ELSE GOTO20000
20100 FOR I = 0 TO LEN(M$)+P:PRINT " ";CHR$(8);CHR$(8);" ";CHR$(8);:NEXT I:RETURN
30000 REM
30110 E0 = &HE0
30120 E1 = &HE1
30130 E2 = &HE2
30140 E3 = &HE3
30150 E4 = &HE4
30160 E5 = &HE5
30170 E6 = &HE6
30180 E7 = &HE7
30190 E8 = &HE8
30200 E9 = &HE9
30210 EA = &HEA
30220 EB = &HEB
30230 EC = &HEC
30240 ED = &HED
30250 EF = &HEF
30260 RETURN
49990 REM Send COMMAND COM$ TO RPi
49991 REM Verify transfer RC
49992 REM Wait command execution, and get RC back
49995 REM BUF=&HB000
49996 REM COMM$="TEMPLATE"
49997 REM GOSUB 50000
49998 REM PRINT:PRINT HEX$(RC)
49999 REM END
50000 POKE(BUF),0
50010 POKE(BUF+1),INT(LEN(COM$) MOD 256)
50020 POKE(BUF+2),INT(LEN(COM$) / 256)
50100 FOR I = 1 TO LEN(COM$)
50110 POKE(BUF+I+2),ASC(MID$(COM$,I,1))
50120 NEXT I
50130 CALL MSXPISEND("B000")
50132 GOSUB 53000
50135 OUT (&H5A),0:GOSUB 53000:RC=INP(&H5A):PRINT"RC1=";HEX$(RC)
50140 IF RC=E9 THEN GOSUB 53000:OUT (&H5A),0:GOSUB 53000:RC=INP(&H5A):PRINT"RC2=";HEX$(RC)
50150 POKE (BUF),RC
50160 IF RC <> E0 AND RC <> E7 AND RC <> EB AND RC <> EC THEN PRINT"Pi:Comm Error":RETURN
51000 CALL MSXPIRECV("B000")
51100 IF RC=EB OR RC=EC THEN RETURN
52000 RC$="":RC=PEEK(BUF):PR=1
52010 BS=PEEK(BUF+1)+256*PEEK(BUF+2)
52020 IF BS=0 THEN RETURN
52030 FOR I = 1 TO BS
52040 IF PR=0 THEN RC$=RC$+CHR$(PEEK(BUF+I+2)) ELSE PRINT CHR$(PEEK(BUF+I+2));
52050 NEXT I
52060 PR=0:RETURN
53000 IF INP(&H56)=1 THEN GOTO 53000
53010 RETURN
