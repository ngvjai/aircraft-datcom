      SUBROUTINE M01O01
C
C***  EXEC FOR OVERLAY 1, INITIALIZE PROGRAM AND PROCESS INPUTS
C
      external blockd
      COMMON /CONSNT/ PI,DEG,UNUSED,RAD
      COMMON /OVERLY/ NLOG,NMACH,I,NALPHA,IG,IJKDUM(3),NOVLY
      COMMON /FLOLOG/ FLTC,OPTI,BO,WGPL,WGSC,SYNT,HTPL,HTSC,VTPL,VTSC,
     1                HEAD,PRPOWR,JETPOW,LOASRT,TVTPAN,SUPERS,SUBSON,
     2                TRANSN,HYPERS,SYMFP,ASYFP,TRIMC,TRIM,DAMP,
     3                HYPEF,TRAJET,BUILD,FIRST,DRCONV,PART,
     4                VFPL,VFSC,CTAB
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
     A                DPIBWH,DPIBWV,DPITOT,DPIPWR,DPIDWH
      COMMON /EXPER/  KLIST,NLIST(100),NN(2),FLAG(9),ALP(4)
C
      LOGICAL  LEQV(65),LOGCOM(34),FLAG
      LOGICAL  FLTC,OPTI,BO,WGPL,WGSC,SYNT,HTPL,HTSC,VTPL,VTSC,
     1         HEAD,PRPOWR,JETPOW,LOASRT,TVTPAN,SUPERS,SUBSON,
     2         TRANSN,HYPERS,SYMFP,ASYFP,TRIMC,TRIM,DAMP,
     3         HYPEF,TRAJET,BUILD,FIRST,DRCONV,PART,
     4         VFPL,VFSC,CTAB
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
     A         DPIBWH,DPIBWV,DPITOT,DPIPWR,DPIDWH
C
      EQUIVALENCE (LOGCOM(1),FLTC)
      EQUIVALENCE (LEQV(1),IERR)
C
      NOVLY=1
C
C***  TEST FOR VALID INPUT ON THE FIRST ENTRY - CONERR
C
      IF(.NOT. FIRST) GO TO 1010
          FIRST = .FALSE.
          DRCONV = .FALSE.
          CALL CONERR
 1010 CONTINUE
C
C***  INITIALIZE INPUTS AND DATA ARRAYS
C
      CALL INITZE
      HEAD = .FALSE.
      IERR = .FALSE.
      DO 1020 L=1,NLOG
          IF(L .EQ. 29) GO TO 1020
          LOGCOM(L) = .FALSE.
 1020 CONTINUE
      IF(SAVE) GO TO 1040
          REWIND 8
          KLIST = 0
          DO 1030 L=1,100
          IF(L .LE. 9) FLAG(L) = .FALSE.
          IF(L .LE. 4) ALP(L)  = UNUSED
 1030     NLIST(L) = 0
 1040 CONTINUE
C
C***  READ AND WRITE INPUTS
C
      CALL INPUT
      IF(.NOT. GONOGO) GO TO 1010
C
C***  TEST INPUTS
C
      CALL CHECK
      IF(IERR) GO TO 1010
      RETURN
      END
