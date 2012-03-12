      PROGRAM DATCOM
C
C***  NOTE - THE FOLLOWING THREE CARDS ARE REQUIRED FOR CYBER
C
C     PROGRAM DATCOM(INPUT=100,OUTPUT,TAPE5=INPUT,TAPE6=OUTPUT,
C    1               TAPE8=100,TAPE9=100,TAPE10=100,TAPE11=100,
C    2               TAPE12,TAPE13,TAPE14)
C
C***  NOTE - WHEN CONVERTING FROM FORTRAN-IV TO FORTRAN-V THE
C***  END-OF-FILE CHECKS IN ROUTINES CONERR, INPUT, READCD, AND XPERNM
C***  MUST BE CHANGED.  THE CORRECT CODE IS GIVEN IN THE
C***  APPROPIATE PLACES OF EACH ROUTINE.  REPLACE THE C IN COLUMN 1
C***  WITH A BLANK AND ON THE CARDS IDENTIFIED AS FORTRAN-V
C***  REPLACE THE BLANK IS COLUMN 1 WITH A C.
C
C***  THIS PROGRAM REQUIRES SEVERAL TAPE UNITS FOR I/O.  THESE ARE
C***  DEFINED IN FORTRAN-V IN THE OPEN STATEMENTS IN THIS ROUTINE.
C***  THEY MUST BE CHANGES TO COMMENT CARDS BEFORE COMPILING IN
C***  FORTRAN-IV.
C
C     ----DATCOM MAIN PROGRAM
C
C
C***  IDEAL OUTPUT MATRIX
C
C             BLOCK    PRINT     IOM
C             NAME     FLAG     ARRAY
C
      COMMON /IBODY/   PBODY,  BODY(400)
      COMMON /IWING/   PWING,  WING(400)
      COMMON /IHT/     PHT,    HT(380)
      COMMON /IVT/     PVT,    VT(380)
      COMMON /IVF/     PVF,    VF(380)
      COMMON /IBW/     PBW,    BW(380)
      COMMON /IBH/     PBH,    BH(380)
      COMMON /IBV/     PBV,    BV(380)
      COMMON /IBWH/    PBWH,   BWH(380)
      COMMON /IBWV/    PBWV,   BWV(380)
      COMMON /IBWHV/   PBWHV,  BWHV(380)
      COMMON /IPOWER/  PPOWER, POWER(200)
      COMMON /IDWASH/  PDWASH, DWASH(60)
C
      LOGICAL PBODY, PWING, PHT, PVT, PVF, PBW, PBH, PBV, PBWH, PBWV,
     1        PBWHV, PPOWER, PDWASH
C
C***  INPUT DATA BLOCKS
C
      COMMON /FLGTCD/ FLC(160)
      COMMON /OPTION/ SREF, CBARR, ROUGFC, BLREF, IRUN
      COMMON /SYNTSS/ XCG, XW, ZW, ALIW, ZCG, XH, ZH, ALIH, XV,
     1                VERTUP, HINAX, XVF, SCALE, ZV, ZVF, YV, YF,
     2                PHIV, PHIF
      COMMON /BODYI/  BODYIN(129)
      COMMON /WINGI/  WINGIN(101)
      COMMON /VTI/    VTIN(154), TVTIN(8), VFIN(154)
      COMMON /HTI/    HTIN(154)
      COMMON /POWER/  PWIN(29), LBIN(21)
      COMMON /FLAPIN/ F(138)
C
      DIMENSION MACH(20), VINF(20), ALT(20), PINF(20), TINF(20)
      DIMENSION ZL(20), RNNUB(20)
      EQUIVALENCE (ZL(1),BODYIN(102))
      EQUIVALENCE (FLC(3),MACH(1)), (FLC(43),RNNUB(1)), (FLC(97),ALT(1))
      EQUIVALENCE (FLC(117),TINF(1)), (FLC(137),VINF(1))
      EQUIVALENCE (FLC(74),PINF(1))
      LOGICAL VERTUP
      REAL MACH
C
C***  COMPUTATIONAL BLOCKS
C
      COMMON /WINGD/  A(195), B(49)
      COMMON /SBETA/  STB(135), TRA(108), TRAH(108), STBH(135)
      COMMON /BDATA/  BD(762)
      COMMON /WHWB/   FACT(182), WB(39), HB(39)
      COMMON /WBHCAL/ WBT(156)
      COMMON /HTDATA/ AHT(195), BHT(49)
      COMMON /VTDATA/ AVT(195), AVF(195)
      COMMON /WHAERO/ C(51), D(55), CHT(51), DHT(55), DVT(55), DVF(55)
      COMMON /POWR/   PW(315)
      COMMON /SUPWBB/  SWB(61), SHB(61)
      COMMON /SUPDW/  DWA(237)
      COMMON /SUPWH/  GR(303)
      COMMON /SUPBOD/ SBD(229)
      COMMON /LEVEL2/ SECOND(23)
