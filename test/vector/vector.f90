program vector

use, intrinsic :: iso_c_binding, only: C_INT, C_SIZE_T
implicit none


interface
subroutine timestwo_c(a, a2, L)  bind (c)
import
integer(C_SIZE_T), value :: L
integer(c_int) :: a(L), a2(L)
end subroutine

subroutine timestwo_cpp(a, a2, L)  bind (c)
import
integer(C_SIZE_T), value :: L
integer(c_int) :: a(L), a2(L)
end subroutine
end interface

integer(C_SIZE_T) :: N, i
integer(C_INT), allocatable :: x(:), x2(:)

N = 3

allocate(x(N), x2(N))

!! dummy data
do i=1,N
  x(i) = int(i, C_INT)
end do

call timestwo_c(x, x2, size(x, kind=C_SIZE_T))
if (any(2*x /= x2)) error stop 'x2 /= 2*x'

call timestwo_cpp(x, x2, size(x, kind=C_SIZE_T))
if (any(2*x /= x2)) error stop 'x2 /= 2*x'

deallocate(x, x2)

print *, "OK: Fortran vector"

end program
