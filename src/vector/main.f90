program vector

use, intrinsic :: iso_c_binding, only: c_int
implicit none


interface
subroutine timestwo(a, a2, L)  bind (c)
import c_int
integer(c_int), value :: L
integer(c_int) :: a(L), a2(L)
end subroutine timestwo
end interface

integer(c_int) :: N, i
integer(c_int), allocatable :: x(:), x2(:)

N = 3

allocate(x(N), x2(N))

!! dummy data
do i=1,N
  x(i) = i
enddo

call timestwo(x, x2, N)

if (any(2*x /= x2)) error stop 'x2 /= 2*x'

end program
