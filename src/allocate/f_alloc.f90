module f_alloc

use, intrinsic:: iso_c_binding, only: c_float, c_size_t, c_loc, c_ptr, c_null_ptr, c_associated
use, intrinsic:: iso_fortran_env, only: stderr=>error_unit

implicit none

real(c_float), pointer, save :: A1(:) => null(), B1(:) => null()
real(c_float), pointer, save :: A2(:,:) => null(), B2(:,:) => null()
real(c_float), pointer, save :: A3(:,:,:) => null(), B3(:,:,:) => null()
real(c_float), pointer, save :: A4(:,:,:,:) => null(), B4(:,:,:,:) => null()

contains


subroutine alloc1(Ac, Bc, dims) bind(C)

type(c_ptr), intent(inout) :: Ac, Bc
integer(c_size_t), intent(in) :: dims(1)

allocate(A1(dims(1)))
Ac = c_loc(A1(1))
print *, "Fortran: A bound to Ac"

allocate(B1, mold=A1)
print *, "Fortran: B allocated"
Bc = c_loc(B1(1))
print *, "Fortran: B bound to Bc"

end subroutine alloc1


subroutine alloc2(Ac, Bc, dims) bind(C)

type(c_ptr), intent(inout) :: Ac, Bc
integer(c_size_t), intent(in) :: dims(2)

allocate(A2(dims(1), dims(2)))
Ac = c_loc(A2(1,1))
print *, "Fortran: A bound to Ac"

allocate(B2, mold=A2)
print *, "Fortran: B allocated"
Bc = c_loc(B2(1,1))
print *, "Fortran: B bound to Bc"

end subroutine alloc2


subroutine alloc3(Ac, Bc, dims) bind(C)

type(c_ptr), intent(inout) :: Ac, Bc
integer(c_size_t), intent(in) :: dims(3)

allocate(A3(dims(1), dims(2), dims(3)))
Ac = c_loc(A3(1,1,1))
print *, "Fortran: A bound to Ac"

allocate(B3, mold=A3)
print *, "Fortran: B allocated"
Bc = c_loc(B3(1,1,1))
print *, "Fortran: B bound to Bc"

end subroutine alloc3


subroutine alloc4(Ac, Bc, dims) bind(C)

type(c_ptr), intent(inout) :: Ac, Bc
integer(c_size_t), intent(in) :: dims(4)

allocate(A4(dims(1), dims(2), dims(3), dims(4)))
Ac = c_loc(A4(1,1,1,1))
print *, "Fortran: A bound to Ac"

allocate(B4, mold=A4)
print *, "Fortran: B allocated"
Bc = c_loc(B4(1,1,1,1))
print *, "Fortran: B bound to Bc"

end subroutine alloc4


subroutine dealloc1(Ac, Bc) bind(C)
type(c_ptr), intent(inout) :: Ac, Bc

if (c_associated(Ac) .and. associated(A1)) then
  deallocate(A1)
end if

if (c_associated(Bc) .and. associated(B1)) then
  deallocate(B1)
end if

Ac = c_null_ptr
Bc = c_null_ptr

if (associated(A1)) nullify(A1)
if (associated(B1)) nullify(B1)

end subroutine dealloc1


subroutine dealloc2(Ac, Bc) bind(C)
type(c_ptr), intent(inout) :: Ac, Bc

if (c_associated(Ac) .and. associated(A2)) then
  deallocate(A2)
end if

if (c_associated(Bc) .and. associated(B2)) then
  deallocate(B2)
end if

Ac = c_null_ptr
Bc = c_null_ptr

if (associated(A2)) nullify(A2)
if (associated(B2)) nullify(B2)
end subroutine dealloc2


subroutine dealloc3(Ac, Bc) bind(C)
type(c_ptr), intent(inout) :: Ac, Bc

if (c_associated(Ac) .and. associated(A3)) then
  deallocate(A3)
end if

if (c_associated(Bc) .and. associated(B3)) then
  deallocate(B3)
end if

Ac = c_null_ptr
Bc = c_null_ptr

if (associated(A3)) nullify(A3)
if (associated(B3)) nullify(B3)
end subroutine dealloc3


subroutine dealloc4(Ac, Bc) bind(C)
type(c_ptr), intent(inout) :: Ac, Bc

if (c_associated(Ac) .and. associated(A4)) then
  deallocate(A4)
end if

if (c_associated(Bc) .and. associated(B4)) then
  deallocate(B4)
end if

Ac = c_null_ptr
Bc = c_null_ptr

if (associated(A4)) nullify(A4)
if (associated(B4)) nullify(B4)
end subroutine dealloc4


end module f_alloc