C
      DIMENSION SLG(141), STG(141), FCM(287), LB(200), DYN(213)
      DIMENSION SPR(59),FLA(45), FLP(189), STP(156), JET(26), SLA(31)
      DIMENSION FHG(35), TCD(58), TRM(22), TRM2(22), TRN(7), DYNH(213)
      DIMENSION SLAH(31)
C
      EQUIVALENCE (GR(1), FCM(1), SLG(1)), (GR(142), STG(1))
      EQUIVALENCE (DWA(1), LB(1), JET(1), FHG(1)), (WBT(1), STP(1))
      EQUIVALENCE (PW(1), DYN(1), SPR(1)), (PW(60), FLA(1))
      EQUIVALENCE (PW(105), FLP(1)), (PW(294), TRM(1), TRM2(1), TRN(1))
      EQUIVALENCE (STB(1), SLA(1)), (DWA(36), TCD(1)), (DYNH(1),BD(301))
      EQUIVALENCE (STB(32), SLAH(1))
C
C***   CONTROL DATA BLOCKS
C
      COMMON /CONSNT/ PI,DEG,UNUSED,RAD,KAND
      COMMON /OVERLY/ NLOG,NMACH,I,NALPHA,IG,NF,LF,K,NOVLY
      COMMON /CASEID/ IDCASE(74),KOUNT,NAMSV(100),IDIM
      COMMON /EXPER/  KLIST, NLIST(100), NNAMES, IMACH, MDATA,
     1                KBODY, KWING, KHT, KVT, KWB, KDWASH(3),
     2                ALPOW, ALPLW, ALPOH, ALPLH
      COMMON /FLOLOG/ FLTC,OPTI,BO,WGPL,WGSC,SYNT,HTPL,HTSC,VTPL,VTSC,
     1                HEAD,PRPOWR,JETPOW,LOASRT,TVTPAN,SUPERS,SUBSON,
     2                TRANSN,HYPERS,SYMFP,ASYFP,TRIMC,TRIM,DAMP,
     3                HYPEF,TRAJET,BUILD,FIRST,DRCONV,PART,
     4                VFPL,VFSC,CTAB,PLOT
      COMMON /ERROR/  IERR,GONOGO,IEND,DMPALL,DPB,DPA,DPBD,DPAVF,
     1                DPFACT,DPWBT,DPBHT,DPAVT,DPAHT,DPC,DPD,DPWB,
     2                DPCHT,DPDHT,DPDYNH,SAVE,DMPCSE,DPDVT,DPGR,DPLB,
     3                DPPW,DPSTB,DPSBD,DPSLG,DPSWB,DPSTP,DPDWA,DPSTG,
     4                DPSLA,DPTRA,DPEXPD,DPDVF,DPFLP,DPFHG,DPFCM,DPTCD,
     5                DPFLA,DPTRM,DPSPR,DPTRN,DPTRM2,DPHYP,DPDYN,DPJET,
     6                DPHB,DPSHB,DPTRAH,DPSTBH,DPSEC,DPSLAH,DPINPT,
     7                DPFLC,DPOPTN,DPSYN,DPBDIN,DPWGIN,DPVTIN,DPTVT,
     8                DPVFIN,DPHTIN,DPPWIN,DPLBIN,DPF,DPIOM,
     9                DPIBDY,DPIWG,DPIHT,DPIVT,DPIVF,DPIBW,DPIBH,DPIBV,
     A                DPIBWH,DPIBWV,DPITOT,DPIPWR,DPIDWH,LIST
C
      LOGICAL  FLTC,OPTI,BO,WGPL,WGSC,SYNT,HTPL,HTSC,VTPL,VTSC,
     1         HEAD,PRPOWR,JETPOW,LOASRT,TVTPAN,SUPERS,SUBSON,
     2         TRANSN,HYPERS,SYMFP,ASYFP,TRIMC,TRIM,DAMP,
     3         HYPEF,TRAJET,BUILD,FIRST,DRCONV,PART,
     4         VFPL,VFSC,CTAB,PLOT
      LOGICAL  IERR,GONOGO,IEND,DMPALL,DPB,DPA,DPBD,DPAVF,
     1         DPFACT,DPWBT,DPBHT,DPAVT,DPAHT,DPC,DPD,DPWB,
     2         DPCHT,DPDHT,DPDYNH,SAVE,DMPCSE,DPDVT,DPGR,DPLB,
     3         DPPW,DPSTB,DPSBD,DPSLG,DPSWB,DPSTP,DPDWA,DPSTG,
     4         DPSLA,DPTRA,DPEXPD,DPDVF,DPFLP,DPFHG,DPFCM,DPTCD,
     5         DPFLA,DPTRM,DPSPR,DPTRN,DPTRM2,DPHYP,DPDYN,DPJET,
     6         DPHB,DPSHB,DPTRAH,DPSTBH,DPSEC,DPSLAH,DPINPT,
     7         DPFLC,DPOPTN,DPSYN,DPBDIN,DPWGIN,DPVTIN,DPTVT,
     8         DPVFIN,DPHTIN,DPPWIN,DPLBIN,DPF,DPIOM,
     9         DPIBDY,DPIWG,DPIHT,DPIVT,DPIVF,DPIBW,DPIBH,DPIBV,
     A         DPIBWH,DPIBWV,DPITOT,DPIPWR,DPIDWH,LIST
