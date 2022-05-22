program array

use, intrinsic :: iso_c_binding, only : C_INT, C_SIZE_T

implicit none (type, external)

interface
subroutine timestwo(A, N) bind(C)
import
integer(C_INT), intent(inout) :: A(N)
integer(C_SIZE_T), intent(in) :: N
end subroutine
end interface

integer(C_SIZE_T), parameter :: N = 3

integer(C_INT) :: A(N)

A = [1,2,3]

call timestwo(A, N)
if(any(A /= [2,4,6])) error stop "fortran call timestwo failed"

print *, "OK: Fortran call timestwo()"

end program
