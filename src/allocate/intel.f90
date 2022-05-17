module falloc

use, intrinsic:: iso_c_binding, only: c_float, c_size_t, c_loc, c_ptr, c_f_pointer
implicit none (type, external)

! type :: dat
!   real(c_float), dimension(:), pointer :: A1
! end type dat

contains


subroutine alloc1(Ac, dims) bind(C)

type(c_ptr), intent(inout) :: Ac
integer(c_size_t), intent(in) :: dims(1)

real(c_float), pointer, dimension(:) :: A

allocate(A(dims(1)))
Ac = c_loc(A)
print *, "alloc1: C pointer bound to Fortran pointer"

end subroutine alloc1


subroutine dealloc1(Ac, dims) bind(C)
type(c_ptr), intent(inout) :: Ac
integer(c_size_t), intent(in) :: dims(1)

real(c_float), pointer, dimension(:) :: A
! type(dat), pointer :: d

call c_f_pointer(Ac, A, dims)
deallocate(A)
! d%A1 => A
! deallocate(d%A1)
end subroutine dealloc1


end module falloc
