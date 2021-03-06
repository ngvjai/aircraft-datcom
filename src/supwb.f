      SUBROUTINE SUPWB
C
C***  CALCULATES SUPERSONIC WING-BODY AERO
C
      REAL MACH,NXX,KWB,KBW,IVBW  ,KKBW,KKWB
      DIMENSION ROUTID(2),Q1211A(3),Q1211B(3),Q31210(3),Q1212A(3),
     1          Q1212B(3),Q2118A(3),Q2118B(3),Q2137A(3),Q2137B(3)
      DIMENSION T4312B(8),D4312B(8)
      DIMENSION CDW(20),CDB(20),WTYPE(4),IVBW(20),GAMMA(20)
      DIMENSION T4337A(11),D4337A(24),T4337B(12),D4337B(20)
      DIMENSION T4312A(11),D4312A(11)
      DIMENSION TFIG10(11),DKWB10(11),DKBW10(11)
      DIMENSION T4218A(18),DL218A(54),DR218A(54),T4218B(14),DL218B(42),
     1          DR218B(42)
      DIMENSION LGH(4),VAR(4),CD(20),CN(20),CA(20),CL(20),CLB(20),
     1           CLW(20),ALPHAB(20),CDL(20)
      DIMENSION CM(20)
C
      COMMON /CONSNT/ PI,DEG,UNUSED,RAD
      COMMON /FLGTCD/ FLC(160)
      COMMON /SYNTSS/ SYNA(19)
      COMMON /OPTION/ SREF,CBARR,ROUGFC,BLREF
      COMMON /WINGI/  W(2),SPANS,SPAN,W1,CR,W2(8),TYPE
      COMMON /BODYI/  NXX,XCOOR(20),S(20),P(20),R(20),ZU(20),ZL(20),
     1                BNOSE,BTAIL,RLN
      COMMON /BDATA/  BD(762)
      COMMON /WINGD/  A(195)
      COMMON /OVERLY/ NLOG,NMACH,I,NALPHA
      COMMON /SUPBOD/ SBD(229)
      COMMON /SUPWBB/  SWB(61)
      COMMON /SUPWH/  SLG(141)
      COMMON /IBODY/  PBODY, BODY(400)
      COMMON /IWING/  PWING, WING(400)
      COMMON /IBW/    PBW, BW(380)
C
      EQUIVALENCE (CA(1),BW(81)),(CDW(1),WING(1)),(CMA,BW(121)),
     1 (DXCG,A(173)),(CLAB,SBD(18)),(KKWB,SWB(2)),
     2 (XACN,SWB(3)),(CDOWB,SWB(4)),(DELXW,BD(66)),(ARSTAR,A(7)),
     3 (CD(1),BW(1)),(DD,SWB(5)),(XW,SYNA(2)),(CLB(1),BODY(21)),
     4 (ALIW,SYNA(4)),(BETA,SWB(6)),(CLAW,WING(101)),
     5 (XACW,SLG(134)),(CLABW,SWB(7)) ,(XACBW,SWB(8))
      EQUIVALENCE (CLA,BW(101)),(CDL(1),SLG(53))
      EQUIVALENCE (CL(1),BW(21)),(FA,SWB(9)),(CLI,SWB(10)),
     1 (KBW,SWB(11)),(CDOB,SBD(124)),(IVBW(1),SWB(12)),(RKBW,SWB(32)),
     2 (CLAWB,SWB(33)),(TANL ,A(62)),(CRSTAR,A(10)),
     3 (TAPEXP,A(27)),(CN(1),BW(61)),(FN, SWB(34)),(CDB(1),BODY(1)),
     4 (CLW(1),WING(21)),(KWB,SWB(35)),(XAC,SWB(36)) ,(CDOW,SLG(80)),
     5 (DN,SBD(4)),(D1,SBD(5)),(KKBW,SWB(37)),(RLAP,SWB(38))
      EQUIVALENCE (XACA,SWB(39)),(GAMMA(1),SWB(40)),
     1 (TRINO,SWB(60)),(XCPLN,SWB(61)),(ALPHAB(1),BD(255))
     2 ,(CM(1),BW(41))
