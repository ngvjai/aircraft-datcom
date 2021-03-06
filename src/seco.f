      SUBROUTINE SECO(A,CAMBER,ATYPE)
C
C  FOR EACH PLANFORM SET UP OUTPUT DATA
C
      COMMON / IBH /  PBH, THN(60),CAM(60),A0,XC,MCC,CLCC,XAC(20)
      COMMON /IBWH/   PBWH,AI,ALO,CLI,ASEP,CMCO4,CLA0,CLA(20),CLMAX0,
     1                CLMAX(20)
      COMMON /IBWHV/  PBWHV, RHO,TMAX,DELTAY,XOVC,TOVC,COVC
      COMMON /CONSNT/ PI,DEG,UNUSED,RAD
      COMMON /FLGTCD/ FLC(93)
      DIMENSION A(162)
      IF(A(16).EQ.UNUSED) A(16)=2.*TOVC
      IF(A(17).EQ.UNUSED) A(17)=DELTAY
      IF(A(18).EQ.UNUSED) A(18)=XOVC
      IF(A(19).EQ.UNUSED) A(19)=CLI
      IF(A(20).EQ.UNUSED) A(20)=AI
      NMACH=FLC(1)+0.5
      DO 1000 M=1,NMACH
         IF(A(M+20).EQ.UNUSED) A(M+20)=CLA(M)
         IF(A(M+40).EQ.UNUSED) A(M+40)=CLMAX(M)
         IF(A(M+71).EQ.UNUSED) A(M+71)=XAC(M)
 1000 CONTINUE
      IF(A(61).EQ.UNUSED) A(61)=CMCO4
      IF(A(62).EQ.UNUSED) A(62)=RHO
      A(64)=CAMBER
      IF(A(68).EQ.UNUSED) A(68)=CLMAX0
      IF(A(69).EQ.UNUSED) A(69)=CLA0
      IF(A(10).EQ.UNUSED)A(10)=ALO
      IF(A(93).EQ.UNUSED) A(93)=COVC
      IF(ATYPE.GE.0.) GO TO 1010
      IF(A(63).EQ.UNUSED) A(63)=RHO
      IF(A(65).EQ.UNUSED) A(65)=2.*TOVC
      IF(A(66).EQ.UNUSED) A(66)=XOVC
      IF(A(67).EQ.UNUSED) A(67)=CMCO4
 1010 CONTINUE
      RETURN
      END
