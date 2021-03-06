      SUBROUTINE SSSYM
C
C     ----THIS SUBROUTINE CALCULATES THE SUPERSONIC PITCHING
C         AND LIFT INCREMENTS.
C
      COMMON /OVERLY/ NLOG,NMACH,IM,NALPHA
      COMMON /SYNTSS/ SYNA(19)
      COMMON /WINGD/  A(195)
      COMMON /HTDATA/ AHT(195)
      COMMON /OPTION/ SREF,CBARR,RUFF,BLREF
      COMMON /IWING/  PWING, WING(400)
      COMMON /FLAPIN/ F(69)
      COMMON /POWR/   SPR(59)
      COMMON /FLGTCD/ FLC(93)
      COMMON /FLOLOG/ FLTC,OPTI,BO,WGPL,WGSC,SYNT,HTPL,HTSC,VTPL,VTSC,
     1                HEAD,PRPOWR,JETPOW,LOASRT,TVTPAN,
     2                SUPERS,SUBSON,TRANSN,HYPERS,
     3                SYMFP,ASYFP,TRIMC,TRIM
      LOGICAL FLTC,OPTI,BO,WGPL,WGSC,SYNT,HTPL,HTSC,VTPL,VTSC,
     1        HEAD,PRPOWR,JETPOW,LOASRT,TVTPAN,
     2        SUPERS,SUBSON,TRANSN,HYPERS,
     3        SYMFP,ASYFP,TRIMC,TRIM
      REAL K1,K2,K3,MACH
      DIMENSION DELSYM(10)
      DIMENSION DELCM(10),DELCLL(10)
      EQUIVALENCE (BCMD1,SPR(17))
      EQUIVALENCE (CFI,F(12)),(ALOCI,F(14)),(ALOCO,F(15))
      EQUIVALENCE (BETA,SPR(1)),(K3,SPR(6)),(SR,SREF)
      EQUIVALENCE (DELSYM(1),F(1))
      EQUIVALENCE (K1,SPR(15)),(K2,SPR(16))
      EQUIVALENCE (SF,SPR(7)),(TANHL,SPR(14))
      EQUIVALENCE (BCLD1,SPR(12)),(BCLD2,SPR(13))
      EQUIVALENCE (CMD1,SPR(57)),(CMD2,SPR(58)),(CMD3,SPR(59))
      EQUIVALENCE (CMDT,SPR(19)),(DELCM(1),WING(211)),(CLD,SPR(20))
      EQUIVALENCE (DELCLL(1),WING(201))
      EQUIVALENCE (TRTOFL,SPR(35))
C
      MACH=FLC(IM+2)
      NDELTA=F(16)+.5
      FTYPE=F(17)
      XCG=SYNA(1)
      CI=SPR(31)
      IF(HTPL)GO TO 1000
      XW=SYNA(2)
      CR=A(122)
      TANLE=A(62)
      GO TO 1010
 1000 CR=AHT(10)
      TANLE=AHT(62)
      XW=SYNA(6)
 1010 CONTINUE
      IF(FTYPE.NE.1.)GO TO 1040
      K1=K3*(1.+TRTOFL+TRTOFL**2)
      K2=K3*TANHL
C
C     SUPERSONIC PITCHING MOMENT EFFECTIVENESS NO. 1 FOR TRAILING EDGE
C     FLAPS.
C
      BEF=2.*(ALOCO-ALOCI)
      SAVE=CR*SR
      CMD1=K1*.33333*BEF*CFI*BCMD1/SAVE
C
C     SUPERSONIC PITCHING MOMENT EFFECTIVENESS NO. 2
C     FOR TRAILING EDGE FLAPS
C
      CMD2=-K2/2.*BEF*SF *BCLD2/SAVE
C
C     SUPERSONIC PITCHING MOMENT EFFECTIVENESS NO.3
C     FOR TRAILING EDGE FLAPS
C
      DELXF=XW+ALOCI*TANLE+CI-CFI-XCG
      CMD3=-K3*DELXF*SF*BCLD1/SAVE
C
C     TOTAL SUPERSONIC PITCHING MOMENT EFFECTIVENESS FOR TRAILING
C     EDGE FLAPS
C
      CMDT=CMD1+CMD2+CMD3
C
C     SS PITCHING MOMENT INCREMENT
C
      DO 1020 I=1,NDELTA
         DELCM(I)=CMDT*DELSYM(I)
 1020 CONTINUE
C
C     LIFT COEFFICIENT EFFECTIVENESS,T.E. FLAP
C
      CLD=K3*BCLD1*SF/SR
C
C     LIFT COEFFICIENT INCREMENT WRT T.E. FLAPS
C
      DO 1030 I=1,NDELTA
         DELCLL(I)=CLD*DELSYM(I)
 1030 CONTINUE
 1040 CONTINUE
      RETURN
      END
