module fancy

use, intrinsic:: iso_fortran_env, only: stderr=>error_unit
use, intrinsic::  iso_c_binding, only: c_ptr, c_size_t, c_null_ptr, c_loc, c_f_pointer

implicit none (type, external)

type :: array_t
  integer, dimension(:), pointer :: A1
  type(c_ptr)        :: ptr=c_null_ptr
end type array_t

contains

subroutine alloc1(Ac, dims) bind(C)

type(c_ptr), intent(inout) :: Ac
integer(c_size_t), intent(in) :: dims(1)

integer, pointer :: A(:)
type(array_t), pointer :: At

allocate(At)
allocate(A(dims(1)))
At%ptr = c_loc(A)
At%A1 => A
Ac = c_loc(At)

end subroutine alloc1


subroutine dealloc1(Ac) bind(C)

type(c_ptr), intent(inout) :: Ac

type(array_t), pointer :: At
integer :: ierr
character(200) :: emsg

call c_f_pointer(Ac, At)

print *, "delloc1: dealloc array"
deallocate(At%A1, stat=ierr, errmsg=emsg)
if (ierr /= 0) then
  write(stderr,'(a,i0,a)') "dealloc1: error", ierr, " array failed: " // emsg
  if(ierr == 4412) error stop 77  !< Cray ftn
  error stop
end if

print *, "delloc1: dealloc array_t"
deallocate(At, stat=ierr, errmsg=emsg)
if (ierr /= 0) then
  write(stderr,'(a,i0,a)') "dealloc1: error", ierr, " array_t failed: " // emsg
  if(ierr == 4412) error stop 77  !< Cray ftn
  error stop
end if

end subroutine dealloc1

end module fancy
