! Check if assumed size works
SUBROUTINE c_pitcon(c_f,fpar,ierror,ipar,iwork,liw,nvar,rwork,lrw,xr,solver) BIND(C, NAME='c_pitcon')
  USE, INTRINSIC :: iso_c_binding, ONLY : c_int, c_float
  INTERFACE
    SUBROUTINE c_f(nvar,fpar,ipar,x,f) BIND(C)
      USE, INTRINSIC :: iso_c_binding, ONLY : c_int, c_float
      INTEGER(c_int), INTENT(IN) :: nvar
      REAL(c_float), INTENT(INOUT) :: fpar(*)
      INTEGER(c_int), INTENT(INOUT) :: ipar(*)
      REAL(c_float), INTENT(IN) :: x(nvar)
      REAL(c_float), INTENT(OUT) :: f(nvar-1)
    END SUBROUTINE c_f
  END INTERFACE
  EXTERNAL DGE_SLV
  EXTERNAL DGB_SLV
  REAL(c_float) :: fpar(*)
  INTEGER(c_int) :: ipar(*)
  INTEGER(c_int), INTENT(OUT) :: ierror
  INTEGER(c_int), INTENT(IN) :: nvar
  REAL(c_float), INTENT(INOUT)  :: xr(nvar)
  ! Use banded solver if this is not set to zero
  INTEGER(c_int), INTENT(IN) :: solver
  INTEGER(c_int), INTENT(IN) :: lrw
  REAL(c_float), INTENT(INOUT) :: rwork(lrw)
  INTEGER(c_int), INTENT(IN) :: liw
  INTEGER(c_int), INTENT(INOUT) :: iwork(liw)
  if (solver == 0) then
    CALL pitcon(c_f, fpar, c_f, ierror, ipar, iwork, liw, &
        nvar, rwork, lrw, xr, dge_slv)
  else
    CALL pitcon(c_f, fpar, c_f, ierror, ipar, iwork, liw, &
        nvar, rwork, lrw, xr, dgb_slv)
  end if
END SUBROUTINE c_pitcon