C
      DATA ROUTID/4HSUPW,4HB   /,
     2 Q31210/4H4.3.,4H1.2-,4H10  /,Q1212A/4H4.3.,4H1.2-,4H12A /,
     3 Q2118A/4H4.2.,4H2.1-,4H23A /,Q1212B/4H4.3.,4H1.2-,4H12B /,
     4 Q2118B/4H4.2.,4H2.1-,4H23B /,Q2137A/4H4.3.,4H2.2-,4H37A /,
     5                              Q2137B/4H4.3.,4H2.2-,4H37B /
      DATA WTYPE/4HSTRA,4HDOUB,4HCRAN,4HCURV/
C
C                   FIGURE 4.3.1,2-10 KWB
C
      DATA TFIG10/0.0,.1,.2,.3,.4,.5,.6,.7,.8,.9,1.0/
      DATA DKWB10/1.0,1.08,1.16,1.26,1.36,1.46,1.56,1.67,1.78,1.89,2.0/
C
C                   FIGURE 4.3.1.2-10 KBW
C
      DATA DKBW10/0.0,.13,.29,.45,.62,.80,1.0,1.22,1.45,1.70,2.0/
C
C               FIGURE 4.2.2.1-23A (LEFT SIDE)
C
      DATA T4218A
     1  / 0., 0.2, 0.4, 0.6, 0.8, 1.0 , 3*0.0,
     2    0.0, 0.4, 0.8, 1.2, 1.6, 2.0, 3.0, 4.0, 5.0 /
      DATA DL218A
     1 /  0.543,  0.542,  0.541,  0.540,  0.534,  0.526,
     2    0.400,  0.409,  0.418,  0.430,  0.441,  0.450,
     3    0.305,  0.328,  0.350,  0.369,  0.387,  0.400,
     4    0.238,  0.265,  0.295,  0.318,  0.339,  0.356,
     5    0.198,  0.221,  0.246,  0.274,  0.298,  0.320,
     6    0.160,  0.185,  0.210,  0.239,  0.262,  0.288,
     7    0.065,  0.095,  0.122,  0.150,  0.177,  0.210,
     8    0.000,  0.005,  0.035,  0.062,  0.089,  0.130,
     9    0.000,  0.000,  0.000,  0.000,  0.002,  0.050  /
C
C               FIGURE 4.2.2.1-23A (RIGHT SIDE)
C
      DATA DR218A
     1  / 0.445,  0.464,  0.485,  0.500,  0.518,  0.526,
     2    0.448,  0.455,  0.460,  0.460,  0.459,  0.450,
     3    0.460,  0.449,  0.438,  0.424,  0.412,  0.400,
     4    0.450,  0.430,  0.412,  0.394,  0.375,  0.356,
     5    0.432,  0.410,  0.388,  0.365,  0.343,  0.320,
     6    0.420,  0.394,  0.369,  0.340,  0.314,  0.288 ,
     7    0.388,  0.354,  0.322,  0.278,  0.244,  0.210,
     8    0.357,  0.314,  0.273,  0.216,  0.171,  0.130,
     9    0.325,  0.274,  0.225,  0.154,  0.100,  0.050  /
C
C              FIGURE 4.2.2.1-23B (LEFT SIDE)
C
      DATA T4218B
     1  / 0., 0.2, 0.4, 0.6, 0.8, 1.0  , 0.,
     2    0.0, 0.5, 1.0, 2.0, 3.0, 4.0, 5.0 /
      DATA DL218B
     1 /  .665,  .665,  .665,  .665,  .665,  .665,
     2    .425,  .492,  .539,  .550,  .550,  .550,
