module fancy

use, intrinsic:: iso_fortran_env, only: stderr=>error_unit
use, intrinsic::  iso_c_binding, only: c_ptr, c_float, c_size_t, c_null_ptr, c_loc, c_f_pointer

implicit none

real(C_FLOAT), dimension(:), pointer, save :: A1 => null()

contains

subroutine falloc1(Ac, dims) bind(C)

type(c_ptr), intent(inout) :: Ac
integer(c_size_t), intent(in) :: dims(1)

allocate(A1(dims(1)))
Ac = c_loc(A1(1))

end subroutine falloc1


subroutine fdealloc1(Ac) bind(C)

type(c_ptr), intent(inout) :: Ac
integer :: ierr
character(200) :: emsg

print '(a)', "Fortran: delloc1: dealloc array"
deallocate(A1, stat=ierr, errmsg=emsg)
if (ierr /= 0) then
  write(stderr,'(a,i0,a)') "Fortran: dealloc1: error", ierr, " array failed: " // emsg
  if(ierr == 4412) error stop 77  !< Cray ftn
  error stop
end if

print '(a)', "Fortran: delloc1: dealloc array_t"
Ac = c_null_ptr
nullify(A1)

end subroutine fdealloc1

end module fancy