C
      LOGICAL IM, IRN, IATM
C
      CHARACTER(len=32) :: filename, progname
      INTEGER :: argc
      CALL getarg(0,progname)
      CALL getarg(1,filename)
      if (iargc() /= 1) then
        write(*,*) "usage:", progname, "input.dat"
        return
      end if
      OPEN(UNIT=5,  FILE=filename, STATUS='OLD')
      OPEN(UNIT=6,  FILE='output.dat', STATUS='UNKNOWN')
      OPEN(UNIT=8,  STATUS='SCRATCH')
      OPEN(UNIT=9,  STATUS='SCRATCH')
      OPEN(UNIT=10, STATUS='SCRATCH')
      OPEN(UNIT=11, STATUS='SCRATCH')
      OPEN(UNIT=12, STATUS='SCRATCH')
      OPEN(UNIT=13, FILE='for013.dat', STATUS='UNKNOWN')
      OPEN(UNIT=14, FILE='for014.dat', STATUS='UNKNOWN')
C
C  DISCLAIMER REQUIRED BY HQ USAF FOR PUBLIC RELEASE APPROVAL
C
      PRINT*,'THIS SOFTWARE AND ANY ACCOMPANYING DOCUMENTATION'
      PRINT*,'IS RELEASED "AS IS".  THE U.S. GOVERNMENT MAKES NO'
      PRINT*,'WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, CONCERNING'
      PRINT*,'THIS SOFTWARE AND ANY ACCOMPANYING DOCUMENTATION,'
      PRINT*,'INCLUDING, WITHOUT LIMITATION, ANY WARRANTIES OF'
      PRINT*,'MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.'
      PRINT*,'IN NO EVENT WILL THE U.S. GOVERNMENT BE LIABLE FOR ANY'
      PRINT*,'DAMAGES, INCLUDING LOST PROFITS, LOST SAVINGS OR OTHER'
      PRINT*,'INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE '
      PRINT*,'USE, OR INABILITY TO USE, THIS SOFTWARE OR ANY'
      PRINT*,'ACCOMPANYING DOCUMENTATION, EVEN IF INFORMED IN ADVANCE'
      PRINT*,'OF THE POSSIBILITY OF SUCH DAMAGES.'
C
C
      WRITE(6,900)
  900 FORMAT(////////,
     140X,52H****************************************************,/,
     240X,1H*,4X,42HUSAF STABILITY AND CONTROL  DIGITAL DATCOM,
     3 4X,1H*,/,
     440X,1H*,4X,42HPROGRAM REV. JAN 96   DIRECT INQUIRIES TO:,
     5 4X,1H*,/,
     640X,1H*,3X,44HWRIGHT LABORATORY  (WL/FIGC)  ATTN: W. BLAKE,
     7 3X,1H*,/,
     840X,1H*,9X,33HWRIGHT PATTERSON AFB, OHIO  45433,8X,1H*,/,
     940X,1H*,4X,42HPHONE (513) 255-6764,   FAX (513) 258-4054,
     1 4X,1H*,/,
     240X,52H****************************************************)
C
C***  CASE INITIALIZATION AND READ INPUTS
C
      IRUN  = 0
      NLOG  = 34
      IDIM  = 1
      IEND  = .FALSE.
      SAVE  = .FALSE.
      FIRST = .TRUE.
      REWIND 12
      REWIND 13
 1000 CALL M01O01
C
C***  CALL AIRFOIL SECTION MODULE, OVERLAY 50
C
      CALL M50O62
C
      IF(.NOT. ASYFP) GO TO 1010
        TRIMC = .FALSE.
        TRIM  = .FALSE.
 1010 CONTINUE