C
     3    .330,  .370,  .405,  .438,  .459,  .470,
     4    .184,  .215,  .250,  .284,  .318,  .350,
     5    .060,  .097,  .133,  .170,  .206,  .240,
     6    .000,  .000,  .044,  .083,  .127,  .170,
     7    .000,  .000,  .000,  .020,  .063,  .105  /
C
C              FIGURE 4.2.2.1-23B (RIGHT SIDE)
C
      DATA DR218B
     1 /  .665,  .665,  .665,  .665,  .665,  .665,
     2    .480,  .500,  .519,  .536,  .546,  .550,
     3    .338,  .388,  .430,  .458,  .471,  .470,
     4    .338,  .372,  .394,  .394,  .375,  .350,
     5    .410,  .375,  .341,  .308,  .272,  .240,
     6    .377,  .338,  .294,  .251,  .211,  .170,
     7    .342,  .300,  .246,  .194,  .146,  .100   /
C
C                   FIGURE 4.3.1.2-12A (KBW)
C
      DATA T4312A/0.0,.1,.2,.3,.4,.5,.6,.7,.8,.9,1.0/
      DATA D4312A/0.0,.11,.21,.31,.41,.51,.6,.7,.8,.9,1.0/
C
C                   FIGURE 4.3.1.2-12B (KWB)
C
      DATA T4312B/.015,.1,.2,.3,.4,.6,.8,.975/
      DATA D4312B/1.,.975,.956,.947,.941,.950,.978,1.0/
C
C                   FIGURE 4.3.2.2-37A
C
      DATA T4337A/0.0,.4,.8,1.2,1.6,2.,2.4,2.8,
     1.1,1.0,999999./
      DATA D4337A/
     1.5,.72,.900,1.08,1.24,1.39,1.53,1.68,
     2.5,.72,.910,1.09,1.25,1.41,1.57,1.72,
     3.5,.73,.920,1.11,1.27,1.43,1.59,1.74/
C
C                   FIGURE 4.3.2.2-37B
C
      DATA T4337B/0.0,.1,.2,.3,.4,.5,.6,.8,1.0,2.8,
     10.2,999999./
      DATA D4337B/
     10.5,.56,.595,.62,.64,.65,.66,.669,.669,.671,
     20.5,.54,.578,.60,.62,.638,.649,.66,.669,.671/
C
      NX=NXX+.5
      DCYL=(DN+D1)/2.
      MACH=FLC(I+2)
      BETA=SQRT(MACH**2-1.)
      RLB=XCOOR(NX)
      DD=2.0*(SPAN-SPANS)
      TANLE=TANL
      IF(TANLE.EQ.0.0)TANLE=.00001
C
C   ***SUPERSONIC WING-BODY LIFT CURVE SLOPE,BODY IN PRESENCE OF WING***
C                         NON-TRIANGULAR WINGS
C
      IF(TAPEXP.EQ.0.0)GO TO 1050
      ARG1=BETA*ARSTAR*(1.0+TAPEXP)
      ARG2=1.+TANLE/BETA
      TRINO=ARG1*ARG2
      IF(TRINO.LE.4.)GO TO 1030
 1000 OLE=A(34)
      DX=RLB-XW-DD/2.*A(38)-CRSTAR
      IF(DX.LE.(-CRSTAR))RKBW=0.
      IF(DX.LE.(-CRSTAR))GO TO 1020
      CALL INTKBW(MACH,OLE,CRSTAR,DD,DX,RKBW,RXAC)
 1020 KBW=RKBW/(RAD*BETA*(SREF/A(3))*CLAW*(TAPEXP+1.)*(2.*SPAN/DD-1.))
      GO TO 1040
 1030 CONTINUE
      LGH(1)=11
      VAR(1)=DD/(2.*SPAN)
C
C                   FIGURE 4.3.1.2-10 KBW
C
      CALL INTERX(1,TFIG10,VAR,LGH,DKBW10,KBW,11,11,
     1            0,0,0,0,0,0,0,0,Q31210,3,ROUTID)
 1040 CONTINUE
      GO TO 1060
