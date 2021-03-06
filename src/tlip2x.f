      SUBROUTINE TLIP2X(X1,X2,Y,NXX,NX2,XA1,XA2,YA,LX1L,LX2L,LX1U,LX2U,
     1 MESS,NMSS,ROUT)
C
C***  LINEAR INTERPOLATION FOR A PACKED TABLE Y=F(X1,X2)
C
C AJT DIMENSION X1(2),X2(2),Y(2),ROUT(2),MESS(2),NP1(7),NXX(7),DA(3)
      DIMENSION X1(*),X2(*),Y(*),ROUT(*),MESS(*),NP1(7),NXX(*),DA(3)
      DIMENSION MSSCL(13),RMSCL(13)
      EQUIVALENCE (RMSCL(1),MSSCL(1))
      LOGICAL NOIN1,NAS1,X1A,X1B,MSSG1,EX1,LG(7)
      EQUIVALENCE (NOIN1,LG(1)),(X1A,LG(2)),(X1B,LG(3)),(MSSG1,LG(4)),
     1      (EX1,LG(5)),(DA(1),D0),(DA(2),D1),(DA(3),D2),(NAS1,LG(6))
      DATA TLIN /4H1TIN/, HOL1 /4H1EXP/
      DATA MSSCL /4HTLIP,4H2X  ,2*0,2,8*0/
C
      IF(NXX(1).GE.0)GO TO 1010
      NX1=NXX(2)
      DO 1000 J=1,7
         NP1(J)=NXX(J)
 1000 CONTINUE
      GO TO 1020
 1010 NP1(1)=-NX2
      NX1=NXX(1)
      NP1(2)=NX1
      NP1(3)=0
      NP1(4)=0
      NP1(6)=0
      NP1(7)=0
 1020 CALL SWITCH(LG,LX1L,LX1U,XA1,X1,NX1)
      IF(LG(7))GO TO 1130
      CALL GLOOK(NX1,XA1,X1,NAS1,NOIN1,I1,T1)
 1030 ID=I1
      DO 1050 I=1,2
         IX=4-I
         GO TO 1160
 1040    IF(NOIN1)GO TO 1090
 1050 ID=ID-1
      IF(.NOT.EX1)GO TO 1070
      IF(NX1.LT.3)GO TO 1060
      IF(X1A.AND.LX1U.GT.1)GO TO 1140
      IF(X1B.AND.LX1L.GT.1)GO TO 1200
 1060 IF(X1A)GO TO 1210
 1070 D0=D1
 1080 D2=D0+T1*(D2-D1)
 1090 YA=D2
 1100 IF(MSSG1.OR.RO.EQ.HOL1)GO TO 1110
      RETURN
 1110 IF(ROUT(1).NE.TLIN)GO TO 1120
      ROUT(1)=HOL1
      RETURN
 1120 CONTINUE
C
C     ----PRINT EXTRAPOLATION MESSAGE.
C
      MSSCL(3)=NMSS
      RMSCL(4)=YA
C
C     ----1ST VARIABLE.
C
      RMSCL(6)=XA1
      MSSCL(7)=NX1
      MSSCL(8)=LX1L
      MSSCL(9)=LX1U
C
C     ----2ND VARIABLE.
C
      RMSCL(10)=XA2
      MSSCL(11)=NX2
      MSSCL(12)=LX2L
      MSSCL(13)=LX2U
      CALL MESSGE(ROUT,MESS,X1,X2,LG,LG,MSSCL)
      RETURN
C
C     ----HERE FOR EXTRAP.
C
 1130 IF(X1B)GO TO 1180
C
C     ----HERE FOR XA1 ABOVE
C
      T1=XA1-X1(NX1)
      I1=NX1
      GO TO 1190
 1140 I1=I1-2
      ID=I1
      IX=1
 1150 I=0
 1160 RO=TLIN
      NP1(5)=ID
      CALL TLIP1X(X2,Y,NP1,XA2,DA(IX),LX2L,LX2U,MESS,NMSS,RO)
      IF(I.NE.0)GO TO 1040
 1170 CALL QUAD(X1(I1),DA,XA1,YA)
      GO TO 1100
C
C     ----HERE FOR XA1 BELOW
C
 1180 T1=XA1-X1(1)
      I1=2
 1190 T1=T1/(X1(I1)-X1(I1-1))
      GO TO 1030
 1200 D0=D1
      D1=D2
      ID=3
      IX=3
      I1=1
      GO TO 1150
 1210 D0=D2
      GO TO 1080
      END
