      SUBROUTINE LVALUE(KOL,L,NDML,NF,BLANK,COMMA,NUMBER)
C
C TEST FOR LEGAL LOGICAL CONSTANTS AND MULTIPLICTION FACTOR FOR INPUT
C
      COMMON /CONSNT/ PI,DEG,UNUSED,RAD,KAND
      DIMENSION KOL(80), NUMBER(15), TRUE(6), FALSE(7)
      INTEGER BLANK, COMMA, TRUE, FALSE
      LOGICAL STAR, NMTEST
      DATA TRUE  / 4H.   ,4HT   ,4HR   ,4HU   ,4HE   ,4H.   /
      DATA FALSE / 4H.   ,4HF   ,4HA   ,4HL   ,4HS   ,4HE   ,4H.   /
C
 1010 CONTINUE
      MULT = 0
      STAR = .FALSE.
      IF(L .GE. 81) GO TO 1090
      IF(KOL(L) .NE. BLANK) GO TO 1020
        L = L+1
        GO TO 1010
 1020 CONTINUE
C
C***  TEST FOR MULTIPLICATION FACTOR
C
      DO 1030 J=1,14
        IF(J .GE. 11 .AND. J .LE. 13) GO TO 1030
        IF(KOL(L) .EQ. NUMBER(J)) GO TO 1040
        IF(L .GE. 80) GO TO 1050
 1030 CONTINUE
      GO TO 1050
 1040 CONTINUE
      IF(STAR)      NF = NF+1
      IF(J .EQ. 14) STAR = .TRUE.
      IF(J .LE. 10) MULT = 10*MULT+J-1
      L = L+1
      GO TO 1020
 1050 CONTINUE
      IF(.NOT. STAR .AND. MULT .GT. 0) NF = NF+1
      IF(STAR .AND. MULT .EQ. 0)       NF = NF+1
      IF(MULT .EQ. 0) MULT = 1
C
C***  TEST FOR LOGICAL CONSTANTS
C
      NCHR = 6
      IF(NMTEST(KOL(L),TRUE,NCHR))  GO TO 1060
      NCHR = 7
      IF(NMTEST(KOL(L),FALSE,NCHR)) GO TO 1060
      GO TO 1090
 1060 CONTINUE
      L = L+NCHR
 1070 CONTINUE
      IF(L .GE. 80) GO TO 1080
      IF(KOL(L) .NE. BLANK) GO TO 1080
        NF = NF+1
        L = L+1
        GO TO 1070
 1080 CONTINUE
      IF(KOL(L) .NE. COMMA .AND. KOL(L) .NE. KAND) NF = NF+1
      IF(KOL(L) .EQ. COMMA) L = L+1
      NDML = NDML+MULT
      GO TO 1010
C
C***  END OF CARD OR NON-LOGICAL VARIABLE FOUND
C
 1090 CONTINUE
      IF(NDML .EQ. 0) NF = NF+1
      RETURN
      END
