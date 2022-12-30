program array

use, intrinsic :: iso_c_binding, only : C_INT, C_SIZE_T

implicit none

interface
subroutine timestwo_c(v, N) bind(C)
import
integer(C_SIZE_T), intent(in) :: N
integer(C_INT), intent(inout) :: v(N)
end subroutine

subroutine timestwo_cpp(v, N) bind(C)
import
integer(C_SIZE_T), intent(in) :: N
integer(C_INT), intent(inout) :: v(N)
end subroutine
end interface

integer(C_INT) :: A(3)

A = [1,2,3]

call timestwo_c(A, size(A, kind=C_SIZE_T))
if(any(A /= [2,4,6])) error stop "fortran call timestwo_c failed"

call timestwo_cpp(A, size(A, kind=C_SIZE_T))
if(any(A /= [2,4,6])) error stop "fortran call timestwo_cpp failed"

print *, "OK: Fortran call timestwo()"

end program
