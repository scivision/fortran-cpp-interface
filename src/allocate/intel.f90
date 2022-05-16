module falloc

use, intrinsic :: iso_c_binding, only : c_float, c_size_t, c_loc, c_ptr
implicit none (type, external)

contains

subroutine alloc1(Ac, Bc, dims) bind(C)

type(c_ptr), intent(inout) :: Ac, Bc
integer(c_size_t), intent(in) :: dims(1)

real(c_float), pointer, dimension(:) :: A, B

allocate(A(dims(1)))
Ac = c_loc(A)
print *, "Fortran: A bound to Ac"

!allocate(B(dims(1)))
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

!allocate(B(dims(1), dims(2)))
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

!allocate(B(dims(1), dims(2), dims(3)))
allocate(B, mold=A)  !< this doesn't work with oneAPI
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

!allocate(B(dims(1), dims(2), dims(3), dims(4)))
allocate(B, mold=A)  !< this doesn't work with oneAPI
print *, "Fortran: B allocated"
Bc = c_loc(B)
print *, "Fortran: B bound to Bc"

end subroutine alloc4


end module falloc
