module f_alloc

use, intrinsic:: iso_c_binding, only: c_bool, c_float, c_size_t, c_loc, c_ptr, c_f_pointer
implicit none (type, external)

contains

subroutine alloc1(Ac, Bc, dims, use_mold) bind(C)

type(c_ptr), intent(inout) :: Ac, Bc
integer(c_size_t), intent(in) :: dims(1)
logical(c_bool) :: use_mold

real(c_float), pointer, dimension(:) :: A, B

allocate(A(dims(1)))
Ac = c_loc(A)
print *, "Fortran: A bound to Ac"


if (use_mold) then
  allocate(B, mold=A)
else
  allocate(B(dims(1)))
endif
print *, "Fortran: B allocated"
Bc = c_loc(B)
print *, "Fortran: B bound to Bc"

end subroutine alloc1


subroutine alloc2(Ac, Bc, dims, use_mold) bind(C)

type(c_ptr), intent(inout) :: Ac, Bc
integer(c_size_t), intent(in) :: dims(2)
logical(c_bool) :: use_mold

real(c_float), pointer, dimension(:,:) :: A, B

allocate(A(dims(1), dims(2)))
Ac = c_loc(A)
print *, "Fortran: A bound to Ac"

if (use_mold) then
  allocate(B, mold=A)
else
  allocate(B(dims(1), dims(2)))
endif
print *, "Fortran: B allocated"
Bc = c_loc(B)
print *, "Fortran: B bound to Bc"

end subroutine alloc2


subroutine alloc3(Ac, Bc, dims, use_mold) bind(C)

type(c_ptr), intent(inout) :: Ac, Bc
integer(c_size_t), intent(in) :: dims(3)
logical(c_bool) :: use_mold

real(c_float), pointer, dimension(:,:,:) :: A, B

allocate(A(dims(1), dims(2), dims(3)))
Ac = c_loc(A)
print *, "Fortran: A bound to Ac"

if (use_mold) then
  allocate(B, mold=A)
else
  allocate(B(dims(1), dims(2), dims(3)))
endif
print *, "Fortran: B allocated"
Bc = c_loc(B)
print *, "Fortran: B bound to Bc"

end subroutine alloc3


subroutine alloc4(Ac, Bc, dims, use_mold) bind(C)

type(c_ptr), intent(inout) :: Ac, Bc
integer(c_size_t), intent(in) :: dims(4)
logical(c_bool) :: use_mold

real(c_float), pointer, dimension(:,:,:,:) :: A, B
integer :: ierr
character(100) :: errmsg

allocate(A(dims(1), dims(2), dims(3), dims(4)), stat=ierr, errmsg=errmsg)
if(ierr /= 0) error stop "alloc4: (A) " // errmsg
Ac = c_loc(A)
print *, "Fortran: A bound to Ac"

if (use_mold) then
  allocate(B, mold=A)
else
  allocate(B(dims(1), dims(2), dims(3), dims(4)))
endif
print *, "Fortran: B allocated"
Bc = c_loc(B)
print *, "Fortran: B bound to Bc"

end subroutine alloc4


subroutine dealloc1(Ac, Bc, dims) bind(C)
type(c_ptr), intent(inout) :: Ac, Bc
integer(c_size_t), intent(in) :: dims(1)

real(c_float), pointer, dimension(:) :: A, B

call c_f_pointer(Ac, A, dims)
call c_f_pointer(Bc, B, dims)
deallocate(A, B)
end subroutine dealloc1


subroutine dealloc2(Ac, Bc, dims) bind(C)
type(c_ptr), intent(inout) :: Ac, Bc
integer(c_size_t), intent(in) :: dims(2)

real(c_float), pointer, dimension(:,:) :: A, B
call c_f_pointer(Ac, A, dims)
call c_f_pointer(Bc, B, dims)
deallocate(A, B)
end subroutine dealloc2


subroutine dealloc3(Ac, Bc, dims) bind(C)
type(c_ptr), intent(inout) :: Ac, Bc
integer(c_size_t), intent(in) :: dims(3)

real(c_float), pointer, dimension(:,:,:) :: A, B
call c_f_pointer(Ac, A, dims)
call c_f_pointer(Bc, B, dims)
deallocate(A, B)
end subroutine dealloc3


subroutine dealloc4(Ac, Bc, dims) bind(C)
type(c_ptr), intent(inout) :: Ac, Bc
integer(c_size_t), intent(in) :: dims(4)

real(c_float), pointer, dimension(:,:,:,:) :: A, B
call c_f_pointer(Ac, A, dims)
call c_f_pointer(Bc, B, dims)
deallocate(A, B)
end subroutine dealloc4


end module f_alloc