C
C  ***SUPERSONIC WING-BODY LIFT CURVE SLOPE,BODY IN PRESENCE OF WING***
C                         TRIANGULAR WING
C
 1050 CONTINUE
      ARG=BETA*ARSTAR
      IF(ARG.GT.1.)GO TO 1000
      GO TO 1030
 1060 CONTINUE
C
C  ***SUPERSONIC WING-BODY LIFT CURVE SLOPE
C
      ALBO=BD(81)
      IF(BD(81).EQ.UNUSED)ALBO=0.0
      DO 1070 J=1,NALPHA
 1070 ALPHAB(J)=FLC(J+22)+ALBO
      VAR(1)=(SPAN-SPANS)/SPAN
      LGH(1)=11
C
C                   FIGURE 4.3.1.2-10 KWB
C
      CALL INTERX(1,TFIG10,VAR,LGH,DKWB10,KWB,11,11,
     1            0,0,0,0,0,0,0,0,Q31210,3,ROUTID)
      CLAWB=CLAW*KWB
      CLABW=CLAW*KBW
      CLA=CLABW+CLAWB+CLAB
C
C  ***SUPERSONIC WING-BODY LIFT AT ANGLE OF ATTACK***
C
      IF(TYPE.NE.WTYPE(1))GO TO 1100
      IF(ALIW.EQ.0.0.OR.(ALIW.EQ.UNUSED))GO TO 1080
C
C                   FIGURE 4.3.1.2-12A (KBW) INCIDENCE
C
      CALL INTERX(1,T4312A,VAR,LGH,D4312A,KKBW,11,11,
     1            0,0,0,0,0,0,0,0,Q1212A,3,ROUTID)
C
C                   FIGURE 4.3.1.2-12B (KWB) INCIDENCE
C
      LGH(1)=8
      CALL INTERX(1,T4312B,VAR,LGH,D4312B,KKWB,8,8,
     1            0,0,0,0,0,0,0,0,Q1212B,3,ROUTID)
 1080 CLI=CLAW*ALIW
      DETCL=0.0
      BD(83)=XW+A(161)
      BD(535)=SPAN-SPANS
      CALL BODOWG(BD(255),BD(83),BD(535),SPAN,A(27),
     1            IVBW,GAMMA,NALPHA)
      ARG1=KWB+KBW
      ARG2=(KKWB+KKBW)*CLI
      ARG3=CLAW*(DD/(2.*SPAN))
      DO 1090 J=1,NALPHA
         DETCL=ARG3*ALPHAB(J)*IVBW(J)*GAMMA(J)
 1090 CL(J)=CLB(J)+ARG1*(CLW(J)-CLI)+ARG2+DETCL
C
C  ***SUPERSONIC CENTER OF PRESSURE FOR BODY NOSE AND FORBODY***
C
 1100 CONTINUE
      DELXW=(SPAN-SPANS)*TANLE*COS(ALIW/RAD)
      RLAP=XW+DELXW-RLN
      ARG1=RLN
      IF(RLAP.LT.0.)ARG1=RLN+RLAP
      IF(RLAP.LT.0.)RLAP=0.0
      FA=RLAP/DCYL
      FN=ARG1/DCYL
      VAR(1)=BETA/FN
      VAR(2)=FA/FN
      LGH(1)=6
      LGH(2)=9
      IF(BNOSE.EQ.1.)GO TO 1120
C
C                   FIGURE 4.2.2.1-23A LEFT SIDE(XCP) OGIVE
C
      IF(VAR(1).GT.1.)GO TO 1110
      CALL INTERX(2,T4218A,VAR,LGH,DL218A,XCPLN,9,54,
     1            0,0,0,0,0,0,0,0,Q2118A,3,ROUTID)
      GO TO 1140
 1110 VAR(1)=1./VAR(1)
