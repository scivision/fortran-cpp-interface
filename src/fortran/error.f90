module utils

use, intrinsic :: iso_c_binding, only : c_int
implicit none (type, external)

contains

subroutine error_fortran(value) bind(C)

  integer(c_int), intent(in) :: value

  error stop value

end subroutine error_fortran

end module utils
