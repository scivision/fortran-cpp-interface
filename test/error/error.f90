module error

use, intrinsic :: iso_c_binding, only : c_int
implicit none

contains

pure subroutine error_fortran(x) bind(C)

integer(c_int), intent(in) :: x

error stop x

end subroutine error_fortran

end module error
