!! https://stackoverflow.com/a/37837472
program alloc3

use, intrinsic :: iso_c_binding, only : c_float

implicit none

interface
subroutine alloc3d(x) bind(c)
  import c_float
  real(c_float), allocatable, intent(inout) :: x(:,:,:)
end subroutine

subroutine dealloc3d(x) bind(c)
  import c_float
  real(c_float), allocatable, intent(inout) :: x(:,:,:)
end subroutine
end interface

integer :: i
real(c_float), allocatable :: x(:,:,:)

allocate(x(6,2,5))
print *,"x has been allocated like x(", (LBOUND(x,i), UBOUND(x,i), i=1,3), ")"
!! C code will deallocate x

call alloc3d(x)
if (allocated(x)) then
  print *, "x has been allocated like x(", (LBOUND(x,i), UBOUND(x,i), i=1,3), ")"
endif

call dealloc3d(x)
if (allocated(x)) error stop "CFI_deallocate failed"

print *, "OK: CFI_allocate demo"

end program
