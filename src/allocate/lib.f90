module f_alloc

use, intrinsic:: iso_c_binding, only: c_float, c_size_t, c_loc, c_ptr, c_f_pointer
use, intrinsic:: iso_fortran_env, only: stderr=>error_unit

implicit none (type, external)

contains


subroutine alloc1(Ac, Bc, dims) bind(C)

type(c_ptr), intent(inout) :: Ac, Bc
integer(c_size_t), intent(in) :: dims(1)

real(c_float), pointer, dimension(:) :: A, B

allocate(A(dims(1)))
Ac = c_loc(A)
print *, "Fortran: A bound to Ac"

allocate(B, mold=A)
print *, "Fortran: B allocated"
Bc = c_loc(B)
print *, "Fortran: B bound to Bc"

end subroutine alloc1


subroutine alloc2(Ac, Bc, dims) bind(C)

type(c_ptr), intent(inout) :: Ac, Bc
integer(c_size_t), intent(in) :: dims(2)

real(c_float), pointer, dimension(:,:) :: A, B

allocate(A(dims(1), dims(2)))
Ac = c_loc(A)
print *, "Fortran: A bound to Ac"

allocate(B, mold=A)
print *, "Fortran: B allocated"
Bc = c_loc(B)
print *, "Fortran: B bound to Bc"

end subroutine alloc2


subroutine alloc3(Ac, Bc, dims) bind(C)

type(c_ptr), intent(inout) :: Ac, Bc
integer(c_size_t), intent(in) :: dims(3)

real(c_float), pointer, dimension(:,:,:) :: A, B

allocate(A(dims(1), dims(2), dims(3)))
Ac = c_loc(A)
print *, "Fortran: A bound to Ac"

allocate(B, mold=A)
print *, "Fortran: B allocated"
Bc = c_loc(B)
print *, "Fortran: B bound to Bc"

end subroutine alloc3


subroutine alloc4(Ac, Bc, dims) bind(C)

type(c_ptr), intent(inout) :: Ac, Bc
integer(c_size_t), intent(in) :: dims(4)

real(c_float), pointer, dimension(:,:,:,:) :: A, B

allocate(A(dims(1), dims(2), dims(3), dims(4)))
Ac = c_loc(A)
print *, "Fortran: A bound to Ac"

allocate(B, mold=A)
print *, "Fortran: B allocated"
Bc = c_loc(B)
print *, "Fortran: B bound to Bc"

end subroutine alloc4


subroutine dealloc1(Ac, Bc, dims) bind(C)
type(c_ptr), intent(inout) :: Ac, Bc
integer(c_size_t), intent(in) :: dims(1)

real(c_float), pointer, dimension(:) :: A, B
integer :: ierr
character(100) :: emsg

call c_f_pointer(Ac, A, dims)
call c_f_pointer(Bc, B, dims)
deallocate(A, B, stat=ierr, errmsg=emsg)
if (ierr /= 0) then
  write(stderr,'(a,i0,a)') "dealloc1: error", ierr, " deallocation failed: " // emsg
  if(ierr == 173 .or. ierr == 4412) error stop 77
  !! Intel: 173.  Cray: 4412.
  error stop
end if

end subroutine dealloc1


subroutine dealloc2(Ac, Bc, dims) bind(C)
type(c_ptr), intent(inout) :: Ac, Bc
integer(c_size_t), intent(in) :: dims(2)

real(c_float), pointer, dimension(:,:) :: A, B
integer :: ierr
character(100) :: emsg

call c_f_pointer(Ac, A, dims)
call c_f_pointer(Bc, B, dims)
deallocate(A, B, stat=ierr, errmsg=emsg)
if (ierr /= 0) then
  write(stderr,'(a,i0,a)') "dealloc2: error", ierr, " deallocation failed: " // emsg
  if(ierr == 173) error stop 77
  error stop
end if
end subroutine dealloc2


subroutine dealloc3(Ac, Bc, dims) bind(C)
type(c_ptr), intent(inout) :: Ac, Bc
integer(c_size_t), intent(in) :: dims(3)

real(c_float), pointer, dimension(:,:,:) :: A, B
integer :: ierr
character(100) :: emsg

call c_f_pointer(Ac, A, dims)
call c_f_pointer(Bc, B, dims)
deallocate(A, B, stat=ierr, errmsg=emsg)
if (ierr /= 0) then
  write(stderr,'(a,i0,a)') "dealloc3: error", ierr, " deallocation failed: " // emsg
  if(ierr == 173) error stop 77
  error stop
end if
end subroutine dealloc3


subroutine dealloc4(Ac, Bc, dims) bind(C)
type(c_ptr), intent(inout) :: Ac, Bc
integer(c_size_t), intent(in) :: dims(4)

real(c_float), pointer, dimension(:,:,:,:) :: A, B
integer :: ierr
character(100) :: emsg

call c_f_pointer(Ac, A, dims)
call c_f_pointer(Bc, B, dims)
deallocate(A, B, stat=ierr, errmsg=emsg)
if (ierr /= 0) then
  write(stderr,'(a,i0,a)') "dealloc4: error", ierr, " deallocation failed: " // emsg
  if(ierr == 173) error stop 77
  error stop
end if
end subroutine dealloc4


end module f_alloc