C
C                   FIGURE 4.2.2.1-23A RIGHT SIDE(XCP) OGIVE
C
      CALL INTERX(2,T4218A,VAR,LGH,DR218A,XCPLN,9,54,
     1           0,0,0,0,0,0,0,0,Q2118A,3,ROUTID)
      GO TO 1140
 1120 CONTINUE
C
C                   FIGURE 4.2.2.1-23B LEFT SIDE(XCP) CONE
C
      LGH(2)=7
      IF(VAR(1).GT.1.)GO TO 1130
      CALL INTERX(2,T4218B,VAR,LGH,DL218B,XCPLN,7,42,
     1           0,0,0,0,0,0,0,0,Q2118B,3,ROUTID)
      GO TO 1140
 1130 VAR(1)=1./VAR(1)
C
C                   FIGURE 4.2.2.1-23B RIGHT SIDE(XCP) CONE
C
      CALL INTERX(2,T4218B,VAR,LGH,DR218B,XCPLN,7,42,
     1            0,0,0,0,0,0,0,0,Q2118B,3,ROUTID)
 1140 CONTINUE
      XACN=(XCPLN-1.)*(ARG1+RLAP)/CBARR
C
C  ***SUPERSONIC WING-LIFT CARRYOVER ON BODY***
C
      VAR(1)=BETA*DD/CRSTAR
      VAR(2)=BETA/TANLE
      ARG=(XW+CR)/RLB
      IF(ARG.GT.1.)GO TO 1150
C
C                   FIGURE 4.3.2.2-37A(XAC)B(W)
C
      LGH(1)=8
      LGH(2)=3
      CALL INTERX(2,T4337A,VAR,LGH,D4337A,XACA,8,24,
     1           0,0,0,0,1,0,0,0,Q2137A,3,ROUTID)
      GO TO 1160
C
C                   FIGURE 4.3.2.2-37B(XAC)B(W)
C
 1150 LGH(1)=10
      LGH(2)=2
      CALL INTERX(2,T4337B,VAR,LGH,D4337B,XACA,10,20,
     1           0,0,0,0,0,0,0,0,Q2137B,3,ROUTID)
 1160 XACBW=XACA*CRSTAR/CBARR
      XACW=XACW*CRSTAR/CBARR
C
C  ***SUPERSONIC WING-BODY PITCHING MOMENT SLOPE***
C
      DNUM=XACN*CLAB+XACW*CLAWB+XACBW*CLABW
      DNOM=CLAB+CLAWB+CLABW
      XAC  =DNUM/DNOM
      CMA=(DXCG/CBARR-XAC)*CLA
C
C  ***SUPERSONIC WING-BODY DRAG***
C
      CDOWB=CDOW+CDOB
      DO 1170 J=1,NALPHA
         COSA=COS(FLC(J+22)/RAD)
         SINA=SIN(FLC(J+22)/RAD)
         CD(J)=CDOW+CDL(J)+CDB(J)
         CN(J)=CL(J)*COSA+CD(J)*SINA
C
C   COMPUTE DELTA XCP WING-BODY
C
         DXCPWB=A(173)/CBARR-SLG(134)
C
C   COMPUTE DELTA XCP BODY-WING
C
         DXCPBW=A(173)/CBARR-SWB(8)
C
C   COMPUTE DELTA CN VORTEX
C
         DCNV=SWB(11+J)*SWB(39+J)*SWB(5)/(2*SPAN)*BD(254+J)*WING(101)
     1        /RAD
C
C   COMPUTE WING-BODY PITCHING MOMENT
C
         BW(40+J)=BODY(40+J)+WING(60+J)*SWB(35)*DXCPWB
     1           +WING(101)*SYNA(4)*SWB(2)*DXCPWB/RAD
     2           +WING(60+J)*SWB(11)*DXCPBW
     3           +WING(101)*SYNA(4)*SWB(37)*DXCPBW/RAD
     4           +DCNV*DXCPWB
     5           +WING(80+J)*(SYNA(3)-SYNA(5))/CBARR
 1170 CA(J)=CD(J)*COSA-CL(J)*SINA
      RETURN
      END