C
C***  CATALOG EXPERIMENTAL DATA NAMELISTS, SET CASE DATA
C
      IF(KLIST .GT. 0) CALL M34O42
      NALPHA = FLC(2)+0.5
      NMACH  = FLC(1)+0.5
      LOOP   = FLC(160)+0.5
      NALT   = FLC(159)+0.5
      IF(ROUGFC .LT. 1.E-10) ROUGFC = 1.6E-4
      IF(BLREF .EQ. UNUSED)  BLREF  = 2.0*WINGIN(4)
C
C***  SET LIFTING SURFACE PARAMETERS FOR SUBSONIC AND TRANSONIC MACHS
C
      CALL M02O02
      IF(.NOT. (SUBSON .OR. TRANSN)) GO TO 1020
        IF(WGPL) CALL CLMCH0(A,B,WINGIN(21),WINGIN(41),WINGIN(68),
     1                       WINGIN(69),WING,0)
        IF(HTPL) CALL CLMCH0(AHT,BHT,HTIN(21),HTIN(41),HTIN(68),
     1                       HTIN(69),HT,1)
 1020 CONTINUE
      IG = 1
      CALL M51O63
      IM   = FLC(3) .NE. UNUSED
      IRN  = FLC(43) .NE. UNUSED
      IATM = (FLC(97) .NE. UNUSED) .OR.
     1       ((FLC(117) .NE. UNUSED) .AND. (FLC(74) .NE. UNUSED))
C
C***  LOOP MACH AND ALTITUDE TOGETHER -- LOOP = 1
C
      IF(LOOP .NE. 1) GO TO 1040
        DO 1030 I=1,NMACH
          K = I
          IF(IM .AND. IATM) VINF(I) = MACH(I)*49.01685*SQRT(TINF(K))
          IF(.NOT. IM)      MACH(I) = VINF(I)/(49.01685*SQRT(TINF(K)))
          IF(.NOT. IRN)    RNNUB(I) = 1.2527E6*PINF(K)*MACH(I)*
     1                                (TINF(K)+198.6)/(TINF(K)**2)
          IF(VINF(I) .EQ. UNUSED) VINF(I) = -UNUSED
          IF(ALT(K)  .EQ. UNUSED) ALT(K)  = -UNUSED
          IF(PINF(K) .EQ. UNUSED) PINF(K) = -UNUSED
          IF(TINF(K) .EQ. UNUSED) TINF(K) = -UNUSED
          CALL MAIN00
 1030   CONTINUE
 1040 CONTINUE
C
C***  FIX ALTITUDE AND VARY MACH -- LOOP = 2
C
      IF(LOOP .NE. 2) GO TO 1070
        DO 1060 K=1,NALT
          DO 1050 I=1,NMACH
            IF(IM .AND. IATM) VINF(I) = MACH(I)*49.01685*SQRT(TINF(K))
            IF(.NOT. IM)      MACH(I) = VINF(I)/(49.01685*SQRT(TINF(K)))
            IF(.NOT. IRN)    RNNUB(I) = 1.2527E6*PINF(K)*MACH(I)*
     1                                  (TINF(K)+198.6)/(TINF(K)**2)
            IF(VINF(I) .EQ. UNUSED) VINF(I) = -UNUSED
            IF(ALT(K)  .EQ. UNUSED) ALT(K)  = -UNUSED
            IF(PINF(K) .EQ. UNUSED) PINF(K) = -UNUSED
            IF(TINF(K) .EQ. UNUSED) TINF(K) = -UNUSED
            CALL MAIN00
 1050     CONTINUE
 1060   CONTINUE
 1070 CONTINUE
C
C***  FIX MACH AND VARY ALTITUDE -- LOOP = 3
C
      IF(LOOP .NE. 3) GO TO 1100
        DO 1090 I=1,NMACH
          DO 1080 K=1,NALT
            IF(IM .AND. IATM) VINF(I) = MACH(I)*49.01685*SQRT(TINF(K))
            IF(.NOT. IM)      MACH(I) = VINF(I)/(49.01685*SQRT(TINF(K)))
            IF(.NOT. IRN)    RNNUB(I) = 1.2527E6*PINF(K)*MACH(I)*
     1                                  (TINF(K)+198.6)/(TINF(K)**2)
            IF(VINF(I) .EQ. UNUSED) VINF(I) = -UNUSED
            IF(ALT(K)  .EQ. UNUSED) ALT(K)  = -UNUSED
            IF(PINF(K) .EQ. UNUSED) PINF(K) = -UNUSED
            IF(TINF(K) .EQ. UNUSED) TINF(K) = -UNUSED
            CALL MAIN00
 1080     CONTINUE
 1090   CONTINUE
 1100 CONTINUE
C
C***  DUMP EXTRAPOLATION MESSAGES FOR CASE
C
      CALL M57O71
C
      GO TO 1000
      END
