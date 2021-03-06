      SUBROUTINE FIG53A ( RV,Z,R)
C
C*********          SUBROUTINE TO COMPUTE FIGURE 4.1.5.2-53-A
C
      DIMENSION A(5),B(5),C(5),D(5),E(5),ZZ(5)
      DATA A/8.98425E-03,4.50351E-03,6.0128E-03,1.07637E-02,8.48758E-03/
      DATA B/-.138262,-.064239,-.08858,-.167056,-.130342/
      DATA C/0.718213,0.263365,0.410583,0.893775,0.67405/
      DATA D/-1.32167,-9.04994E-02,-0.489542,-1.80535,-1.22853/
      DATA E/0.493821,-0.735445,-0.317567,1.02609,0.471355/
      DATA ZZ/0.0,1.0,2.0,4.0,10.0/
      IF(RV.EQ.0.0) GO TO 1070
      X=ALOG10(RV)
      M=1
 1000 TEMP= ABS(Z-ZZ(M))
      IF(Z.GE.ZZ(M).AND.Z.LT.ZZ(M+1)) GO TO 1030
 1010 M=M+1
      IF(M.GT.4) GO TO 1060
 1020 GO TO 1000
 1030 CONTINUE
      YM=A(M)*X**5+B(M)*X**4+C(M)*X**3+D(M)*X**2+E(M)*X
      IF(TEMP.LE.0.001) GO TO 1050
 1040 N=M+1
      YN=A(N)*X**5+B(N)*X**4+C(N)*X**3+D(N)*X**2+E(N)*X
      R=YM+((Z-ZZ(M))/(ZZ(N)-ZZ(M)))*(YN-YM)
      IF(R.LT.0.)R=0.
      RETURN
 1050 R=YM
      IF(R.LT.0.)R=0.
      RETURN
 1060 R=A(M)*X**5+B(M)*X**4+C(M)*X**3+D(M)*X**2+E(M)*X
      IF(R.LT.0.)R=0.
      RETURN
 1070 R=0.0
      RETURN
      END
