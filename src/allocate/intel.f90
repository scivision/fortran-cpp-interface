module falloc

use, intrinsic:: iso_c_binding, only: c_float, c_size_t, c_loc, c_ptr, c_f_pointer
implicit none (type, external)

! type :: dat
!   real(c_float), dimension(:), pointer :: A1, B1
! end type dat

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


subroutine dealloc1(Ac, Bc, dims) bind(C)
type(c_ptr), intent(inout) :: Ac, Bc
integer(c_size_t), intent(in) :: dims(1)

real(c_float), pointer, dimension(:) :: A, B
! type(dat), pointer :: d

call c_f_pointer(Ac, A, dims)
call c_f_pointer(Bc, B, dims)
deallocate(A, B)
! d%A1 => A
! d%B1 => B
! deallocate(d%A1, d%B1)
end subroutine dealloc1


end module falloc
